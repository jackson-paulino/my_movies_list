import 'genres_model.dart';

class TitleDetailModel {
  final int id;
  final String name;
  final String overview;
  final DateTime? releaseDate;
  final int voteAverage;
  final String homepage;
  final String runtime;
  final List<GenresModel>? genres;
  final String coverUrl;
  final String posterUrl;
  final List<CommentModel> comments;

  TitleDetailModel({
    required this.id,
    required this.name,
    required this.overview,
    this.releaseDate,
    required this.voteAverage,
    required this.homepage,
    required this.runtime,
    required this.genres,
    required this.coverUrl,
    required this.posterUrl,
    required this.comments,
  });

  factory TitleDetailModel.fromJson(Map<String, dynamic> json) {
    var genres = <GenresModel>[];
    if (json['genres'] != null) {
      json['genres'].forEach((v) {
        GenresModel gn = GenresModel.fromJson(v);
        genres.add(gn);
      });
    }
    return TitleDetailModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      releaseDate: DateTime.parse(json['release_date']),
      voteAverage: json['vote_average'],
      runtime: json['runtime'],
      genres: genres,
      homepage: json['homepage'],
      coverUrl: json['cover_url'],
      posterUrl: json['poster_url'],
      comments: List<CommentModel>.from(
          json['comments'].map((c) => CommentModel.fromJson(c)).toList()),
    );
  }
}

class CommentModel {
  int id;
  String text;
  DateTime date;

  CommentModel({required this.id, required this.text, required this.date});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      text: json['text'],
      date: DateTime.parse(json['date']),
    );
  }
}
