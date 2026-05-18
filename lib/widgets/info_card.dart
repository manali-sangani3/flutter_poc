

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget infoCard({required String title, required String value}) {
  return Card(
    margin: const EdgeInsets.only(bottom: 12),
    child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),

          const SizedBox(height: 8),

          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    ),
  );
}