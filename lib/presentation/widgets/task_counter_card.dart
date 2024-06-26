import 'package:flutter/material.dart';

class TaskCounterCard extends StatelessWidget {
  const TaskCounterCard({
    Key? key,
    required this.amount,
    required this.title,
  }) : super(key: key);


  final int amount;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
        child: Column(
          children: [
            Text(
              '$amount',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
