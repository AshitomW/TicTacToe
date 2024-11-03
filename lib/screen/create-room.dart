import "package:flutter/material.dart";
import "package:game/widgets/responsive.dart";
import "package:game/network/socketmethod.dart";
import "package:game/widgets/buttons.dart";
import "package:game/widgets/customTextField.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:game/widgets/textWidget.dart";

class CreateRoom extends ConsumerStatefulWidget {
  static const String routename = "/create-room";

  const CreateRoom({super.key});

  @override
  ConsumerState<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends ConsumerState<CreateRoom> {
  final TextEditingController controller = TextEditingController();
  final SocketMethods methods = SocketMethods();

  @override
  void initState() {
    super.initState();
    methods.listenToCreateRoom(context, ref);
  }

  @override
  void dispose() {
    controller.dispose();
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
                text: "Create Room",
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
              CustomTextField(controller: controller, hintText: "Your NickName"),
              SizedBox(
                height: size.height * 0.06,
              ),
              Button(
                title: "Create",
                icon: Icons.play_arrow,
                callbackFunction: () => {methods.createRoom(controller.text)},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
