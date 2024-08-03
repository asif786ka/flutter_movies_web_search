import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:omdb_flutter_web/bloc/movie_bloc.dart';
import 'package:omdb_flutter_web/bloc/movie_state.dart';

class MovieGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        if (state is MovieLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MovieLoaded) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return GestureDetector(
                onTap: () {
                  context.go('/details', extra: movie);
                },
                child: GridTile(
                  footer: GridTileBar(
                    backgroundColor: Colors.black54,
                    title: Text(
                      movie.title,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  child: movie.poster != "N/A"
                      ? Image.network(movie.poster, fit: BoxFit.cover)
                      : Container(color: Colors.grey),
                ),
              );
            },
          );
        } else if (state is MovieError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No movies found'));
        }
      },
    );
  }
}
