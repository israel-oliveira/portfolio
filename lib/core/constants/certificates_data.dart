import '../entities/certificate.dart';

class CertificatesData {
  static final List<Certificate> certificates = [
    Certificate(
      id: 'flutter-certified',
      title: 'Flutter Certified Developer',
      issuer: 'Google',
      description:
          'Certificação oficial do Google para desenvolvimento Flutter',
      imageUrl:
          'https://via.placeholder.com/300x200/4285F4/FFFFFF?text=Google+Flutter',
      credentialUrl: 'https://developers.google.com/certification/flutter',
      issueDate: DateTime(2024, 6, 15),
      category: 'Mobile Development',
    ),
    Certificate(
      id: 'android-developer',
      title: 'Associate Android Developer',
      issuer: 'Google',
      description: 'Certificação para desenvolvimento Android com Kotlin',
      imageUrl:
          'https://via.placeholder.com/300x200/3DDC84/FFFFFF?text=Android+Dev',
      credentialUrl:
          'https://developers.google.com/certification/associate-android-developer',
      issueDate: DateTime(2023, 11, 20),
      category: 'Mobile Development',
    ),
    Certificate(
      id: 'firebase-certified',
      title: 'Firebase Certified',
      issuer: 'Google Cloud',
      description: 'Certificação em Firebase para desenvolvimento backend',
      imageUrl:
          'https://via.placeholder.com/300x200/FFCA28/FFFFFF?text=Firebase+Cert',
      credentialUrl: 'https://cloud.google.com/certification',
      issueDate: DateTime(2023, 9, 10),
      category: 'Backend',
    ),
    Certificate(
      id: 'aws-cloud-practitioner',
      title: 'AWS Cloud Practitioner',
      issuer: 'Amazon Web Services',
      description: 'Certificação fundamental em serviços de nuvem AWS',
      imageUrl:
          'https://via.placeholder.com/300x200/FF9900/FFFFFF?text=AWS+Cloud',
      credentialUrl:
          'https://aws.amazon.com/certification/certified-cloud-practitioner/',
      issueDate: DateTime(2024, 2, 28),
      expirationDate: DateTime(2027, 2, 28),
      category: 'Cloud Computing',
    ),
    Certificate(
      id: 'scrum-master',
      title: 'Certified ScrumMaster',
      issuer: 'Scrum Alliance',
      description: 'Certificação em metodologias ágeis e Scrum',
      imageUrl:
          'https://via.placeholder.com/300x200/009CDF/FFFFFF?text=Scrum+Master',
      credentialUrl:
          'https://scrumalliance.org/get-certified/scrum-master-track/certified-scrummaster',
      issueDate: DateTime(2023, 7, 5),
      expirationDate: DateTime(2025, 7, 5),
      category: 'Project Management',
    ),
    Certificate(
      id: 'ux-design',
      title: 'UX Design Professional',
      issuer: 'Nielsen Norman Group',
      description: 'Certificação em User Experience Design',
      imageUrl:
          'https://via.placeholder.com/300x200/E91E63/FFFFFF?text=UX+Design',
      credentialUrl: 'https://nngroup.com/ux-certification/',
      issueDate: DateTime(2024, 4, 12),
      category: 'Design',
    ),
  ];

  static List<String> get categories {
    return certificates.map((cert) => cert.category).toSet().toList()..sort();
  }

  static List<Certificate> getByCategory(String category) {
    return certificates.where((cert) => cert.category == category).toList();
  }

  static List<Certificate> get validCertificates {
    final now = DateTime.now();
    return certificates.where((cert) {
      return cert.expirationDate == null || cert.expirationDate!.isAfter(now);
    }).toList();
  }

  static List<Certificate> get expiredCertificates {
    final now = DateTime.now();
    return certificates.where((cert) {
      return cert.expirationDate != null && cert.expirationDate!.isBefore(now);
    }).toList();
  }
}
