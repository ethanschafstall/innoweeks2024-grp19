// Import necessary libraries
import https from 'node:https';
import http from 'node:http';
import fs from 'node:fs';
import express from 'express';
import userRoute from './routes/User.mjs';
import { loginRoute } from './routes/login.mjs';
import { testRoute } from './routes/Test.mjs';
import { registerRoute } from './routes/Register.mjs';
import adminRoute from './routes/Admin.mjs';
import cors from 'cors'
import cookieParser from 'cookie-parser';

// Read SSL certificate and key files
const options = {
  key: fs.readFileSync('openssl/privateKey.key'),
  cert: fs.readFileSync('openssl/certificate.crt'), // Make sure this path and file extension are correct
};

// Initialize the Express application
const app = express();
app.use(cors());
app.use(cookieParser());
// Middleware for parsing JSON responses
app.use(express.json());

// Define routes
app.use('/users', adminRoute);
app.use('/user', userRoute);
app.use('/login', loginRoute);
app.use('/register', registerRoute);
app.use('/test', testRoute);

// Define ports for HTTP and HTTPS
const portHttp = 443;  // Standard HTTP port
const portHttps = 4433;  // Standard HTTPS port

// Start the HTTPS server
https.createServer(options, app).listen(portHttps, () => {
  console.log(`Server HTTPS running on https://localhost:${portHttps}`);
});

// Start the HTTP server
http.createServer(app).listen(portHttp, () => {
  console.log(`Server HTTP running on http://localhost:${portHttp}`);
});
