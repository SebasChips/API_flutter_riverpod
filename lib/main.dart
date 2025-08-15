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
  final String status;

  CharacterRickAndMorty({
    required this.id,
    required this.name,
    required this.image,
    required this.species,
    required this.gender,
    required this.status,
  });

  //Mapeo de JSON a objeto "CharacterRickAndMorty"
  factory CharacterRickAndMorty.fromJson(Map<String, dynamic> json) {
    return CharacterRickAndMorty(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      species: json['species'],
      gender: json['gender'],
      status: json['status'],
    );
  }
}

//Obtención de datos de la API con función asíncrona
Future<List<CharacterRickAndMorty>> fetchCharacters(
  int page,
  String search,
) async {
  final uri = Uri.parse(
    'https://rickandmortyapi.com/api/character?page=$page${search.isNotEmpty ? "&name=$search" : ""}',
  );
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final List results = data['results'];
    return results.map((e) => CharacterRickAndMorty.fromJson(e)).toList();
  } else {
    throw Exception('Error al cargar personajes');
  }
}

final currentPageProvider = StateProvider<int>((ref) => 1);
final currentSearchProvider = StateProvider<String>((ref) => "");

final charactersProvider = FutureProvider<List<CharacterRickAndMorty>>((ref) {
  final page = ref.watch(currentPageProvider);
  final search = ref.watch(currentSearchProvider);

  return fetchCharacters(page, search);
});

class CharactersPage extends ConsumerWidget {
  const CharactersPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final charactersAsync = ref.watch(charactersProvider);
    final page = ref.watch(currentPageProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personajes Rick & Morty',
          style: TextStyle(fontSize: 35),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar personaje...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                ref.read(currentPageProvider.notifier).state = 1;
                ref.read(currentSearchProvider.notifier).state = value.trim();
              },
            ),
          ),

          //Cards con botón de descripción. Row limitado al tamaño de la respuesta
          Expanded(
            child: charactersAsync.when(
              data: (characters) => ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  var c = characters[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
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
                                        builder: (context) =>
                                            DetailsPage(character: c),
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
          ),

          // Botones de paginación
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: page > 1
                    ? () => ref.read(currentPageProvider.notifier).state--
                    : null,
                child: const Text('Anterior'),
              ),
              Text('Página $page'),
              TextButton(
                onPressed: () => ref.read(currentPageProvider.notifier).state++,
                child: const Text('Siguiente'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}