import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/personal_data.dart';
import '../../../../core/entities/personal_info.dart';
import '../../../../core/widgets/animated_text.dart';
import '../../../../core/widgets/custom_widgets.dart';
import '../../../../core/utils/clipboard_helper.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key, this.scrollToSection});

  final void Function(int index)? scrollToSection;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 768;

    return Container(
      height: screenSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).scaffoldBackgroundColor,
            Theme.of(context).primaryColor.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 24,
          vertical: 40,
        ),
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: _buildTextContent(context)),
        const SizedBox(width: 80),
        Expanded(flex: 2, child: _buildProfileImage(context)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context),
        const SizedBox(height: 40),
        _buildTextContent(context),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeInLeft(
          duration: const Duration(milliseconds: 800),
          child: Text(
            'Olá, eu sou',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).secondaryHeaderColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Nome animado
        FadeInLeft(
          duration: const Duration(milliseconds: 1000),
          delay: const Duration(milliseconds: 200),
          child: AnimatedTitle(
            text: PersonalData.info.name,
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),

        // Título animado com typewriter
        FadeInLeft(
          duration: const Duration(milliseconds: 1200),
          delay: const Duration(milliseconds: 400),
          child: TypewriterText(
            text: PersonalData.info.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Descrição
        FadeInLeft(
          duration: const Duration(milliseconds: 1400),
          delay: const Duration(milliseconds: 600),
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 768
                ? 500
                : double.infinity,
            child: Text(
              PersonalData.info.description,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.6),
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Informações de contato
        FadeInLeft(
          duration: const Duration(milliseconds: 1600),
          delay: const Duration(milliseconds: 800),
          child: _buildContactInfo(context),
        ),
        const SizedBox(height: 32),

        // Links sociais
        FadeInLeft(
          duration: const Duration(milliseconds: 1800),
          delay: const Duration(milliseconds: 1000),
          child: _buildSocialLinks(context),
        ),
        const SizedBox(height: 40),

        // Botões de ação
        FadeInUp(
          duration: const Duration(milliseconds: 2000),
          delay: const Duration(milliseconds: 1200),
          child: _buildActionButtons(context),
        ),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 1000),
      delay: const Duration(milliseconds: 300),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withValues(alpha: .3),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(PersonalData.info.profileImageUrl),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactItem(context, Icons.email, PersonalData.info.email),
        const SizedBox(height: 8),
        _buildContactItem(context, Icons.phone, PersonalData.info.phone),
        const SizedBox(height: 8),
        _buildContactItem(
          context,
          Icons.location_on,
          PersonalData.info.location,
          isCopy: false,
        ),
      ],
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    IconData icon,
    String text, {
    bool isCopy = true,
  }) {
    Widget content = Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );

    if (isCopy) {
      return InkWell(
        onTap: () => ClipboardHelper.copy(context, text),
        child: content,
      );
    }
    return content;
  }

  Widget _buildSocialLinks(BuildContext context) {
    return Row(
      children: PersonalData.info.socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
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
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).secondaryHeaderColor,
          width: 2,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(link.url),
          borderRadius: BorderRadius.circular(24),
          child: Icon(
            icon,
            color: Theme.of(context).secondaryHeaderColor,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        GradientButton(
          text: 'Ver Projetos',
          onPressed: () {
            scrollToSection?.call(2);
          },
          width: 150,
        ),
      ],
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
