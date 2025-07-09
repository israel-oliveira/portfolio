import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/studies_data.dart';
import '../../../../core/entities/study.dart';
import '../../../../core/widgets/custom_widgets.dart';

class StudiesSection extends StatefulWidget {
  const StudiesSection({super.key});

  @override
  State<StudiesSection> createState() => _StudiesSectionState();
}

class _StudiesSectionState extends State<StudiesSection> {
  String selectedCategory = 'Todos';
  List<Study> filteredStudies = StudiesData.studies;

  @override
  void initState() {
    super.initState();
    filteredStudies = StudiesData.studies;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
              'Estudos & Aprendizado',
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
              'Cursos e estudos em andamento e concluídos',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // Progress Overview
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: _buildProgressOverview(context),
          ),
          const SizedBox(height: 40),

          // Category Filter
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            delay: const Duration(milliseconds: 600),
            child: _buildCategoryFilter(context),
          ),
          const SizedBox(height: 40),

          // Studies Grid
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            delay: const Duration(milliseconds: 800),
            child: _buildStudiesGrid(context, isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressOverview(BuildContext context) {
    final completedCount = StudiesData.completedStudies.length;
    final totalCount = StudiesData.studies.length;
    final overallProgress = StudiesData.overallProgress;

    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            'Concluídos',
            '$completedCount',
            Icons.check_circle,
            Theme.of(context).colorScheme.secondary,
          ),
          _buildStatItem(
            context,
            'Total',
            '$totalCount',
            Icons.school,
            Theme.of(context).primaryColor,
          ),
          _buildStatItem(
            context,
            'Progresso Geral',
            '${overallProgress.toInt()}%',
            Icons.trending_up,
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final categories = ['Todos', ...StudiesData.categories];

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
                  _filterStudies();
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

  Widget _buildStudiesGrid(BuildContext context, bool isDesktop) {
    if (filteredStudies.isEmpty) {
      return const EmptyStateWidget(
        title: 'Nenhum estudo encontrado',
        description: 'Tente selecionar uma categoria diferente',
        icon: Icons.school_outlined,
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        childAspectRatio: isDesktop ? 0.85 : 1.1,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredStudies.length,
      itemBuilder: (context, index) {
        final study = filteredStudies[index];
        return _buildStudyCard(context, study, index);
      },
    );
  }

  Widget _buildStudyCard(BuildContext context, Study study, int index) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 150 * index),
      child: CustomCard(
        onTap: study.url != null ? () => _launchUrl(study.url!) : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Study Image
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: study.imageUrl != null
                    ? Image.network(
                        study.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage(context);
                        },
                      )
                    : _buildPlaceholderImage(context),
              ),
            ),
            const SizedBox(height: 16),

            // Study Title
            Text(
              study.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Platform
            if (study.platform != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.school,
                    size: 16,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    study.platform!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Study Description
            Text(
              study.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),

            // Category and Status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    study.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                _buildStatusIndicator(context, study),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            if (study.progress != null) ...[
              _buildProgressBar(context, study.progress!),
              const SizedBox(height: 8),
            ],

            // Date Range
            if (study.startDate != null || study.endDate != null) ...[
              Text(
                _formatDateRange(study.startDate, study.endDate),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Icon(
        Icons.school,
        size: 48,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, Study study) {
    if (study.isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 12,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 4),
            Text(
              'Concluído',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.play_circle, size: 12, color: Colors.orange),
            const SizedBox(width: 4),
            Text(
              'Em Andamento',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProgressBar(BuildContext context, int progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progresso',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              '$progress%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress / 100,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null && end == null) return '';

    final startStr = start != null ? '${start.month}/${start.year}' : '';
    final endStr = end != null ? '${end.month}/${end.year}' : 'Presente';

    if (start != null && end != null) {
      return '$startStr - $endStr';
    } else if (start != null) {
      return '$startStr - Presente';
    } else {
      return 'Até $endStr';
    }
  }

  void _filterStudies() {
    if (selectedCategory == 'Todos') {
      filteredStudies = StudiesData.studies;
    } else {
      filteredStudies = StudiesData.getByCategory(selectedCategory);
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
