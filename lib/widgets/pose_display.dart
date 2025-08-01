import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yoga_session_provider.dart';

class PoseDisplay extends StatelessWidget {
  final String imageName;
  final String instruction;

  const PoseDisplay({
    super.key,
    required this.imageName,
    required this.instruction,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YogaSessionProvider>(context);
    final segment = provider.currentSegment;
    final total = segment!.endSec - segment.startSec;

    return Column(
      children: [
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset('assets/images/$imageName', fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: provider.progress),
              duration: const Duration(milliseconds: 300),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: 10,
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
              ),
            ),
          ),
        ),
        Text(
          "${(provider.progress * total).toInt()} / $total sec",
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              instruction,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black87,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
