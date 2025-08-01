import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_session_app/widgets/preview_widget.dart';
import '../providers/yoga_session_provider.dart';
import 'session_screen.dart';

class PreviewScreen extends StatelessWidget {
  PreviewScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<YogaSessionProvider>(context, listen: false);
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: scaffoldKey,
      drawer: Drawer(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        child: Center(child: Text("Data Unavailable")),
      ),
      appBar: AppBar(
        title: Text(
          "Yoga Sessions",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple[400],
        elevation: 0,
      ),
      body: FutureBuilder(
        future: provider.loadSession(
          'assets/poses.json',
          startImmediately: false,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final session = provider.session!;
          final sequence = session.sequence;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  const SizedBox(height: 20),
              Center(
                child: Container(
                  margin: EdgeInsets.all(5),
                  height: size.height * .45,
                  width: size.width * .95,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurple[300]!,
                      width: 3
                    ),
                    color: Colors.deepPurple[100],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, -2),
                      ),
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(-2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          session.metadata.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sequence.length,
                          itemBuilder: (context, index) {
                            final step = sequence[index];
                            final imageKey = step.script.first.imageRef;
                            final imageName = session.assets.images[imageKey]!;
                            final totalDuration = step.durationSec;

                            return CustomPreviewCard(
                              path: 'assets/images/$imageName',
                              name: step.name
                                  .replaceAll('_', ' ')
                                  .toUpperCase(),
                              duration: totalDuration.toString(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.play_circle_outline, size: 26),
                  label: const Text(
                    "Start Session",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.deepPurpleAccent.withOpacity(0.3),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SessionScreen()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
