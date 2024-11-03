// ignore_for_file: non_constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:game/model/player.dart';

class RoomData {
  final Map<String, dynamic> roomData;
  final Player _player_one;
  final Player _player_two;
  final List<String> _displayElements;
  final int _filledboxes;

  RoomData(
      {required this.roomData,
      required Player player_one,
      required Player player_two,
      required List<String> displayElements,
      required int filledboxes})
      : _player_one = player_one,
        _player_two = player_two,
        _displayElements = displayElements,
        _filledboxes = filledboxes;

  // Method to get room data
  Map<String, dynamic> get roomdata => roomData;
  Player get playerOne => _player_one;
  Player get playerTwo => _player_two;
  List<String> get displayElements => _displayElements;
  int get filledBoxCount => _filledboxes;

  // Method to update the entire room data
  RoomData _updateRoom(Map<String, dynamic> newData) {
    return RoomData(
      roomData: {...roomData, ...newData},
      player_one: playerOne,
      player_two: playerTwo,
      displayElements: _displayElements,
      filledboxes: _filledboxes,
    );
  }

  // Method to update player one data
  RoomData _updatePlayerOne(Map<String, dynamic> newPlayerOne) {
    return RoomData(
      roomData: roomData,
      player_one: Player.fromMap(newPlayerOne),
      player_two: playerTwo,
      displayElements: _displayElements,
      filledboxes: _filledboxes,
    );
  }

  // Method to update player two data
  RoomData _updatePlayerTwo(Map<String, dynamic> newPlayerTwo) {
    return RoomData(
      roomData: roomData,
      player_one: playerOne,
      player_two: Player.fromMap(newPlayerTwo),
      displayElements: _displayElements,
      filledboxes: _filledboxes,
    );
  }

  RoomData _updateMarkedPositions(List<String> displayElements) {
    return RoomData(
      roomData: roomData,
      player_one: playerOne,
      player_two: playerTwo,
      displayElements: displayElements,
      filledboxes: _filledboxes,
    );
  }

  RoomData _updateFilledBoxes(int count) {
    return RoomData(
      roomData: roomData,
      player_one: playerOne,
      player_two: playerTwo,
      displayElements: displayElements,
      filledboxes: count + 1,
    );
  }
}

class RoomDataNotifier extends StateNotifier<RoomData> {
  RoomDataNotifier()
      : super(
          RoomData(
            roomData: {},
            player_one: Player(nickname: "", socketID: "", points: 0, playerMark: "X"),
            player_two: Player(nickname: "", socketID: "", points: 0, playerMark: "0"),
            filledboxes: 0,
            displayElements: ['', '', '', '', '', '', '', '', ''],
          ),
        );

  void updateRoom(Map<String, dynamic> data) {
    state = state._updateRoom(data);
  }

  void updatePlayerOne(Map<String, dynamic> data) {
    state = state._updatePlayerOne(data);
  }

  void updatePlayerTwo(Map<String, dynamic> data) {
    state = state._updatePlayerTwo(data);
  }

  void updateDisplayBoard(int index, String choice) {
    List<String> newPosition = List.from(state.displayElements);
    newPosition[index] = choice;
    state = state._updateFilledBoxes(state.filledBoxCount);
    state = state._updateMarkedPositions(newPosition);
  }

  void updateFilledBoxesToZero() {
    state = state._updateFilledBoxes(0);
  }
}

final roomDataProvider =
    StateNotifierProvider<RoomDataNotifier, RoomData>((ref) => RoomDataNotifier());
