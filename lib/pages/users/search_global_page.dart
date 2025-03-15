import 'package:ai_learning_app/components/global_search/gs_app_bar.dart';
import 'package:flutter/material.dart';

class GlobalSearchScreen extends StatelessWidget {
  const GlobalSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          GSAppBar()
        ],
      ),
    );
  }
}