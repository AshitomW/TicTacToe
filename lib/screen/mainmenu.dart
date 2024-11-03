import 'package:flutter/material.dart';
import 'package:game/widgets/responsive.dart';
import 'package:game/screen/create-room.dart';
import 'package:game/screen/join-room.dart';
import 'package:game/widgets/buttons.dart';

class MainMenu extends StatelessWidget {
  static const String routename = "/main-menu";

  void navigateToCreateRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routename);
  }

  void navigateToJoinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoom.routename);
  }

  const MainMenu({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Responsive(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Tic Tac Toe",
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 20, color: Colors.blueAccent)]),
              ),
              Column(
                children: [
                  Button(
                    title: "Create Room",
                    icon: Icons.play_arrow,
                    callbackFunction: () => navigateToCreateRoom(context),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Button(
                    title: "Join Room",
                    icon: Icons.group,
                    callbackFunction: () {
                      navigateToJoinRoom(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
