import 'package:flutter/material.dart';

class FiltrationAppbarComponent extends StatelessWidget {
  final String title;

  const FiltrationAppbarComponent({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.horizontal_rule,
          size: 30,
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
