import express from "express";
import { getAllUsers, getUsers } from "../controllers/AdminController.mjs";

const router = express.Router();

router.get('/users', getAllUsers);
router.get('/:username', getUsers);

export default router;