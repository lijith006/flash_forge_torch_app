import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';

class TorchHomeScreen extends StatefulWidget {
  const TorchHomeScreen({super.key});

  @override
  State<TorchHomeScreen> createState() => _TorchHomeScreenState();
}

class _TorchHomeScreenState extends State<TorchHomeScreen>
    with SingleTickerProviderStateMixin {
  bool isTorchOn = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _toggleTorch() async {
    try {
//vibration
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 10);
      }
      if (isTorchOn) {
        await TorchLight.disableTorch();
        await _audioPlayer.play(AssetSource('sounds/click.mp3'));
      } else {
        await TorchLight.enableTorch();
        await _audioPlayer.play(AssetSource('sounds/click.mp3'));
      }
      setState(() => isTorchOn = !isTorchOn);
    } catch (e) {
      debugPrint("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Flashlight Error:$e')));
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowColor = isTorchOn ? Colors.yellow : Colors.grey[700];
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text(
          'FlashForge',
          style: TextStyle(
              fontFamily: 'Poppins', color: Color.fromARGB(117, 255, 255, 255)),
        )),
        elevation: 0,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleTorch,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: glowColor,
                boxShadow: isTorchOn
                    ? [
                        BoxShadow(
                            color: Colors.yellow.withOpacity(0.7),
                            blurRadius: 50,
                            spreadRadius: 20)
                      ]
                    : []),
            child: Center(
              child: Icon(
                isTorchOn ? Icons.flashlight_on : Icons.flashlight_off,
                color: Colors.black,
                size: 80,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Text(
          isTorchOn ? '' : 'Tap to turn ON',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 15,
              color: isTorchOn ? Colors.yellow : Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
