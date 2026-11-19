import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../LW11/screens/vault_screen.dart';
import '../../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _openVault(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Consumer<ThemeProvider>(
          builder: (context, theme, child) => VaultScreen(
            storage: theme.storage,
            isDark: theme.isDark,
            onThemeChanged: theme.setDark,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Container(
              width: 104,
              height: 104,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.burgundy, Color(0xFFC0392B)],
                ),
              ),
              child: const Icon(Icons.person, size: 52, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Muktarkanuly Olzhas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'olzhas@student.edu.kz',
              style: TextStyle(color: AppColors.muted, fontSize: 15),
            ),
            const Text(
              '+7 (707) 000-00-00',
              style: TextStyle(color: AppColors.muted, fontSize: 15),
            ),
            const SizedBox(height: 28),
            _section(context, [
              SwitchListTile(
                value: theme.isDark,
                onChanged: theme.setDark,
                secondary: Icon(theme.isDark ? Icons.dark_mode : Icons.light_mode),
                title: const Text('Dark mode', style: TextStyle(fontSize: 16)),
                subtitle: const Text('Saved on this device'),
              ),
              _option(context, Icons.edit_note_rounded, 'Notes Vault',
                  onTap: () => _openVault(context)),
            ]),
            _section(context, [
              _option(context, Icons.shopping_bag_outlined, 'My Orders'),
              _option(context, Icons.favorite_border, 'Wishlist'),
              _option(context, Icons.location_on_outlined, 'Shipping Addresses'),
              _option(context, Icons.payment, 'Payment Methods'),
            ]),
            _section(context, [
              _option(context, Icons.settings_outlined, 'Settings'),
              _option(context, Icons.help_outline, 'Help & Support'),
            ]),
            _section(context, [
              _option(context, Icons.logout, 'Log Out', color: AppColors.danger),
            ]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _section(BuildContext context, List<Widget> children) {
    final items = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i != children.length - 1) {
        items.add(const Divider(height: 1, indent: 56));
      }
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: items),
    );
  }

  Widget _option(BuildContext context, IconData icon, String title,
      {Color? color, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
      onTap: onTap ?? () {},
    );
  }
}
