import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:game/model/roomdata.dart";

import 'package:socket_io_client/socket_io_client.dart';
import "package:game/utilities.dart";

class Gamemethods {
  void checkWinner(BuildContext context, WidgetRef ref, Socket socketClent) {
    final roomData = ref.read(roomDataProvider);

    String winner = '';

    // Checking rows
    if (roomData.displayElements[0] == roomData.displayElements[1] &&
        roomData.displayElements[0] == roomData.displayElements[2] &&
        roomData.displayElements[0] != '') {
      winner = roomData.displayElements[0];
    }
    if (roomData.displayElements[3] == roomData.displayElements[4] &&
        roomData.displayElements[3] == roomData.displayElements[5] &&
        roomData.displayElements[3] != '') {
      winner = roomData.displayElements[3];
    }
    if (roomData.displayElements[6] == roomData.displayElements[7] &&
        roomData.displayElements[6] == roomData.displayElements[8] &&
        roomData.displayElements[6] != '') {
      winner = roomData.displayElements[6];
    }

    // Checking Column
    if (roomData.displayElements[0] == roomData.displayElements[3] &&
        roomData.displayElements[0] == roomData.displayElements[6] &&
        roomData.displayElements[0] != '') {
      winner = roomData.displayElements[0];
    }
    if (roomData.displayElements[1] == roomData.displayElements[4] &&
        roomData.displayElements[1] == roomData.displayElements[7] &&
        roomData.displayElements[1] != '') {
      winner = roomData.displayElements[1];
    }
    if (roomData.displayElements[2] == roomData.displayElements[5] &&
        roomData.displayElements[2] == roomData.displayElements[8] &&
        roomData.displayElements[2] != '') {
      winner = roomData.displayElements[2];
    }

    // Checking Diagonal
    if (roomData.displayElements[0] == roomData.displayElements[4] &&
        roomData.displayElements[0] == roomData.displayElements[8] &&
        roomData.displayElements[0] != '') {
      winner = roomData.displayElements[0];
    }
    if (roomData.displayElements[2] == roomData.displayElements[4] &&
        roomData.displayElements[2] == roomData.displayElements[6] &&
        roomData.displayElements[2] != '') {
      winner = roomData.displayElements[2];
    }

    if (winner != '') {
      if (roomData.playerOne.playerMark == winner) {
        showGameDialog(context, '${roomData.playerOne.nickname} won!', ref);
        socketClent.emit('winner', {
          'winnerSocketId': roomData.playerOne.socketID,
          'roomID': roomData.roomData['_id'],
        });
      } else {
        showGameDialog(context, '${roomData.playerTwo.nickname} won!', ref);
        socketClent.emit('winner', {
          'winnerSocketId': roomData.playerTwo.socketID,
          'roomID': roomData.roomData['_id'],
        });
      }
    } else if (roomData.filledBoxCount >= 10) {
      winner = '';
      showGameDialog(context, 'Draw', ref);
    }
  }

  void clearBoard(BuildContext context, WidgetRef ref) {
    final roomData = ref.read(roomDataProvider.notifier);
    final boardData = ref.read(roomDataProvider).displayElements;
    for (int i = 0; i < boardData.length; i++) {
      roomData.updateDisplayBoard(i, "");
    }
    roomData.updateFilledBoxesToZero();
  }
}
