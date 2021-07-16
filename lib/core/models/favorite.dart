import 'movie.dart';

class FavoritedMovie extends Movie {
  final String genres;
  final int reviews;
  final int duration;
  final String synopsis;
  final String ageRating;

  FavoritedMovie(
      int id,
      String title,
      double rating,
      String poster,
      String backdrop,
      this.genres,
      this.reviews,
      this.duration,
      this.synopsis,
      this.ageRating)
      : super(id, title, rating, poster, backdrop);
}
