import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:game/views/gameboard.dart";
import "package:game/model/roomdata.dart";
import "package:game/views/scoreboard.dart";
import "package:game/screen/waitinglobby.dart";
import "package:game/network/socketmethod.dart";

class GameScreen extends ConsumerStatefulWidget {
  static const String routename = "/game";
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateRoomListener(ref);
    _socketMethods.updatePlayersStateListener(ref);
    _socketMethods.pointIncreaseListener(ref);
    _socketMethods.endGameListener(ref);
  }

  @override
  Widget build(BuildContext context) {
    final currentRoomData = ref.watch(roomDataProvider);

    return Scaffold(
      body: !currentRoomData.roomData['isRoomFilled']
          ? const WaitingLobby()
          : SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Scoreboard(),
                  const Board(),
                  Text("${currentRoomData.roomData["turn"]["nickname"]}'s Turn")
                ],
              ),
            ),
    );
  }
}
