import express from "express";
// import { } from "../controllers/FeelingsController.mjs";
import { connectToDatabase } from "../tools/sqlConnection.mjs";
import { setFeeling } from "../controllers/FeelingsController.mjs";

const connectToDatabaseMiddleware = async (req, res, next) => {
    try {
      req.dbConnection = await connectToDatabase();
      next();
    } catch (error) {
      console.error("Error connecting to the database:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
};
const router = express.Router();

// Route for getting a single feeling from a user (other than self) for notification
// router.get ('/:id', connectToDatabaseMiddleware, getFeeling);

// Route for geting all the feeling from user
// router.get ('/:username', connectToDatabaseMiddleware, getFeelings);

// Route for creating a new feeling
router.post('/', connectToDatabaseMiddleware, setFeeling);

export default router;