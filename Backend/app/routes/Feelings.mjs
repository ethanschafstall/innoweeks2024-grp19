import express from "express";
import { postFeeling } from "../controllers/FeelingsController.mjs";

const router = express.Router();

router.post('/',  postFeeling);

export default router;