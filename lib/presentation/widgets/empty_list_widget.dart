import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key, // Define key parameter here
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No items'),
    );
  }
}
