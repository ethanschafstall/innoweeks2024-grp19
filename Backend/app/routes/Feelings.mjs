import express from "express";
import { getFeelingsByUserId, getLastFeeling, postFeeling } from "../controllers/FeelingsController.mjs";

const router = express.Router();
router.post('/',  postFeeling);
router.get('/:id', getFeelingsByUserId);
router.get('/last', getLastFeeling);

export default router;