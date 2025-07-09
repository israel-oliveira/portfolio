import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../../../../core/constants/tech_stack_data.dart';
import '../../../../core/entities/tech_stack.dart';
import '../../../../core/widgets/custom_widgets.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

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
              'Tecnologias & Stack',
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
              'Tecnologias e ferramentas que utilizo no desenvolvimento',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 60),

          // Tech Stack Grid
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 0),
                itemCount: TechStackData.stacks.length,
                itemBuilder: (context, index) {
                  final stack = TechStackData.stacks[index];
                  return Container(
                    width: 180,
                    margin: const EdgeInsets.only(right: 16),
                    child: _buildTechStackCard(context, stack, index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechStackCard(BuildContext context, TechStack stack, int index) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 100 * index),
      child: CustomCard(
        onTap: () => _showTechStackDialog(context, stack),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Technology Icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  stack.iconUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.code,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Technology Name
            Text(
              stack.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                stack.category,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Proficiency Level
            _buildProficiencyIndicator(context, stack.proficiencyLevel),
          ],
        ),
      ),
    );
  }

  Widget _buildProficiencyIndicator(BuildContext context, int level) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < level
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.2),
          ),
        );
      }),
    );
  }

  void _showTechStackDialog(BuildContext context, TechStack stack) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Image.network(
              stack.iconUrl,
              width: 32,
              height: 32,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.code,
                  size: 32,
                  color: Theme.of(context).primaryColor,
                );
              },
            ),
            const SizedBox(width: 12),
            Text(stack.name),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categoria: ${stack.category}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Text(
              'Nível de Proficiência: ${stack.proficiencyLevel}/5',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Text(
              stack.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
