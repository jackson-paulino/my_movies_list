class TitleType {
  final String label;
  final bool paramsUrl;
  final String params;
  final bool isTvShow;

  TitleType(
      {this.paramsUrl = false,
      required this.params,
      required this.label,
      required this.isTvShow});
}
