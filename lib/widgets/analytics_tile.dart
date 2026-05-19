import 'package:flutter/material.dart';

Widget analyticsTile(
  String title,
  String value,
  Color color,
  BuildContext context,
) {
  return Container(
    width: MediaQuery.of(context).size.width / 3,

    padding: const EdgeInsets.all(16),

    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(16),
    ),

    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),

        const SizedBox(height: 4),

        Text(title),
      ],
    ),
  );
}
