import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_session_app/widgets/pose_controls.dart';
import 'package:yoga_session_app/widgets/pose_display.dart';
import '../providers/yoga_session_provider.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  void initState() {
    super.initState();

    final sessionProvider = Provider.of<YogaSessionProvider>(
      context,
      listen: false,
    );
    sessionProvider.loadSession('assets/poses.json');
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YogaSessionProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          provider.session!.metadata.title,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Consumer<YogaSessionProvider>(
          builder: (context, provider, _) {
            final sequence = provider.session!.sequence[provider.sequenceIndex];
            final segment = sequence.script[provider.scriptIndex];
            if (provider.state == YogaSessionState.loading ||
                provider.session == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (provider.state == YogaSessionState.completed) {
              return const Center(
                child: Text(
                  'Session Completed 🎉',
                  style: TextStyle(color: Colors.black87, fontSize: 20),
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Now: ${sequence.name.replaceAll('_', ' ').toUpperCase()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ),

                Expanded(
                  flex: 6,
                  child: PoseDisplay(
                    imageName:
                        provider.session!.assets.images[segment!.imageRef]!,
                    instruction: segment.text,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(flex: 2, child: SessionControls()),
              ],
            );
          },
        ),
      ),
    );
  }
}
