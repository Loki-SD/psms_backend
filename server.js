require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();

app.use(cors());
app.use(express.json());

const db = require("./config/db");

app.get("/", (req, res) => {
    res.send("API is running...");
});

// const sampleRoute = require("./routes/sample.routes");
// app.use("/api", sampleRoute);

const authRoute = require("./routes/auth.routes");
app.use("/auth", authRoute);

const protectedRoutes = require("./routes/protected.routes");
app.use("/api", protectedRoutes);

app.listen(process.env.PORT || 5000, () => {
    console.log(`Server running on http://localhost:${process.env.PORT}`);
});