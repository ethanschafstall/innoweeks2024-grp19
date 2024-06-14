import dotenv from 'dotenv'
import path from 'path'

// Determine the environment (default to development)
const env = process.env.NODE_ENV || 'development';

// Construct the path to the appropriate .env file
const envPath = path.resolve(__dirname, `.env.${env}`);

// Load shared environment variables
dotenv.config({ path: path.resolve(__dirname, '.env') });

// Load environment-specific variables
dotenv.config({ path: envPath });

console.log(`Environment: ${env}`);
console.log(`Config path: ${envPath}`);