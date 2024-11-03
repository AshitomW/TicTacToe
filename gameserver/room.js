const mongo = require("mongoose");

const playerSchema = new mongo.Schema({
  nickname: {
    type: String,
    trim: true,
  },
  socketID: {
    type: String,
  },
  points: {
    type: Number,
    default: 0,
  },
  playerMark: {
    required: true,
    type: String,
  },
});

const roomSchema = new mongo.Schema({
  occupancy: {
    type: Number,
    default: 2,
  },
  maxRounds: {
    type: Number,
    default: 6,
  },
  currentRound: {
    required: true,
    type: Number,
    default: 1,
  },
  players: [playerSchema],
  isRoomFilled: {
    type: Boolean,
    default: false,
  },
  turn: playerSchema,
  turnIndex: {
    type: Number,
    default: 0,
  },
});

module.exports = mongo.model("Room", roomSchema);
