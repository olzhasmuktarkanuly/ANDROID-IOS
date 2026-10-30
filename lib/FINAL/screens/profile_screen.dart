import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  colors: [AppColors.ink, Color(0xFF4A4A4A)],
                ),
              ),
              child: const Icon(Icons.person, size: 52, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text(
              'Muktarkanuly Olzhas',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
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
            _section([
              _option(Icons.shopping_bag_outlined, 'My Orders'),
              _option(Icons.favorite_border, 'Wishlist'),
              _option(Icons.location_on_outlined, 'Shipping Addresses'),
              _option(Icons.payment, 'Payment Methods'),
            ]),
            _section([
              _option(Icons.settings_outlined, 'Settings'),
              _option(Icons.help_outline, 'Help & Support'),
            ]),
            _section([
              _option(Icons.logout, 'Log Out', color: AppColors.danger),
            ]),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _section(List<Widget> children) {
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: items),
    );
  }

  Widget _option(IconData icon, String title,
      {Color color = AppColors.ink}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
      onTap: () {},
    );
  }
}
