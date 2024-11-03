import "package:flutter/material.dart";
import "package:game/model/roomdata.dart";
import "package:game/widgets/customTextField.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class WaitingLobby extends ConsumerStatefulWidget {
  const WaitingLobby({super.key});

  @override
  ConsumerState<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends ConsumerState<WaitingLobby> {
  late TextEditingController roomKey;

  @override
  void initState() {
    super.initState();
    roomKey = TextEditingController(text: ref.read(roomDataProvider).roomData["_id"]);
  }

  @override
  void dispose() {
    roomKey.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Waiting For A Player"),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          controller: roomKey,
          isReadOnly: true,
        )
      ],
    );
  }
}
