import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/movie_bloc.dart';
import '../bloc/movie_event.dart';
import '../repository/movie_repository.dart';
import 'movie_grid.dart';

class HomePage extends StatelessWidget {
  final String apiKey;

  const HomePage({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OMDb Flutter Web'),
      ),
      body: BlocProvider(
        create: (context) =>
        MovieBloc(movieRepository: MovieRepository(apiKey: apiKey))
          ..add(const FetchMovies(query: 'Batman')), // Initial movie query
        child: MovieGrid(),
      ),
    );
  }
}
