// Import necessary libraries
import https from 'node:https';
import http from 'node:http';
import fs from 'node:fs';
import express from 'express';

// Import real-time communication libraries for notifications
import mqtt from 'mqtt';
import { Server as SocketIOServer } from 'socket.io';
import { HubConnectionBuilder } from '@microsoft/signalr';

// Import routes 
import userRoute from './routes/User.mjs';
import registerRoute from './routes/Register.mjs';
import feelingsRoute from './routes/Feelings.mjs';
import loginRoute from './routes/Login.mjs';
import adminRoute from './routes/Admin.mjs';
import { testRoute } from './routes/Test.mjs';
import friendsGroupRoute from './routes/FriendsGroup.mjs';
import friendsRoute from './routes/Friends.mjs';


// Middleware
import { databaseConnectionMiddleware } from "./services/connectToDatabase.mjs";
import cors from 'cors'

// Tools
import cookieParser from 'cookie-parser';
import bodyParser from 'body-parser';

// Read SSL certificate and key files
const options = {
  key: fs.readFileSync('openssl/privateKey.key'),
  cert: fs.readFileSync('openssl/certificate.crt'),
};

// Initialize app
const app = express();
const server = https.createServer(options, app)

const mqttClient = mqtt.connect('mqtt://broker.hivemq.com');
const io = new SocketIOServer(server);

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
app.use('/test', testRoute);
app.use('/feeling', feelingsRoute);
app.use('/friendsGroup', friendsGroupRoute)
app.use('/friend', friendsRoute)


// socket.io connection handling
io.on('connection', (socket) => {
  console.log('a user connected');
  socket.on('disconnect', () => {
    console.log('user disconnected');
  });
});


// Define ports for HTTP and HTTPS
const portHttp = 443;
const portHttps = 4433;

// Start the HTTPS server
server.listen(portHttps, () => {
  console.log(`Server HTTPS running on https://localhost:${portHttps}`);
});

// Start the HTTP server
http.createServer(app).listen(portHttp, () => {
  console.log(`Server HTTP running on http://localhost:${portHttp}`);
});
