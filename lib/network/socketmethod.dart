import 'package:flutter/material.dart';
import 'package:game/network/gamemethods.dart';

import 'package:game/model/roomdata.dart';
import 'package:game/screen/gamescreen.dart';
import 'package:game/screen/mainmenu.dart';
import 'package:game/network/socketclient.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:game/utilities.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  Socket get socketClient => _socketClient;
  void createRoom(String nickname) {
    if (nickname.isEmpty) return;
    _socketClient.emit("createRoom", {
      "nickname": nickname,
    });
  }

  void joinRoom(String nickname, String roomID) {
    if (nickname.isNotEmpty && roomID.isNotEmpty) {
      _socketClient.emit("joinRoom", {
        "nickname": nickname,
        "roomID": roomID,
      });
    }
  }

  void listenToCreateRoom(BuildContext context, WidgetRef ref) {
    _socketClient.on("createSuccess", (room) {
      ref.read(roomDataProvider.notifier).updateRoom(room);

      Navigator.of(context).pushNamed(GameScreen.routename);
    });
  }

  void joinRoomSuccessListener(BuildContext context, WidgetRef ref) {
    _socketClient.on("joinSuccess", (room) {
      ref.read(roomDataProvider.notifier).updateRoom(room);
      Navigator.of(context).pushNamed(GameScreen.routename);
    });
  }

  void errorOnListener(BuildContext context) {
    _socketClient.on("errorOccured", (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListener(WidgetRef ref) {
    _socketClient.on("updatePlayers", (playerData) {
      ref.read(roomDataProvider.notifier).updatePlayerOne(playerData[0]);

      ref.read(roomDataProvider.notifier).updatePlayerTwo(playerData[1]);
    });
  }

  void tapGrid(int index, String roomID, List<String> displayElements) {
    if (displayElements[index] == "") {
      _socketClient.emit("tap", {
        "index": index,
        "roomID": roomID,
      });
    }
  }

  void tapListener(WidgetRef ref) {
    _socketClient.on("tapped", (data) {
      final roomData = ref.read(roomDataProvider.notifier);
      roomData.updateDisplayBoard(
        data["index"],
        data["choice"],
      );
      roomData.updateRoom(data["room"]);
      Gamemethods().checkWinner(ref.context, ref, _socketClient);
    });
  }

  void updateRoomListener(WidgetRef ref) {
    _socketClient.on("updateRoom", (data) {
      ref.read(roomDataProvider.notifier).updateRoom(data);
    });
  }

  void pointIncreaseListener(WidgetRef ref) {
    _socketClient.on("pointIncrease", (playerData) {
      final roomData = ref.read(roomDataProvider);
      final roomDataMethods = ref.read(roomDataProvider.notifier);
      if (playerData["socketID"] == roomData.playerOne.socketID) {
        roomDataMethods.updatePlayerOne(playerData);
      } else {
        roomDataMethods.updatePlayerTwo(playerData);
      }
    });
  }

  void endGameListener(WidgetRef ref) {
    _socketClient.on("endGame", (playerData) {
      showGameDialog(ref.context, "${playerData["nickname"]} has won the game !", ref);
      Navigator.popUntil(ref.context, (route) => route.settings.name == MainMenu.routename);
    });
  }
}
