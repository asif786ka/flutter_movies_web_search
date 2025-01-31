class Movie {
  final String title;
  final String year;
  final String poster;

  Movie({required this.title, required this.year, required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      year: json['Year'],
      poster: json['Poster'],
    );
  }
}
