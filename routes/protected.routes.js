const express = require('express');
const router = express.Router();
const {verifyToken} = require('../middleware/authMiddleware');

router.get("/me", verifyToken, (req, res) => {
    res.json({message: "You are authenticated", user: req.user});
});

module.exports = router;