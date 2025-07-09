# Arquitetura do Profile App

## 🎯 Objetivo

Site web Flutter com arquitetura modular focada em **velocidade** e **simplicidade**. Todos os dados são fixos no código para máxima performance.

## 🏗️ Arquitetura Geral

### Estrutura Modular
```
lib/
├── app/
│   ├── app.dart                 # Widget principal
│   ├── routes.dart             # Roteamento
│   └── theme.dart              # Tema global
├── core/
│   ├── constants/              # Constantes globais
│   ├── extensions/             # Extensions Dart
│   ├── utils/                  # Utilitários
│   └── widgets/                # Widgets compartilhados
└── features/
    ├── home/
    │   ├── data/
    │   │   ├── models/         # Modelos de dados
    │   │   ├── repositories/   # Implementação dos repositories
    │   │   └── services/       # Serviços de dados
    │   ├── domain/
    │   │   ├── entities/       # Entidades de domínio
    │   │   └── repositories/   # Contratos dos repositories
    │   └── presentation/
    │       ├── pages/          # Páginas
    │       ├── view_models/    # ViewModels com Signals
    │       └── widgets/        # Widgets específicos
    └── projects/
        ├── data/
        ├── domain/
        └── presentation/
```

## 🔄 Fluxo de Dados

### Clean Architecture Adaptada
```
View (Flutter Widget)
    ↓ user interaction
ViewModel (Signals)
    ↓ business logic
Repository (abstract)
    ↓ implementation
Service (data source)
    ↓ fixed data
Static Data (in code)
```

## 📦 Tecnologias

### Core
- **Flutter Web**: Platform principal
- **Signals**: Gerenciamento de estado reativo
- **Result Package**: Error handling elegante

### Dependências
```yaml
dependencies:
  flutter:
    sdk: flutter
  signals: ^5.5.0
  result_dart: ^1.1.0
  go_router: ^14.2.7
  
dev_dependencies:
  flutter_lints: ^4.0.0
  flutter_test:
    sdk: flutter
```

## 🎨 Padrões Arquiteturais

### 1. Modularização
Cada feature é um módulo independente com suas próprias camadas.

### 2. Signals para Estado
```dart
// ViewModel com Signals
class HomeViewModel {
  final Signal<bool> isLoading = signal(false);
  final Signal<List<String>> items = signal([]);
  final Signal<String?> error = signal(null);
}
```

### 3. Result para Error Handling
```dart
// Repository com Result
abstract class HomeRepository {
  Result<List<HomeItem>, String> getHomeItems();
}
```

### 4. Dados Fixos
```dart
// Service com dados fixos
class HomeService {
  static const List<Map<String, dynamic>> _homeData = [
    {'id': 1, 'title': 'Item 1', 'description': 'Description 1'},
    {'id': 2, 'title': 'Item 2', 'description': 'Description 2'},
  ];
  
  Result<List<Map<String, dynamic>>, String> getHomeData() {
    return Success(_homeData);
  }
}
```

## 🚀 Características

### Performance
- **Dados fixos**: Zero latência de rede
- **Flutter Web**: Compilação otimizada
- **Signals**: Atualizações granulares de estado

### Simplicidade
- **Arquitetura clara**: Cada camada tem responsabilidade definida
- **Signals**: Estado reativo sem complexidade
- **Result**: Error handling simples e seguro

### Escalabilidade
- **Modularização**: Fácil adição de novas features
- **Separação de responsabilidades**: Manutenção simplificada
- **Padrões consistentes**: Desenvolvimento previsível

## 🤖 Para Agentes de IA

### Convenções de Nomenclatura
- **Arquivos**: snake_case (home_view_model.dart)
- **Classes**: PascalCase (HomeViewModel)
- **Variáveis**: camelCase (isLoading)
- **Constantes**: UPPER_SNAKE_CASE (HOME_DATA)

### Estrutura de ViewModel
```dart
class FeatureViewModel {
  // Signals para estado
  final Signal<bool> isLoading = signal(false);
  final Signal<List<Model>> items = signal([]);
  final Signal<String?> error = signal(null);
  
  // Repository injection
  final FeatureRepository _repository;
  
  FeatureViewModel(this._repository);
  
  // Methods
  void loadData() {
    isLoading.value = true;
    final result = _repository.getData();
    
    result.fold(
      onSuccess: (data) {
        items.value = data;
        error.value = null;
      },
      onFailure: (err) {
        error.value = err;
      },
    );
    
    isLoading.value = false;
  }
}
```

### Estrutura de Repository

**IMPORTANTE**: Sempre divida em **dois arquivos separados** para manter a separação entre abstração e implementação:

#### 1. Abstração (domain/repositories/feature_repository.dart)
```dart
abstract class FeatureRepository {
  Result<List<Model>, String> getData();
}
```

#### 2. Implementação (data/repositories/feature_repository_impl.dart)
```dart
class FeatureRepositoryImpl implements FeatureRepository {
  final FeatureService _service;
  
  FeatureRepositoryImpl(this._service);
  
  @override
  Result<List<Model>, String> getData() {
    try {
      final result = _service.getData();
      return result.map((data) => 
        data.map((json) => Model.fromJson(json)).toList()
      );
    } catch (e) {
      return Failure('Error loading data: $e');
    }
  }
}
```

**Por que dois arquivos?**
- **Abstração (domain/)**: Define o contrato, não depende de implementação
- **Implementação (data/)**: Implementa o contrato, contém lógica específica
- **Testabilidade**: Facilita mocking e testes unitários
- **Inversão de dependência**: Domain não conhece Data, apenas Data conhece Domain