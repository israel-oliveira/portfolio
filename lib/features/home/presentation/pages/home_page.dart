import 'package:flutter/material.dart';
import 'package:profile_app/features/home/presentation/widgets/app_drawer.dart';
import '../widgets/banner_section.dart';
import '../widgets/tech_stack_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/studies_section.dart';
import '../widgets/certificates_section.dart';
import '../widgets/footer_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(scrollToSection: _scrollToSection),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Banner Section
          SliverToBoxAdapter(
            child: BannerSection(scrollToSection: _scrollToSection),
          ),

          // Tech Stack Section
          const SliverToBoxAdapter(child: TechStackSection()),

          // Projects Section
          const SliverToBoxAdapter(child: ProjectsSection()),

          // Studies Section
          const SliverToBoxAdapter(child: StudiesSection()),

          // Certificates Section
          const SliverToBoxAdapter(child: CertificatesSection()),

          // Footer Section
          const SliverToBoxAdapter(child: FooterSection()),
        ],
      ),
    );
  }

  void _scrollToSection(int section) {
    double offset = 0;
    switch (section) {
      case 0:
        offset = 0;
        break;
      case 1:
        offset = 800;
        break;
      case 2:
        offset = 1400;
        break;
      case 3:
        offset = 2200;
        break;
      case 4:
        offset = 3000;
        break;
    }

    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
}
