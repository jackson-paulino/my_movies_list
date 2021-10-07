class TitleRatedModel {
  int id;
  String name;
  String originalName;
  String coverUrl;
  String posterUrl;
  int? rate;

  TitleRatedModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.coverUrl,
    required this.posterUrl,
    this.rate,
  });

  factory TitleRatedModel.fromJson(Map<String, dynamic> json) {
    return TitleRatedModel(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      coverUrl: json['cover_url'],
      posterUrl: json['poster_url'],
      rate: json['rate'],
    );
  }
}
