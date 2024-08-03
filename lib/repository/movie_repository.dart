import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class MovieRepository {
  final String apiKey;

  MovieRepository({required this.apiKey});

  Future<List<Movie>> fetchMovies(String query) async {
    final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?s=$query&apikey=$apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == 'True') {
        List movies = data['Search'];
        return movies.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
