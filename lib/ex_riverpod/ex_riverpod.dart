
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends ConsumerWidget  {
    MyHomePage({super.key});


  final configurationProvider = FutureProvider<List<dynamic>>((_) async {
    final uri = 'https://jsonplaceholder.typicode.com';
    final response = await http.get(Uri.https(uri, '/todos'));
    final json = jsonDecode(response.body);
    return json;
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final todos = ref.watch(configurationProvider);

    return switch (todos) {
      AsyncData(:final value) => Scaffold(
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary),
          body:Center(child: Text(todos.value.toString()))),
      AsyncError(:final error) => Text('error: $error'),
      _ => const Text('loading'),
    };
  }
}
