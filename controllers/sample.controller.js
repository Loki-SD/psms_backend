const db = require("../config/db");

exports.test = (req, res) => {
  db.query("SELECT NOW() as server_time", (err, results) => {   
    if (err) return res.status(500).send(err);
    res.json({
        message: "Test route working",
        time: results[0].server_time
    });
  });
};