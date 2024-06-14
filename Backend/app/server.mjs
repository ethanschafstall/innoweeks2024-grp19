// Import necessary libraries
import http from 'node:http';
import express from 'express';

// Import routes 
import userRoute from './routes/User.mjs';
import registerRoute from './routes/Register.mjs';
import feelingsRoute from './routes/Feelings.mjs';
import loginRoute from './routes/Login.mjs';
import adminRoute from './routes/Admin.mjs';
import friendsRoute from './routes/Friends.mjs';
import groupsRoute from './routes/Groups.mjs'


// Middleware
import { databaseConnectionMiddleware } from "./services/connectToDatabase.mjs";
import cors from 'cors'

// Tools
import cookieParser from 'cookie-parser';
import bodyParser from 'body-parser';

// Initialize app
const app = express();

// Apply middleware & tools to app
app.use(express.json());
app.use(databaseConnectionMiddleware);
app.use(cors());
app.use(cookieParser());
app.use(bodyParser.json());

// Define routes
app.use('/users', adminRoute);
app.use('/user', userRoute);
app.use('/login', loginRoute);
app.use('/register', registerRoute);
app.use('/feelings', feelingsRoute);
app.use('/friends', friendsRoute);
app.use('/groups', groupsRoute);


// Define ports for HTTP and HTTPS
const portHttp = 443;

// Start the HTTP server
http.createServer(app).listen(portHttp, () => {
  console.log(`Server HTTP running on http://localhost:${portHttp}`);
});
