# Estrutura de Módulos

## 🎯 Padrão de Módulo

Cada feature segue a mesma estrutura modular baseada em Clean Architecture adaptada para Flutter Web.

### 📁 Estrutura Base
```
features/feature_name/
├── data/
│   ├── models/
│   │   └── feature_model.dart
│   ├── repositories/
│   │   └── feature_repository_impl.dart
│   └── services/
│       └── feature_service.dart
├── domain/
│   ├── entities/
│   │   └── feature_entity.dart
│   └── repositories/
│       └── feature_repository.dart
└── presentation/
    ├── pages/
    │   └── feature_page.dart
    ├── view_models/
    │   └── feature_view_model.dart
    └── widgets/
        └── feature_widget.dart
```

## 🏗️ Responsabilidades das Camadas

### **Data Layer**
```dart
// SERVICE - Dados fixos
class FeatureService {
  static const _data = [
    {'id': 1, 'name': 'Item 1'},
    {'id': 2, 'name': 'Item 2'},
  ];
  
  Result<List<Map<String, dynamic>>, String> getData() {
    return Success(_data);
  }
}

// MODEL - Serialização
class FeatureModel {
  final int id;
  final String name;
  
  FeatureModel({required this.id, required this.name});
  
  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id'],
      name: json['name'],
    );
  }
  
  FeatureEntity toEntity() => FeatureEntity(id: id, name: name);
}

// REPOSITORY IMPL - Conversão Service → Entity
class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureService _service;
  
  FeatureRepositoryImpl(this._service);
  
  @override
  Result<List<FeatureEntity>, String> getAll() {
    return _service.getData().map(
      (data) => data.map((json) => 
        FeatureModel.fromJson(json).toEntity()
      ).toList(),
    );
  }
}
```

### **Domain Layer**
```dart
// ENTITY - Regras de negócio
class FeatureEntity {
  final int id;
  final String name;
  
  const FeatureEntity({
    required this.id, 
    required this.name,
  });
  
  // Business rules
  bool get isValid => name.isNotEmpty;
  String get displayName => name.toUpperCase();
}

// REPOSITORY ABSTRACT - Contrato
abstract class FeatureRepository {
  Result<List<FeatureEntity>, String> getAll();
  Result<FeatureEntity, String> getById(int id);
}
```

### **Presentation Layer**
```dart
// VIEW MODEL - Estado + Lógica UI
class FeatureViewModel {
  final FeatureRepository _repository;
  
  final Signal<bool> isLoading = signal(false);
  final Signal<List<FeatureEntity>> items = signal([]);
  final Signal<String?> error = signal(null);
  
  FeatureViewModel(this._repository);
  
  void loadData() {
    isLoading.value = true;
    error.value = null;
    
    final result = _repository.getAll();
    result.fold(
      onSuccess: (data) => items.value = data,
      onFailure: (err) => error.value = err,
    );
    
    isLoading.value = false;
  }
}

// PAGE - UI + Reatividade
class FeaturePage extends StatefulWidget {
  @override
  State<FeaturePage> createState() => _FeaturePageState();
}

class _FeaturePageState extends State<FeaturePage> {
  late final FeatureViewModel _viewModel;
  
  @override
  void initState() {
    super.initState();
    _viewModel = FeatureViewModel(
      FeatureRepositoryImpl(FeatureService()),
    );
    _viewModel.loadData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((context) {
        if (_viewModel.isLoading.value) {
          return CircularProgressIndicator();
        }
        
        return ListView.builder(
          itemCount: _viewModel.items.value.length,
          itemBuilder: (context, index) {
            final item = _viewModel.items.value[index];
            return ListTile(title: Text(item.displayName));
          },
        );
      }),
    );
  }
}
```

## 🚀 Template para Novo Módulo

### Checklist para Criar Feature
```
□ 1. Criar pasta features/nova_feature/
□ 2. Definir Entity no domain/
□ 3. Criar Repository abstract no domain/
□ 4. Implementar Service com dados fixos
□ 5. Criar Model com fromJson/toEntity
□ 6. Implementar Repository no data/
□ 7. Criar ViewModel com Signals
□ 8. Criar Page com Watch()
□ 9. Adicionar rota no app/routes.dart
```

### Exemplo: Feature "About"
```dart
// 1. domain/entities/about_entity.dart
class AboutEntity {
  final String title;
  final String description;
  final List<String> skills;
  
  const AboutEntity({
    required this.title,
    required this.description,
    required this.skills,
  });
}

// 2. domain/repositories/about_repository.dart
abstract class AboutRepository {
  Result<AboutEntity, String> getAboutInfo();
}

// 3. data/services/about_service.dart
class AboutService {
  static const Map<String, dynamic> _aboutData = {
    'title': 'Israel Oliveira',
    'description': 'Flutter Developer',
    'skills': ['Flutter', 'Dart', 'Web Development'],
  };
  
  Result<Map<String, dynamic>, String> getAboutData() {
    return Success(_aboutData);
  }
}

// 4. data/models/about_model.dart
class AboutModel {
  final String title;
  final String description;
  final List<String> skills;
  
  AboutModel({
    required this.title,
    required this.description,
    required this.skills,
  });
  
  factory AboutModel.fromJson(Map<String, dynamic> json) {
    return AboutModel(
      title: json['title'],
      description: json['description'],
      skills: List<String>.from(json['skills']),
    );
  }
  
  AboutEntity toEntity() {
    return AboutEntity(
      title: title,
      description: description,
      skills: skills,
    );
  }
}

// 5. data/repositories/about_repository_impl.dart
class AboutRepositoryImpl implements AboutRepository {
  final AboutService _service;
  
  AboutRepositoryImpl(this._service);
  
  @override
  Result<AboutEntity, String> getAboutInfo() {
    return _service.getAboutData().map(
      (data) => AboutModel.fromJson(data).toEntity(),
    );
  }
}

// 6. presentation/view_models/about_view_model.dart
class AboutViewModel {
  final AboutRepository _repository;
  
  final Signal<bool> isLoading = signal(false);
  final Signal<AboutEntity?> aboutInfo = signal(null);
  final Signal<String?> error = signal(null);
  
  AboutViewModel(this._repository);
  
  void loadAbout() {
    isLoading.value = true;
    error.value = null;
    
    final result = _repository.getAboutInfo();
    result.fold(
      onSuccess: (data) => aboutInfo.value = data,
      onFailure: (err) => error.value = err,
    );
    
    isLoading.value = false;
  }
}

// 7. presentation/pages/about_page.dart
class AboutPage extends StatefulWidget {
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late final AboutViewModel _viewModel;
  
  @override
  void initState() {
    super.initState();
    _viewModel = AboutViewModel(
      AboutRepositoryImpl(AboutService()),
    );
    _viewModel.loadAbout();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About')),
      body: Watch((context) {
        final about = _viewModel.aboutInfo.value;
        
        if (_viewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        if (about == null) {
          return Center(child: Text('No data'));
        }
        
        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                about.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              Text(about.description),
              SizedBox(height: 16),
              Text('Skills:'),
              ...about.skills.map(
                (skill) => Chip(label: Text(skill)),
              ),
            ],
          ),
        );
      }),
    );
  }
}
```

## 🤖 Padrões para IA

### Nomenclatura Consistente
```
Feature: "user_profile"
├── UserProfileEntity
├── UserProfileRepository (abstract)
├── UserProfileRepositoryImpl
├── UserProfileService
├── UserProfileModel
├── UserProfileViewModel
├── UserProfilePage
└── UserProfileWidget
```

### Fluxo de Dependências
```
Page → ViewModel → Repository → Service
↓       ↓           ↓           ↓
UI   → Signals  → Entity   → Fixed Data
```

### Error Handling Padrão
```dart
// Service sempre retorna Result
Result<T, String> getData()

// Repository sempre converte e propaga
Result<Entity, String> method()

// ViewModel sempre trata Success/Failure
result.fold(
  onSuccess: (data) => signal.value = data,
  onFailure: (error) => errorSignal.value = error,
);
```