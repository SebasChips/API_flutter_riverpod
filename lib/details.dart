import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API riverpod web',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DetailsPage(),
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

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List <String> test = ["A0","B1"];

    return Scaffold(

    );
  }
}
