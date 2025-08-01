// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/yoga_session_provider.dart';

class SessionControls extends StatelessWidget {
  const SessionControls({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YogaSessionProvider>(context);
    Size size = MediaQuery.sizeOf(context);
    String? nextPose;
    final session = provider.session;
    if (session != null && provider.sequenceIndex < session.sequence.length) {
      final seq = session.sequence;
      final current = provider.sequenceIndex;
      if (current + 1 < seq.length) {
        final next = seq[current + 1];
        nextPose = next.name;
      }
    }

    return InkWell(
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        if (provider.state == YogaSessionState.playing) {
          provider.pause();
        } else {
          provider.resume();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size.width * 0.25,
            height: size.width * 0.25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [const Color.fromARGB(111, 126, 87, 194), Colors.white],
                center: Alignment.center,
                radius: 0.6,
              ),
            ),
          ),
          Container(
            width: size.width * 0.2,
            height: size.width * 0.2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [const Color(0xFF512DA8), const Color(0xFF9575CD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurpleAccent.withOpacity(0.5),
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                ),
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    226,
                    222,
                    222,
                  ).withOpacity(0.1),
                  offset: const Offset(-4, -4),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: size.width * 0.18,
                height: size.width * 0.18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          Icon(
            provider.state == YogaSessionState.playing
                ? Icons.pause
                : Icons.play_arrow_rounded,
            size: provider.state == YogaSessionState.playing
                ? size.width * 0.11
                : size.width * 0.10,
            color: const Color.fromARGB(255, 235, 235, 235),
            shadows: [
              BoxShadow(
                color: const Color(0xFFE1BEE7),
                offset: const Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
