import "package:flutter/material.dart";
import "package:game/widgets/responsive.dart";
import "package:game/network/socketmethod.dart";
import "package:game/widgets/buttons.dart";
import "package:game/widgets/customTextField.dart";
import "package:game/widgets/textWidget.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class JoinRoom extends ConsumerStatefulWidget {
  static const String routename = "/join-room";
  const JoinRoom({super.key});

  @override
  ConsumerState<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends ConsumerState<JoinRoom> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController roomidcontroller = TextEditingController();
  final methods = SocketMethods();

  void joinRoom(String nickname, String roomID) {
    methods.joinRoom(nickname, roomID);
  }

  @override
  void initState() {
    super.initState();
    methods.joinRoomSuccessListener(context, ref);
    methods.errorOnListener(context);
    methods.updatePlayersStateListener(ref);
  }

  @override
  void dispose() {
    namecontroller.dispose();
    roomidcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Responsive(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(
                text: "Join Room",
                fontSize: 70,
                weight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 40,
                    color: Color.fromARGB(255, 104, 1, 95),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.075,
              ),
              CustomTextField(controller: namecontroller, hintText: "Your NickName"),
              SizedBox(
                height: size.height * 0.06,
              ),
              CustomTextField(controller: roomidcontroller, hintText: "Room ID"),
              SizedBox(
                height: size.height * 0.06,
              ),
              Button(
                title: "Join",
                icon: Icons.play_arrow,
                callbackFunction: () => {
                  joinRoom(
                    namecontroller.text,
                    roomidcontroller.text,
                  )
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
