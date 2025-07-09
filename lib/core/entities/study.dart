class Study {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? imageUrl;
  final String? url;
  final String? platform;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCompleted;
  final int? progress; // 0-100

  const Study({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.imageUrl,
    this.url,
    this.platform,
    this.startDate,
    this.endDate,
    this.isCompleted = false,
    this.progress,
  });
}
