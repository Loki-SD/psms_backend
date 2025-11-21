const jwt = require('jsonwebtoken');

exports.verifyToken = (req, res, next) => {
    const authHeader = req.headers["authorization"] || req.headers["Authorization"];
    if (!authHeader) return res.status(401).json({message: "No token provided"});

    const parts = authHeader.split(" ");
    const token = parts.length === 2 ? parts[1] : null;
    if (!token) return res.status(401).json({message: "Invalid token format"});

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) return res.status(401).json({message: "Token invalid or expired"});
        req.user = decoded;
        next();
    });
};

exports.requireRole = (roleName) => (req, res, next) => {
    if (!req.user) return res.status(401).json({message: "Unauthorized"});
    if (req.user.role !== roleName) return res.status(403).json({message: "Forbidden"});
    next();
};