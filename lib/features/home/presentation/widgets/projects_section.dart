import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:profile_app/core/utils/extensions/context_extension.dart';
import '../../../../core/constants/projects_data.dart';
import '../../../../core/entities/project.dart';
import '../../../../core/widgets/custom_widgets.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String selectedCategory = 'Todos';
  List<Project> filteredProjects = ProjectsData.projects;

  @override
  void initState() {
    super.initState();
    filteredProjects = ProjectsData.projects;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = context.mq.size;
    final isDesktop = screenSize.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Projetos',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Alguns dos projetos que desenvolvi',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),

          // Category Filter
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: _buildCategoryFilter(context),
          ),
          const SizedBox(height: 40),

          // Projects Grid
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            delay: const Duration(milliseconds: 600),
            child: _buildProjectsGrid(context, isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final categories = ['Todos', ...ProjectsData.categories];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                  _filterProjects();
                });
              },
              selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
              checkmarkColor: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, bool isDesktop) {
    if (filteredProjects.isEmpty) {
      return const EmptyStateWidget(
        title: 'Nenhum projeto encontrado',
        description: 'Tente selecionar uma categoria diferente',
        icon: Icons.work_off,
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        childAspectRatio: isDesktop ? 1.4 : 1.2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        final project = filteredProjects[index];
        return _buildProjectCard(context, project, index);
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project, int index) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 200 * index),
      child: CustomCard(
        onTap: () => context.push('/project/${project.id}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: project.imageUrls.isNotEmpty
                    ? Image.network(
                        project.imageUrls.first,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage(context);
                        },
                      )
                    : _buildPlaceholderImage(context),
              ),
            ),
            const SizedBox(height: 16),

            // Project Title
            Text(
              project.title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Project Description
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Technologies
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.take(3).map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tech,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),

            // Action Buttons
            Row(
              children: [
                if (project.isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Destaque',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/project/${project.id}'),
                  child: const Text('Ver Detalhes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Icon(
        Icons.image,
        size: 48,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  void _filterProjects() {
    if (selectedCategory == 'Todos') {
      filteredProjects = ProjectsData.projects;
    } else {
      filteredProjects = ProjectsData.getByCategory(selectedCategory);
    }
  }
}
