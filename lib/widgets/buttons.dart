import "package:flutter/material.dart";

class Button extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback callbackFunction;

  const Button(
      {super.key, required this.title, required this.icon, required this.callbackFunction});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 50;
    return SizedBox(
      child: ElevatedButton.icon(
        label: Text(
          title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () => callbackFunction(),
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        iconAlignment: IconAlignment.start,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 11, 83, 141),
          minimumSize: Size(width, 50),
          padding: const EdgeInsets.all(12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
