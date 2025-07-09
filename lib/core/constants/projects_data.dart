import '../entities/project.dart';

class ProjectsData {
  static final List<Project> projects = [
    Project(
      id: 'ecommerce-app',
      title: 'E-commerce App',
      description: 'Aplicativo completo de e-commerce com Flutter',
      fullDescription:
          'Aplicativo completo de e-commerce desenvolvido com Flutter, '
          'incluindo autenticação, carrinho de compras, pagamentos e gerenciamento '
          'de produtos. Utiliza Firebase como backend e implementa Clean Architecture.',
      imageUrls: [
        'https://via.placeholder.com/400x300/2563EB/FFFFFF?text=E-commerce+1',
        'https://via.placeholder.com/400x300/10B981/FFFFFF?text=E-commerce+2',
        'https://via.placeholder.com/400x300/F59E0B/FFFFFF?text=E-commerce+3',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'Stripe',
        'Clean Architecture',
      ],
      githubUrl: 'https://github.com/israeldev/ecommerce-app',
      liveUrl:
          'https://play.google.com/store/apps/details?id=com.israeldev.ecommerce',
      startDate: DateTime(2024, 1, 15),
      endDate: DateTime(2024, 6, 30),
      category: 'Mobile App',
      isFeatured: true,
    ),
    Project(
      id: 'task-manager',
      title: 'Task Manager',
      description: 'Gerenciador de tarefas com sincronização em tempo real',
      fullDescription:
          'Aplicativo de gerenciamento de tarefas com funcionalidades '
          'avançadas como colaboração em equipe, notificações push, sincronização '
          'offline e analytics detalhados.',
      imageUrls: [
        'https://via.placeholder.com/400x300/8B5CF6/FFFFFF?text=Task+Manager+1',
        'https://via.placeholder.com/400x300/EF4444/FFFFFF?text=Task+Manager+2',
      ],
      technologies: [
        'Flutter',
        'Firebase',
        'Hive',
        'Bloc',
        'Push Notifications',
      ],
      githubUrl: 'https://github.com/israeldev/task-manager',
      startDate: DateTime(2023, 8, 1),
      endDate: DateTime(2023, 12, 15),
      category: 'Productivity',
      isFeatured: true,
    ),
    Project(
      id: 'weather-app',
      title: 'Weather App',
      description: 'App de previsão do tempo com design moderno',
      fullDescription:
          'Aplicativo de previsão do tempo com interface moderna, '
          'previsões precisas, mapas interativos e notificações personalizadas.',
      imageUrls: [
        'https://via.placeholder.com/400x300/0EA5E9/FFFFFF?text=Weather+1',
        'https://via.placeholder.com/400x300/06B6D4/FFFFFF?text=Weather+2',
      ],
      technologies: ['Flutter', 'OpenWeather API', 'Geolocator', 'Animations'],
      githubUrl: 'https://github.com/israeldev/weather-app',
      liveUrl: 'https://weather-app-israeldev.netlify.app',
      startDate: DateTime(2023, 5, 1),
      endDate: DateTime(2023, 7, 30),
      category: 'Utility',
      isFeatured: false,
    ),
    Project(
      id: 'portfolio-web',
      title: 'Portfolio Website',
      description: 'Site portfolio responsivo desenvolvido com Flutter Web',
      fullDescription:
          'Website portfolio responsivo desenvolvido com Flutter Web, '
          'incluindo animações suaves, design moderno e otimizado para SEO.',
      imageUrls: [
        'https://via.placeholder.com/400x300/7C3AED/FFFFFF?text=Portfolio+1',
      ],
      technologies: ['Flutter Web', 'Responsive Design', 'Animations', 'SEO'],
      githubUrl: 'https://github.com/israeldev/portfolio',
      liveUrl: 'https://israeldev.com',
      startDate: DateTime(2024, 7, 1),
      endDate: DateTime(2024, 8, 15),
      category: 'Web',
      isFeatured: false,
    ),
  ];

  static List<String> get categories {
    return projects.map((project) => project.category).toSet().toList()..sort();
  }

  static List<Project> get featuredProjects {
    return projects.where((project) => project.isFeatured).toList();
  }

  static List<Project> getByCategory(String category) {
    return projects.where((project) => project.category == category).toList();
  }

  static Project? getById(String id) {
    try {
      return projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }
}
