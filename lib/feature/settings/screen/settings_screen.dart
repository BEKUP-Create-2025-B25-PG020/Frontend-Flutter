// lib/feature/settings/screen/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:mantra_application/common/provider/theme_provider.dart';
import 'package:mantra_application/common/static/navigation_route.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // TAMBAHKAN INI
      appBar: AppBar(
        backgroundColor: Colors.transparent, // TAMBAHKAN INI
        elevation: 0, // TAMBAHKAN INI
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                title: const Text('Switch theme'),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Theme.of(context).colorScheme.primary,
              );
            },
          ),
          const Divider(height: 1),
          ListTile(
            title: const Text('Tentang Aplikasi'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, NavigationRoute.aboutRoute.name);
            },
          ),
        ],
      ),
    );
  }
}
