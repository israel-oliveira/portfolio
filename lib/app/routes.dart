import 'package:go_router/go_router.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/projects/presentation/pages/project_detail_page.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/project/:id',
        name: 'project-detail',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProjectDetailPage(projectId: id);
        },
      ),
    ],
  );
}
