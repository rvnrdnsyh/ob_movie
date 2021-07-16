class Movie {
  final int id;
  final String title;
  final double rating;
  final String poster;
  final String backdrop;

  Movie(this.id, this.title, this.rating, this.poster, this.backdrop);
}

class MovieDetailPreVideoAndCast extends Movie {
  final List genres;
  final int voted;
  final String synopsis;
  final bool video;

  MovieDetailPreVideoAndCast(int id, String title, double rating, String poster,
      String backdrop, this.genres, this.voted, this.synopsis, this.video)
      : super(id, title, rating, poster, backdrop);
}

class MovieDetailWithCast extends MovieDetailPreVideoAndCast {
  final List<MovieCast> cast;

  MovieDetailWithCast(
      int id,
      String title,
      double rating,
      String poster,
      String backdrop,
      List genres,
      int voted,
      String synopsis,
      bool video,
      this.cast)
      : super(id, title, rating, poster, backdrop, genres, voted, synopsis,
            video);
}

class MovieDetails extends MovieDetailWithCast {
  final String trailerPath;
  final bool favorited;

  MovieDetails(
      int id,
      String title,
      double rating,
      String poster,
      String backdrop,
      List genres,
      int voted,
      String synopsis,
      bool video,
      List<MovieCast> cast,
      this.trailerPath,
      this.favorited)
      : super(id, title, rating, poster, backdrop, genres, voted, synopsis,
            video, cast);
}

class MovieCast {
  final String name;
  final int profileId;
  final String profileImage;
  final int gender;

  MovieCast(this.name, this.profileId, this.profileImage, this.gender);
}

class Trailer {
  final String key;
  final String site;

  Trailer(this.key, this.site);
}
