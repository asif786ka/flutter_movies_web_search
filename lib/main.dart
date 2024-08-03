import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/home_page.dart';
import 'pages/movie_details.dart';
import 'models/movie.dart';

void main() {
  const apiKey = String.fromEnvironment('OMDB_API_KEY', defaultValue: '');
  runApp(MyApp(apiKey: apiKey));
}

class MyApp extends StatelessWidget {
  final String apiKey;

  MyApp({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(apiKey: apiKey),
        ),
        GoRoute(
          path: '/details',
          builder: (context, state) {
            final movie = state.extra as Movie;
            return MovieDetailsPage(movie: movie);
          },
        ),
      ],
    );

    return MaterialApp.router(
      routerConfig: router,
      title: 'OMDb Flutter Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
