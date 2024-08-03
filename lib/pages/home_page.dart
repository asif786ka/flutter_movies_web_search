import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_flutter_web/bloc/movie_bloc.dart';
import 'package:omdb_flutter_web/bloc/movie_event.dart';
import 'package:omdb_flutter_web/repository/movie_repository.dart';
import 'movie_grid.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OMDb Flutter Web'),
      ),
      body: BlocProvider(
        create: (context) =>
        MovieBloc(movieRepository: context.read<MovieRepository>())
          ..add(const FetchMovies(query: 'Batman')), // Initial movie query
        child: MovieGrid(),
      ),
    );
  }
}
