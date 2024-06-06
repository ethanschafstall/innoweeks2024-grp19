import mysql from "mysql2/promise";
import dotenv from 'dotenv';

dotenv.config();

const host = process.env.DB_HOST;
const port = process.env.DB_PORT;
const user = process.env.DB_USER;
const password = process.env.DB_PASSWORD;
const database = process.env.DB_DATABASE;

const dbConfig = {
    host: host,
    port: port,
  user: user,
  password: password,
  database: database
};

export const connect = async () => {
  try {
    const connection = await mysql.createConnection(dbConfig);
    console.log("Connected to the database");
    return connection;
  } catch (error) {
    console.error("Error connecting to the database:", error);
    throw error;
  }
};

export const databaseConnectionMiddleware = async (req, res, next) => {
  try {
    req.dbConnection = await connect();
    next();
  } catch (error) {
    console.error("Error connecting to the database:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};
