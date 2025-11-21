const mysql = require('mysql2');

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT,
  waitForConnections: true,
  queueLimit: 0,
});

db.getConnection((err, connection) => {
  if (err) {
    console.error('Error connecting to the database:', err);
    }else {
        console.log('Database connected successfully');
        connection.release();
    }
});

module.exports = db;