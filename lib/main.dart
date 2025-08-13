import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'details.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Riverpod Web',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CharactersPage(),
    );
  }
}

class CharacterRickAndMorty {
  final int id;
  final String name;
  final String image;

  CharacterRickAndMorty({
    required this.id,
    required this.name,
    required this.image,
  });

  factory CharacterRickAndMorty.fromJson(Map<String, dynamic> json) {
    return CharacterRickAndMorty(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}

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
      appBar: AppBar(title: const Text('Rick and Morty')),
      body: charactersAsync.when(
        data: (characters) => ListView.builder(
          itemCount: characters.length,
          itemBuilder: (context, index) {
            final c = characters[index];
            return ListTile(
              leading: Image.network(c.image),
              title: Text(c.name),
              trailing: ElevatedButton(
                child: const Text('Open route'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DetailsPage(),
                    ),
                  );
                },
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
