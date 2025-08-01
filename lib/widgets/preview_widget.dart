import 'package:flutter/material.dart';

class CustomPreviewCard extends StatelessWidget {
  final String path;
  final String name;
  final String duration;
  const CustomPreviewCard({
    super.key,
    required this.path,
    required this.name,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.white70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            path,
            height: 48,
            width: 48,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Duration: ${duration}s"),
      ),
    );
  }
}
