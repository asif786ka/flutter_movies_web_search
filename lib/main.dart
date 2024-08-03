import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'bloc/movie_bloc.dart';
import 'repository/movie_repository.dart';
import 'bloc/movie_event.dart';
import 'bloc/movie_state.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMDb Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => MovieRepository(apiKey: dotenv.env['OMDB_API_KEY']!),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OMDb Flutter Web'),
      ),
      body: BlocProvider(
        create: (context) => MovieBloc(movieRepository: context.read<MovieRepository>()),
        child: MovieSearch(),
      ),
    );
  }
}

class MovieSearch extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Search for a movie',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<MovieBloc>().add(FetchMovies(query: _controller.text));
          },
          child: Text('Search'),
        ),
        Expanded(
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is MovieLoaded) {
                return ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return ListTile(
                      leading: Image.network(movie.poster),
                      title: Text(movie.title),
                      subtitle: Text(movie.year),
                    );
                  },
                );
              } else if (state is MovieError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: Text('Search for a movie'));
              }
            },
          ),
        ),
      ],
    );
  }
}
