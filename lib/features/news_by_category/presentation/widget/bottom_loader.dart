import 'package:flutter/material.dart';

class BottomOfScreenLoader extends StatelessWidget {
  const BottomOfScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          strokeWidth: 4,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
