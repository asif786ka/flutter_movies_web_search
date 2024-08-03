import 'package:flutter_bloc/flutter_bloc.dart';
import 'movie_event.dart';
import 'movie_state.dart';
import '../repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final movies = await movieRepository.fetchMovies(event.query);
        emit(MovieLoaded(movies: movies));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });
  }
}
