import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yoga_session_provider.dart';

class SessionControls extends StatelessWidget {
  const SessionControls({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YogaSessionProvider>(context);

    // Calculate next pose if exists
    String? nextPose;
    final session = provider.session;
    if (session != null &&
        provider.sequenceIndex < session.sequence.length) {
      final seq = session.sequence;
      final current = provider.sequenceIndex;
      if (current + 1 < seq.length) {
        final next = seq[current + 1];
        nextPose = next.name;
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (provider.state == YogaSessionState.playing)
              IconButton(
                icon: const Icon(Icons.pause_circle_filled, size: 60, color: Colors.grey),
                onPressed: () => provider.pause(),
              ),
            if (provider.state == YogaSessionState.paused)
              IconButton(
                icon: const Icon(Icons.play_circle_filled, size: 60, color: Colors.grey),
                onPressed: () => provider.resume(),
              ),
          ],
        ),
        if (nextPose != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Next: $nextPose",
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
      ],
    );
  }
}
