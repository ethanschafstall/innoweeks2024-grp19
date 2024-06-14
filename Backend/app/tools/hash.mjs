import CryptoJS from "crypto-js";
import dotenv from 'dotenv';
import crypto from 'crypto'

dotenv.config();

const pepper = process.env.PEPPER;

export const random= () => { crypto.randomBytes(256).toString('base64')}

export const authentication = (password, salt) => { 
  return CryptoJS.SHA256(salt + password + pepper).toString(CryptoJS.enc.Hex)
}
