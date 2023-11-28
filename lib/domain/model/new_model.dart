class Movie {
  final String description;
  final List<String> sources;
  final String subtitle;
  final String thumb;
  final String title;

  Movie({
    required this.description,
    required this.sources,
    required this.subtitle,
    required this.thumb,
    required this.title,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      description: json['description'],
      sources: List<String>.from(json['sources']),
      subtitle: json['subtitle'],
      thumb: json['thumb'],
      title: json['title'],
    );
  }
}
