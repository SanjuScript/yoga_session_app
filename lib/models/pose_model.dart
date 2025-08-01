class YogaSession {
  final Metadata metadata;
  final Assets assets;
  final List<SequenceStep> sequence;

  YogaSession({
    required this.metadata,
    required this.assets,
    required this.sequence,
  });

  factory YogaSession.fromJson(Map<String, dynamic> json) {
    return YogaSession(
      metadata: Metadata.fromJson(json['metadata']),
      assets: Assets.fromJson(json['assets']),
      sequence: (json['sequence'] as List)
          .map((e) => SequenceStep.fromJson(e))
          .toList(),
    );
  }
}

class Metadata {
  final String id;
  final String title;
  final String category;
  final int defaultLoopCount;
  final String tempo;

  Metadata({
    required this.id,
    required this.title,
    required this.category,
    required this.defaultLoopCount,
    required this.tempo,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        defaultLoopCount: json['defaultLoopCount'],
        tempo: json['tempo'],
      );
}

class Assets {
  final Map<String, String> images;
  final Map<String, String> audio;

  Assets({
    required this.images,
    required this.audio,
  });

  factory Assets.fromJson(Map<String, dynamic> json) => Assets(
        images: Map<String, String>.from(json['images']),
        audio: Map<String, String>.from(json['audio']),
      );
}

class SequenceStep {
  final String type;
  final String name;
  final String audioRef;
  final int durationSec;
  final int? iterations;
  final bool? loopable;
  final List<ScriptSegment> script;

  SequenceStep({
    required this.type,
    required this.name,
    required this.audioRef,
    required this.durationSec,
    this.iterations,
    this.loopable,
    required this.script,
  });

  factory SequenceStep.fromJson(Map<String, dynamic> json) => SequenceStep(
        type: json['type'],
        name: json['name'],
        audioRef: json['audioRef'],
        durationSec: json['durationSec'],
        iterations: json['iterations'] is int ? json['iterations'] : null,
        loopable: json['loopable'] ?? false,
        script: (json['script'] as List)
            .map((e) => ScriptSegment.fromJson(e))
            .toList(),
      );
}

class ScriptSegment {
  final String text;
  final int startSec;
  final int endSec;
  final String imageRef;

  ScriptSegment({
    required this.text,
    required this.startSec,
    required this.endSec,
    required this.imageRef,
  });

  factory ScriptSegment.fromJson(Map<String, dynamic> json) =>
      ScriptSegment(
        text: json['text'],
        startSec: json['startSec'],
        endSec: json['endSec'],
        imageRef: json['imageRef'],
      );
}
