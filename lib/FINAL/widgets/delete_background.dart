import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DeleteBackground extends StatelessWidget {
  final BorderRadius borderRadius;
  final bool showLabel;

  const DeleteBackground({
    super.key,
    this.borderRadius = BorderRadius.zero,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLabel) ...[
            const Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.delete, color: Colors.white, size: 28),
        ],
      ),
    );
  }
}
