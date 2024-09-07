import 'package:flutter/material.dart';

class FiltrationAppbarComponent extends StatelessWidget {
  final String title;

  const FiltrationAppbarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/dashboard");
          },
          child: const Icon(
            Icons.horizontal_rule,
            size: 25,
          ),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Icon(
          Icons.search,
          size: 30,
        ),
      ],
    );
  }
}
