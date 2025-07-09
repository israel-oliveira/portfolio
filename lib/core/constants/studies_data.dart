import '../entities/study.dart';

class StudiesData {
  static final List<Study> studies = [
    Study(
      id: 'flutter-advanced',
      title: 'Flutter Avançado',
      description:
          'Curso completo de Flutter avançado com arquitetura clean, '
          'testes automatizados e performance optimization.',
      category: 'Mobile Development',
      imageUrl:
          'https://via.placeholder.com/300x200/2563EB/FFFFFF?text=Flutter+Advanced',
      url: 'https://udemy.com/course/flutter-advanced',
      platform: 'Udemy',
      startDate: DateTime(2024, 1, 1),
      endDate: DateTime(2024, 3, 30),
      isCompleted: true,
      progress: 100,
    ),
    Study(
      id: 'kotlin-android',
      title: 'Kotlin para Android',
      description:
          'Desenvolvimento Android nativo com Kotlin, incluindo '
          'Jetpack Compose e arquitetura MVVM.',
      category: 'Mobile Development',
      imageUrl:
          'https://via.placeholder.com/300x200/F59E0B/FFFFFF?text=Kotlin+Android',
      url: 'https://developer.android.com/courses',
      platform: 'Google Developers',
      startDate: DateTime(2023, 9, 1),
      endDate: DateTime(2023, 12, 15),
      isCompleted: true,
      progress: 100,
    ),
    Study(
      id: 'firebase-masterclass',
      title: 'Firebase Masterclass',
      description:
          'Curso completo sobre Firebase incluindo Authentication, '
          'Firestore, Cloud Functions e Analytics.',
      category: 'Backend',
      imageUrl:
          'https://via.placeholder.com/300x200/FF6B35/FFFFFF?text=Firebase',
      url: 'https://firebase.google.com/docs',
      platform: 'Firebase',
      startDate: DateTime(2023, 6, 1),
      endDate: DateTime(2023, 8, 30),
      isCompleted: true,
      progress: 100,
    ),
    Study(
      id: 'ui-ux-design',
      title: 'UI/UX Design Fundamentals',
      description:
          'Fundamentos de design de interface e experiência do usuário '
          'com foco em aplicações móveis.',
      category: 'Design',
      imageUrl:
          'https://via.placeholder.com/300x200/8B5CF6/FFFFFF?text=UI/UX+Design',
      url: 'https://coursera.org/specializations/ui-ux-design',
      platform: 'Coursera',
      startDate: DateTime(2024, 4, 1),
      isCompleted: false,
      progress: 65,
    ),
    Study(
      id: 'clean-architecture',
      title: 'Clean Architecture',
      description:
          'Princípios e práticas de Clean Architecture aplicadas '
          'ao desenvolvimento mobile.',
      category: 'Architecture',
      imageUrl:
          'https://via.placeholder.com/300x200/10B981/FFFFFF?text=Clean+Arch',
      url:
          'https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html',
      platform: 'Clean Coder',
      startDate: DateTime(2023, 3, 1),
      endDate: DateTime(2023, 5, 30),
      isCompleted: true,
      progress: 100,
    ),
    Study(
      id: 'dart-language',
      title: 'Dart Language Deep Dive',
      description:
          'Estudo aprofundado da linguagem Dart, incluindo features '
          'avançadas e otimizações de performance.',
      category: 'Programming Language',
      imageUrl:
          'https://via.placeholder.com/300x200/0175C2/FFFFFF?text=Dart+Lang',
      url: 'https://dart.dev/guides',
      platform: 'Dart.dev',
      startDate: DateTime(2024, 5, 1),
      isCompleted: false,
      progress: 40,
    ),
  ];

  static List<String> get categories {
    return studies.map((study) => study.category).toSet().toList()..sort();
  }

  static List<Study> get completedStudies {
    return studies.where((study) => study.isCompleted).toList();
  }

  static List<Study> get ongoingStudies {
    return studies.where((study) => !study.isCompleted).toList();
  }

  static List<Study> getByCategory(String category) {
    return studies.where((study) => study.category == category).toList();
  }

  static double get overallProgress {
    if (studies.isEmpty) return 0.0;
    final totalProgress = studies
        .map((study) => study.progress ?? 0)
        .reduce((a, b) => a + b);
    return totalProgress / studies.length;
  }
}
