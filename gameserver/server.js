const Room = require("./room.js");
const { error } = require("console");
const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const app = express();
require("dotenv").config();

const port = process.env.PORT;
var server = http.createServer(app);
const serverAddress = process.env.serverAddress;
var socketio = require("socket.io")(server);

app.use(express.json());

const DB = process.env.DB_HOST;
socketio.on("connection", (socket) => {
  console.log("connected");
  try {
    socket.on("createRoom", async ({ nickname }) => {
      let room = new Room();
      let player = {
        socketID: socket.id,
        nickname,
        playerMark: "X",
      };

      room.players.push(player);
      room.turn = player;
      room = await room.save();

      const roomId = room._id.toString();
      socket.join(roomId);

      socketio.to(roomId).emit("createSuccess", room);
    });
  } catch (error) {
    console.log(error);
  }

  socket.on("joinRoom", async ({ nickname, roomID }) => {
    console.log("init joining process");
    try {
      if (!roomID.match(/^[0-9a-fA-F]{24}$/)) {
        socket.emit("Error Occured! Invalid Room ID");
        return;
      }

      let room = await Room.findById(roomID);

      if (!room.isRoomFilled) {
        let player = {
          nickname,
          socketID: socket.id,
          playerMark: "O",
        };
        socket.join(roomID);
        room.players.push(player);
        room.isRoomFilled = true;
        room = await room.save();

        socketio.to(roomID).emit("joinSuccess", room);

        socketio.to(roomID).emit("updatePlayers", room.players);
        socketio.to(roomID).emit("updateRoom", room);
      } else {
        socket.emit("errorOccured", "The Game is Already in Progress");
      }
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("tap", async ({ index, roomID }) => {
    try {
      let room = await Room.findById(roomID);
      let choice = room.turn.playerMark;

      if (room.turnIndex == 0) {
        room.turn = room.players[1];
        room.turnIndex = 1;
      } else {
        room.turn = room.players[0];
        room.turnIndex = 0;
      }
      room = await room.save();
      socketio.to(roomID).emit("tapped", {
        index,
        choice,
        room,
      });
    } catch (error) {
      console.log(error);
    }
  });

  socket.on("winner", async ({ winnerSocketId, roomID }) => {
    try {
      console.log(winnerSocketId);
      console.log(roomID);
      let room = await Room.findById(roomID);
      let player = room.players.find(
        (playerr) => playerr.socketID == winnerSocketId
      );

      player.points += 1;
      room = await room.save();

      if (player.points >= room.maxRounds) {
        socketio.to(roomID).emit("endGame", player);
      } else {
        socketio.to(roomID).emit("pointIncrease", player);
      }
    } catch (error) {
      console.log(error);
    }
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log("Successfully Connected to Mongo");
  })
  .catch((error) => {
    console.log(error);
  });

server.listen(port, serverAddress, () => {
  console.log(`Server Listening on ${port}`);
});

// password : lUfMDZgjYjVZV5rc
