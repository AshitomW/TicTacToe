import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:game/model/roomdata.dart";
import "package:game/network/socketmethod.dart";

class Board extends ConsumerStatefulWidget {
  const Board({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  final socketMethods = SocketMethods();
  void tapped(int index, RoomData roomData) {
    socketMethods.tapGrid(index, roomData.roomData["_id"], roomData.displayElements);
  }

  @override
  void initState() {
    super.initState();
    socketMethods.tapListener(ref);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final roomData = ref.watch(roomDataProvider);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomData.roomData["turn"]["socketID"] != socketMethods.socketClient.id,
        child: GridView.builder(
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (BuildContext context, index) {
              return GestureDetector(
                onTap: () => tapped(index, roomData),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white30,
                    ),
                  ),
                  child: Center(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        roomData.displayElements[index],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 100,
                            shadows: [
                              Shadow(
                                blurRadius: 30,
                                color: roomData.displayElements[index] == "O"
                                    ? Colors.pink[900]!
                                    : Colors.amber,
                              )
                            ]),
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
