class Project {
  final String id;
  final String title;
  final String description;
  final String fullDescription;
  final List<String> imageUrls;
  final String? videoUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final DateTime? startDate;
  final DateTime? endDate;
  final String category;
  final bool isFeatured;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.fullDescription,
    required this.imageUrls,
    this.videoUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.startDate,
    this.endDate,
    required this.category,
    this.isFeatured = false,
  });
}
