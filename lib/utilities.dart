import "package:flutter/material.dart";
import "package:game/network/gamemethods.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

const backgroundColor = Color.fromRGBO(22, 20, 21, 1);

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void showGameDialog(BuildContext context, String text, WidgetRef ref) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Gamemethods().clearBoard(context, ref);
                Navigator.pop(context);
              },
              child: const Text("Play Again"),
            ),
          ],
        );
      });
}
