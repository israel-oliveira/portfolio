import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.scrollToSection});

  final void Function(int index)? scrollToSection;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: () => context.pop(), icon: Icon(Icons.close))],
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Início'),
            onTap: () => scrollToSection?.call(0),
          ),
          ListTile(
            leading: const Icon(Icons.code_outlined),
            title: const Text('Stack'),
            onTap: () => scrollToSection?.call(1),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Projetos'),
            onTap: () => scrollToSection?.call(2),
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text('Estudos'),
            onTap: () => scrollToSection?.call(3),
          ),
          ListTile(
            leading: const Icon(Icons.verified_outlined),
            title: const Text('Certificados'),
            onTap: () => scrollToSection?.call(4),
          ),
        ],
      ),
    );
  }
}
