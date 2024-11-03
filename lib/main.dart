import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:game/screen/create-room.dart";
import "package:game/screen/gamescreen.dart";
import "package:game/screen/join-room.dart";
import "package:game/screen/mainmenu.dart";
import "package:game/utilities.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: "Application",
        theme:
            ThemeData.dark(useMaterial3: true).copyWith(scaffoldBackgroundColor: backgroundColor),
        routes: {
          MainMenu.routename: (context) => const MainMenu(),
          JoinRoom.routename: (context) => const JoinRoom(),
          CreateRoom.routename: (context) => const CreateRoom(),
          GameScreen.routename: (context) => const GameScreen(),
        },
        initialRoute: MainMenu.routename,
      ),
    );
  }
}
