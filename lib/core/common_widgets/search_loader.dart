import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchLoader extends StatelessWidget {
  const SearchLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Lottie.asset(
          'assets/animations/search_animation.json',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
