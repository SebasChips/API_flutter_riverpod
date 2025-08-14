import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'details.dart';



//Inicialización de la app con riverpod
void main() {
  runApp(const ProviderScope(child: RickAndMorty()));
}

//Inicializa un widget estático para la demostración del contenido de la API
class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const CharactersPage(),
    );
  }
}

//Clase del modelo de datos de la API
class CharacterRickAndMorty {
  final int id;
  final String name;
  final String image;
  final String species;
  final String gender;

  CharacterRickAndMorty({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
  });

  //Mapeo de JSON a objeto "CharacterRickAndMorty"
  factory CharacterRickAndMorty.fromJson(Map<String, dynamic> json) {
    return CharacterRickAndMorty(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      species: json['species'],
      gender: json['gender'],
    );
  }
}

//Obtención de datos de la API con función asíncrona
Future<List<CharacterRickAndMorty>> fetchCharacters() async {
  final response = await http.get(
    Uri.parse('https://rickandmortyapi.com/api/character'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List results = data['results'];
    return results.map((e) => CharacterRickAndMorty.fromJson(e)).toList();
  } else {
    throw Exception('Error al cargar personajes');
  }
}

final charactersProvider = FutureProvider<List<CharacterRickAndMorty>>((ref) {
  return fetchCharacters();
});

class CharactersPage extends ConsumerWidget {
  const CharactersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(charactersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personajes Rick & Morty',
          style: TextStyle(fontSize: 35),
        ),
      ),
      body: charactersAsync.when(
        data: (characters) => ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            var c = characters[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.network(
                      c.image,
                      width: 150,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailsPage(character: c),
                                ),
                              );
                            },
                            child: const Text('Descripción'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
