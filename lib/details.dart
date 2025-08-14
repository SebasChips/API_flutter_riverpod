import 'package:flutter/material.dart';
import 'main.dart';

class DetailsPage extends StatelessWidget {
  final CharacterRickAndMorty character;

  const DetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text('Origin: ${character.gender}'),
          ],
        ),
      ),
    );
  }
}
