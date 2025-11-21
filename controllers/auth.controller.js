const db = require("../config/db")
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const fullnameFromPerson = (p) => {
    if (!p) return null;
    const parts = [];
    if (p.firstname) parts.push(p.firstname);
    if (p.middlename) parts.push(p.middlename);
    if (p.lastname) parts.push(p.lastname);
    return parts.join(" ");
}


exports.register = async (req, res) => {
    if (!req.body) return res.status(400).json({ message: "Request body is empty" });
    const { firstname, middlename, lastname, sex, email, username, password } = req.body;

    if (!username) return res.status(400).json({ message: "Username is required" });
    if (!email) return res.status(400).json({ message: "Email is required" });
    if (!password) return res.status(400).json({ message: "Password is required" });
    if (password.length < 6) return res.status(400).json({ message: "Password must be at least 6 characters" });
    if (!firstname) return res.status(400).json({ message: "First name is required" });
    if (!lastname) return res.status(400).json({ message: "Last name is required" });
    if (!sex) return res.status(400).json({ message: " Gender is required" });


    const pool = db.promise();

    const conn = await pool.getConnection();
    try {
        await conn.beginTransaction();

        const [existingUser] = await conn.query(
            "SELECT user_id from user where username = ? OR email = ? LIMIT 1", [username, password]
        );
        if (existingUser.length > 0){
            await conn.rollback();
            return res.status(400).json({
                status: "error",
                message: "Username or Email already exists"
            });
        }

        const [existingPerson] = await conn.query(
            "SELECT bpar_i_person_id from bpar_i_person where firstname = ? AND middlename = ? AND lastname = ? LIMIT 1",
            [firstname, middlename || "", lastname]
        );
        if(existingPerson.length > 0){
            await conn.rollback();
            return  res.status(400).json({
                status: "error",
                message: "Person with the same name already exists"
            });
        }

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            await conn.rollback();
            return res.status(400).json({
                status: "error",
                message: "Invalid email format"
            });
        }

        const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$/;
        if (!passwordRegex.test(password)) {
            await conn.rollback();
            return res.status(400).json({
                status: "error",
                message: "Password must be at least 6 characters long and contain both letters and numbers"
            });
        }
        
        let [guestRole] = await conn.query(
            "SELECT role_id FROM ROLE WHERE role = 'GUEST' AND is_active = 1 LIMIT 1"
        )
        let guestRoleId;
        if (guestRole.length === 0){
            const [insertRole] = await conn.query(
                "INSERT INTO ROLE (role, date_created, is_active) VALUES ('GUEST', NOW(), 1)"
            );
            guestRoleId = insertRole.insertId;
        }else {
            guestRoleId = guestRole[0].role_id;
        }

        const nameParts = [firstname];
        if (middlename) nameParts.push(middlename.nameParts.push(lastname));
        const fullname = nameParts.join(" ");

        const [personResult] = await conn.query(
            `INSERT INTO bpar_i_person (name, firstname ,middlename , lastname, sex, date_created, is_active) VALUES (?,?,?,?,?, NOW(), 1)`,
            [fullname, firstname, middlename || "", lastname, sex]
        );
        const bpar_i_person_id = personResult.insertId;

        const hashed = bcrypt.hashSync(password, 10);
        const [userResult] = await conn.query(
            `INSERT INTO USER (username, email, password) VALUES (?,?,?)`,
            [username, email, hashed]
        );

        const user_id = userResult.insertId;

        const [accountResult] = await conn.query(
            `INSERT INTO user_account (date_registered , date_created, is_active, bpar_i_person_id, user_id) VALUES (NOW(), NOW(), 1, ?, ?)`, 
            [bpar_i_person_id, user_id]
        );

        const user_account_id = accountResult.insertId;

        const [role_matching] = await conn.query(
            `INSERT INTO user_role_matching (user_id, role_id, date_created, is_active) VALUES (?,?, NOW(), 1)`, 
            [user_id, guestRoleId]
        );

        await conn.query(
            `INSERT INTO user_account_logs (user_account_id, date_registered, bpar_i_person_id, date_created, logs_action, logs_status, bparIPersonIdMaker, is_active) VALUES ( ?,NOW(),?, NOW(), ?, ?, ?, 1)`, 
            [user_account_id, personResult.insertId, "NEW", "APPROVED", personResult.insertId]
        )

        await conn.query(`
            INSERT INTO user_role_matching_logs (user_role_matching_id, user_id, role_id, date_created, logs_action, logs_status, bparIPersonIdMaker,is_active) VALUES (?,?,?, NOW(), ?,? ,?, 1)`,
             [role_matching.insertId, user_id, guestRoleId, "NEW", "APPROVED", personResult.insertId]);

             await conn.commit();
             res.json({
                status: "success",
                message: "User registered successfully",
                data: {
                    user_id,
                    user_account_id,
                    bpar_i_person_id,
                    role_id: guestRoleId,
                    fullname
                }
             });
    } catch (err) {
        await conn.rollback();
        console.error("Registration failed: ", err);
        res.status(500).json({ 
            message: "Registration failed", error: err 
        });
    } finally{
        conn.release();
    }
}

exports.login = (req, res) => {
    if (!req.body) return res.status(400).json({ message: "Request body is empty" });
    const { usernameOrEmail, password } = req.body;
    if (!usernameOrEmail || !password) return res.status(400).json({ message: "Username/Email and password are required" });

    const sql = `SELECT 
    u.user_id,
    u.username,
    u.password,
    u.email,
    matc.role_id,
    r.role, 
    ua.bpar_i_person_id,
    p.firstname,
    p.middlename,
    p.lastname
    FROM USER u
    LEFT JOIN user_role_matching matc ON matc.user_id = u.user_id
    LEFT JOIN role r ON r.role_id = matc.role_id
    LEFT JOIN user_account ua ON ua.user_id = u.user_id
    LEFT JOIN bpar_i_person p ON p.bpar_i_person_id = ua.bpar_i_person_id
    WHERE (u.email = ? OR u.username = ? )
    AND (u.deactivated_date IS NULL)
    LIMIT 1
`;

    db.query(sql, [usernameOrEmail, usernameOrEmail], (err, results) => {
        if (err) return res.status(500).json({ error: err });
        if (results.length === 0) return res.status(401).json({ message: "Invalid username/email" });

        const user = results[0];

        const match = bcrypt.compareSync(password, user.password);
        if (!match) return res.status(401).json({ message: "Invalid password" });

        const payload = {
            user_id: user.user_id,
            role: user.role.role,
            person_id: user.bpar_i_person_id || null,
            username: user.username
        };

        const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRE || "1d" });

        const userObj = {
            id: user.user_id,
            username: user.username,
            email: user.email,
            role: user.role_id,
            name: fullnameFromPerson(user) ,
            person_id: user.bpar_i_person_id
        };
        return res.json({
            status: "success",
            token,
            user: userObj
        });
    });
}