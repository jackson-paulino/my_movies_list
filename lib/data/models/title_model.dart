class TitleModel {
  final int id;
  final String name;
  final String coverUrl;
  final String posterUrl;
  final bool isTvShow;

  TitleModel(
      {required this.id,
      required this.name,
      required this.coverUrl,
      required this.posterUrl,
      required this.isTvShow});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(
        id: json['id'],
        name: json['name'],
        coverUrl: json['cover_url'],
        posterUrl: json['poster_url'],
        isTvShow: json['is_tv_show']);
  }
}
