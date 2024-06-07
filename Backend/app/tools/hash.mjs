import CryptoJS from "crypto-js";
import dotenv from 'dotenv';

dotenv.config();

const pepper = process.env.PEPPER;


export function generateHash(message) {
  const salt = addSalt(message.length);
  const hash = CryptoJS.SHA256(salt + message + pepper);
  return [hash.toString(CryptoJS.enc.Hex), salt];
}

export function checkHash(salt, message) {
  const hash = CryptoJS.SHA256(salt + message + pepper);
  return hash.toString(CryptoJS.enc.Hex);
}

function addSalt(passwordLength) {
  const desiredSaltLength = 15;
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  const charactersLength = characters.length;
  
  let salt = '';
  for (let i = 0; i < passwordLength; i++) {
      salt += characters.charAt(Math.floor(Math.random() * charactersLength));
  }
  
  while (salt.length < desiredSaltLength) {
      salt += salt;
  }
  salt = salt.slice(0, desiredSaltLength);
  
  return salt;
}

