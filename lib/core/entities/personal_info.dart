class PersonalInfo {
  final String name;
  final String title;
  final String description;
  final String email;
  final String phone;
  final String location;
  final String profileImageUrl;
  final List<SocialLink> socialLinks;

  const PersonalInfo({
    required this.name,
    required this.title,
    required this.description,
    required this.email,
    required this.phone,
    required this.location,
    required this.profileImageUrl,
    required this.socialLinks,
  });
}

class SocialLink {
  final String name;
  final String url;
  final String iconName;

  const SocialLink({
    required this.name,
    required this.url,
    required this.iconName,
  });
}
