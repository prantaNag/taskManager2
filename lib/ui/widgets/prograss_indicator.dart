import 'package:flutter/material.dart';

class CenteredPrograssIndicator extends StatelessWidget {
  const CenteredPrograssIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
