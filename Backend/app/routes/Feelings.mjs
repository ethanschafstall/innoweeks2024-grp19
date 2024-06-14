import express from "express";
import { getFeelingsByUserId, getLastFeelingByUserId, postFeeling, getFriendsFeelings } from "../controllers/FeelingsController.mjs";

const router = express.Router();
router.post('/',  postFeeling);
router.get('/:id', getFeelingsByUserId);
router.get('/:id/last', getLastFeelingByUserId);
router.get('/', getFriendsFeelings)

export default router;