import '../entities/tech_stack.dart';

class TechStackData {
  static const List<TechStack> stacks = [
    TechStack(
      id: 'flutter',
      name: 'Flutter',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg',
      description: 'Framework UI para desenvolvimento multiplataforma',
      category: 'Frontend',
      proficiencyLevel: 5,
    ),
    TechStack(
      id: 'dart',
      name: 'Dart',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg',
      description: 'Linguagem de programação moderna e eficiente',
      category: 'Language',
      proficiencyLevel: 5,
    ),
    TechStack(
      id: 'firebase',
      name: 'Firebase',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/firebase/firebase-plain.svg',
      description: 'Plataforma de desenvolvimento de aplicativos móveis',
      category: 'Backend',
      proficiencyLevel: 4,
    ),
    TechStack(
      id: 'android',
      name: 'Android',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-original.svg',
      description: 'Desenvolvimento nativo Android',
      category: 'Mobile',
      proficiencyLevel: 4,
    ),
    TechStack(
      id: 'kotlin',
      name: 'Kotlin',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/kotlin/kotlin-original.svg',
      description: 'Linguagem moderna para desenvolvimento Android',
      category: 'Language',
      proficiencyLevel: 4,
    ),
    TechStack(
      id: 'git',
      name: 'Git',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/git/git-original.svg',
      description: 'Controle de versão distribuído',
      category: 'Tools',
      proficiencyLevel: 4,
    ),
    TechStack(
      id: 'figma',
      name: 'Figma',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/figma/figma-original.svg',
      description: 'Design de interfaces e prototipagem',
      category: 'Design',
      proficiencyLevel: 3,
    ),
    TechStack(
      id: 'nodejs',
      name: 'Node.js',
      iconUrl:
          'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/nodejs/nodejs-original.svg',
      description: 'Runtime JavaScript para backend',
      category: 'Backend',
      proficiencyLevel: 3,
    ),
  ];

  static List<String> get categories {
    return stacks.map((stack) => stack.category).toSet().toList()..sort();
  }

  static List<TechStack> getByCategory(String category) {
    return stacks.where((stack) => stack.category == category).toList();
  }
}
