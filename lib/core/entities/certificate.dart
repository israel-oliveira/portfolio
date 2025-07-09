class Certificate {
  final String id;
  final String title;
  final String issuer;
  final String? description;
  final String? imageUrl;
  final String? credentialUrl;
  final DateTime issueDate;
  final DateTime? expirationDate;
  final String category;

  const Certificate({
    required this.id,
    required this.title,
    required this.issuer,
    this.description,
    this.imageUrl,
    this.credentialUrl,
    required this.issueDate,
    this.expirationDate,
    required this.category,
  });
}
