import 'package:flutter/material.dart';
import 'package:omdb_flutter_web/models/movie.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            movie.poster != "N/A"
                ? Image.network(movie.poster)
                : Container(width: 100, height: 150, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              movie.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Year: ${movie.year}"),
            // Add more movie details here
          ],
        ),
      ),
    );
  }
}
