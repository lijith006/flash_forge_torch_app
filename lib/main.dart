import 'package:flutter/material.dart';
import 'package:torch_app/torch_screen.dart';

void main() {
  runApp(const TorchApp());
}

class TorchApp extends StatelessWidget {
  const TorchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumos Flashlight',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.black, useMaterial3: true),
      home: const TorchHomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
