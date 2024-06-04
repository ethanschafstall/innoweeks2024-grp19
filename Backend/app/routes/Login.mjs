import express from "express"; // Importing express for router creation
import { connectToDatabase } from "../tools/sqlConnection.mjs";
import { checkHash } from "../tools/hash.mjs";
import { generateToken } from "../tools/createToken.mjs";

const loginRoute = express(); // Creating a new instance of express router

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
loginRoute.post("/", connectToDatabaseMiddleware, async (req, res) => {
  const { username, password } = req.body;
  const queryString = `SELECT * FROM t_users WHERE useUsername = ?`;

  try {
      const [result] = await req.dbConnection.execute(queryString, [username]);
      const user = result[0];

      if (!user) {
          return res.status(401).json({ message: "Invalid username or password." });
      }

      const salt = user.useSalt;
      const storedHash = user.usePassword;

      if (storedHash !== checkHash(salt, password)) {
          return res.status(401).json({ message: "Invalid username or password." });
      }

      const message = `User has successfully logged in.`;
      const token = generateToken(user);

      res.cookie('authToken', token, {
          httpOnly: true, // Accessible only by web server
          secure: true, // Ensures the cookie is only sent over HTTPS
          sameSite: 'strict', // Ensures the cookie is sent only to the same site
          maxAge: 24 * 60 * 60 * 1000, // Cookie expires in 24 hours
          path: '/'
      });
    
      return res.status(200).json({ message, token});
  } catch (error) {
      console.error("Error logging in:", error);
      return res.status(500).json({ error: "Internal Server Error" });
  }
});


export { loginRoute }; // Exporting the router for use in other files