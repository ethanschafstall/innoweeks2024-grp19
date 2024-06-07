import express from "express";
import { postFeeling } from "../controllers/FeelingsController.mjs";
import { getFeelingsByUserId, getLastFeelingByUserId } from "../controllers/FeelingsController.mjs";

const router = express.Router();
router.post('/',  postFeeling);
router.get('/:id', getFeelingsByUserId);
router.get('/:id/last', getLastFeelingByUserId);

export default router;