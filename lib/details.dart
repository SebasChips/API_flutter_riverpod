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
            Image.network(
              character.image,
              width: 150,
              height: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 16),
            Text('Género: ${character.gender}'),
            Text('Especie: ${character.species}'),
            Text('Estatus: ${character.status}'),


          ],
        ),
      ),
    );
  }
}
