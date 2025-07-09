import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/projects_data.dart';
import '../../../../core/entities/project.dart';
import '../../../../core/widgets/custom_widgets.dart';

class ProjectDetailPage extends StatelessWidget {
  final String projectId;

  const ProjectDetailPage({super.key, required this.projectId});

  @override
  Widget build(BuildContext context) {
    final project = ProjectsData.getById(projectId);

    if (project == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Projeto não encontrado')),
        body: const Center(
          child: EmptyStateWidget(
            title: 'Projeto não encontrado',
            description: 'O projeto solicitado não existe ou foi removido.',
            icon: Icons.error_outline,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: FadeInUp(
                child: Text(
                  project.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 1),
                        blurRadius: 3,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (project.imageUrls.isNotEmpty)
                    Image.network(
                      project.imageUrls.first,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholderHero(context);
                      },
                    )
                  else
                    _buildPlaceholderHero(context),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(child: _buildContent(context, project)),
        ],
      ),
    );
  }

  Widget _buildPlaceholderHero(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: const Icon(Icons.image, size: 80, color: Colors.white54),
    );
  }

  Widget _buildContent(BuildContext context, Project project) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 768;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Info
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: _buildProjectInfo(context, project),
          ),
          const SizedBox(height: 40),

          // Description
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 200),
            child: _buildDescription(context, project),
          ),
          const SizedBox(height: 40),

          // Technologies
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: _buildTechnologies(context, project),
          ),
          const SizedBox(height: 40),

          // Image Gallery
          if (project.imageUrls.length > 1) ...[
            FadeInUp(
              duration: const Duration(milliseconds: 1400),
              delay: const Duration(milliseconds: 600),
              child: _buildImageGallery(context, project),
            ),
            const SizedBox(height: 40),
          ],

          // Action Buttons
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            delay: const Duration(milliseconds: 800),
            child: _buildActionButtons(context, project),
          ),
          const SizedBox(height: 40),

          // Back Button
          FadeInUp(
            duration: const Duration(milliseconds: 1800),
            delay: const Duration(milliseconds: 1000),
            child: Center(
              child: OutlinedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Voltar aos Projetos'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectInfo(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (project.isFeatured) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Projeto Destaque',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                project.category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        if (project.startDate != null || project.endDate != null) ...[
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
              const SizedBox(width: 8),
              Text(
                _formatDateRange(project.startDate, project.endDate),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildDescription(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sobre o Projeto',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          project.fullDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
      ],
    );
  }

  Widget _buildTechnologies(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tecnologias Utilizadas',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                tech,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImageGallery(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Galeria de Imagens',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: project.imageUrls.length,
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                margin: const EdgeInsets.only(right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    project.imageUrls[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.image,
                          size: 48,
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.5),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Links do Projeto',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            if (project.githubUrl != null)
              GradientButton(
                text: 'Ver no GitHub',
                onPressed: () => _launchUrl(project.githubUrl!),
                width: 160,
              ),
            if (project.liveUrl != null)
              OutlinedButton.icon(
                onPressed: () => _launchUrl(project.liveUrl!),
                icon: const Icon(FontAwesomeIcons.externalLinkAlt, size: 16),
                label: const Text('Ver ao Vivo'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
          ],
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

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
