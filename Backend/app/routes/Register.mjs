
import express from "express";
import { connectToDatabase } from "../tools/sqlConnection.mjs";
import { generateHash } from "../tools/hash.mjs";
import { CheckDataType } from "../tools/TypeChecker.mjs";

const registerRoute = express(); // Creating a new instance of express router

const connectToDatabaseMiddleware = async (req, res, next) => {
    try {
      req.dbConnection = await connectToDatabase();
      next();
    } catch (error) {
      console.error("Error connecting to the database:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
};

// Endpoint for handling user login
registerRoute.post('/', connectToDatabaseMiddleware, async (req, res) => {
  const { username, password} = req.body;
  const [hashedPassword, salt] = generateHash(password);

  if (!CheckDataType(username, "string")) {
    return res.status(401).json({ error: "Invalid value types" });
  }

  const existingUserQuery = `SELECT * FROM t_users WHERE useUsername = ?;`;
  try {
    const [existingUser] = await req.dbConnection.execute(existingUserQuery,[username]);
    
    if (existingUser.length >= 1) {
      return res.status(200).json({ error: 'A user with the provided username already exists. Please choose a different username.' });
    }
    
    const registerUserQuery = `INSERT INTO t_users (useUsername, usePassword, useRole, useSalt) VALUES (?, ?, ?, ?)`;

    const role = 'user';
    const [registerUser] = await req.dbConnection.execute(registerUserQuery, [username, hashedPassword, role, salt]);

    if (registerUser.affectedRows === 1) {
      const message = `User has successfully registered.`;
      return res.status(200).json({ message });
    } else {
      res.status(401).json({ error: "Failed to register user." });
    }
  } catch (error) {
    console.error("Error registering user:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

export { registerRoute };