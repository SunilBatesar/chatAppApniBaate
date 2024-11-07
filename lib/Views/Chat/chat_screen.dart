import 'package:flutter/material.dart';
import 'package:recipe_test/main.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: constantSheet.colors.primary,
        title: Text("User Name",
            style: constantSheet.textTheme.fs24Normal
                .copyWith(color: constantSheet.colors.white)),
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
