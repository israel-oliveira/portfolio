import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/personal_data.dart';
import '../../../../core/entities/personal_info.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 768;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).primaryColor.withOpacity(0.05),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 60,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: _buildContactSection(context, isDesktop),
          ),
          const SizedBox(height: 40),

          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 200),
            child: Divider(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 30),

          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: _buildFooterInfo(context, isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, bool isDesktop) {
    return Column(
      children: [
        Text(
          'Vamos trabalhar juntos?',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        Text(
          'Estou sempre interessado em novos projetos e oportunidades.\n'
          'Entre em contato e vamos conversar!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        if (isDesktop) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContactButton(
                context,
                'Enviar E-mail',
                Icons.email,
                () => _launchUrl('mailto:${PersonalData.info.email}'),
              ),
              const SizedBox(width: 24),
              _buildContactButton(
                context,
                'WhatsApp',
                FontAwesomeIcons.whatsapp,
                () => _launchUrl(
                  'https://wa.me/${PersonalData.info.phone.replaceAll(RegExp(r'[^\d]'), '')}',
                ),
              ),
            ],
          ),
        ] else ...[
          Column(
            children: [
              _buildContactButton(
                context,
                'Enviar E-mail',
                Icons.email,
                () => _launchUrl('mailto:${PersonalData.info.email}'),
              ),
              const SizedBox(height: 16),
              _buildContactButton(
                context,
                'WhatsApp',
                FontAwesomeIcons.whatsapp,
                () => _launchUrl(
                  'https://wa.me/${PersonalData.info.phone.replaceAll(RegExp(r'[^\d]'), '')}',
                ),
              ),
            ],
          ),
        ],

        const SizedBox(height: 32),
        _buildSocialLinks(context),
      ],
    );
  }

  Widget _buildContactButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      width: 200,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: PersonalData.info.socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _buildSocialButton(context, link),
        );
      }).toList(),
    );
  }

  Widget _buildSocialButton(BuildContext context, SocialLink link) {
    IconData icon;
    switch (link.iconName.toLowerCase()) {
      case 'github':
        icon = FontAwesomeIcons.github;
        break;
      case 'linkedin':
        icon = FontAwesomeIcons.linkedin;
        break;
      case 'twitter':
        icon = FontAwesomeIcons.twitter;
        break;
      case 'instagram':
        icon = FontAwesomeIcons.instagram;
        break;
      default:
        icon = FontAwesomeIcons.link;
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          width: 2,
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(link.url),
          borderRadius: BorderRadius.circular(28),
          child: Icon(icon, color: Theme.of(context).primaryColor, size: 24),
        ),
      ),
    );
  }

  Widget _buildFooterInfo(BuildContext context, bool isDesktop) {
    final currentYear = DateTime.now().year;

    if (isDesktop) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© $currentYear ${PersonalData.info.name}. Todos os direitos reservados.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          Row(
            children: [
              Text(
                'Desenvolvido com ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Icon(Icons.favorite, color: Colors.red, size: 16),
              Text(
                ' e Flutter',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Text(
            '© $currentYear ${PersonalData.info.name}.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Todos os direitos reservados.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Desenvolvido com ',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Icon(Icons.favorite, color: Colors.red, size: 16),
              Text(
                ' e Flutter',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
