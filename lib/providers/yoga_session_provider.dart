import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../models/pose_model.dart';
import '../services/pose_loader.dart';

enum YogaSessionState { loading, playing, paused, completed }

class YogaSessionProvider extends ChangeNotifier {
  YogaSession? _session;
  int _sequenceIndex = 0;
  int _scriptIndex = 0;
  YogaSessionState _state = YogaSessionState.loading;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioPlayer _bgmPlayer = AudioPlayer();

  Timer? _timer;
  double _progress = 0;
  DateTime? _segmentStartTime;
  Duration? _segmentDuration;
  Duration _elapsedBeforePause = Duration.zero;
  DateTime? _progressStartTime;
  Timer? _progressUpdater;

  double get progress => _progress;
  YogaSession? get session => _session;
  int get sequenceIndex => _sequenceIndex;
  int get scriptIndex => _scriptIndex;
  YogaSessionState get state => _state;

  ScriptSegment? get currentSegment {
    if (_session == null) return null;
    return _session!.sequence[_sequenceIndex].script[_scriptIndex];
  }

  Future<void> loadSession(String path, {bool startImmediately = true}) async {
    _session = await PoseLoader.loadSession(path);
    _state = startImmediately
        ? YogaSessionState.playing
        : YogaSessionState.loading;

    if (startImmediately) {
      await _startBackgroundMusic();
      _playCurrentSegment();
    }

    notifyListeners();
  }

  void _playCurrentSegment() async {
    if (_session == null) return;

    final sequence = _session!.sequence[_sequenceIndex];
    final script = sequence.script[_scriptIndex];
    final audioPath = _session!.assets.audio[sequence.audioRef]!;

    // await _audioPlayer.setPlayerMode(PlayerMode.lowLatency);
    await _audioPlayer.play(AssetSource('audio/$audioPath'));
    await _audioPlayer.setVolume(1.0);

    _segmentDuration = Duration(seconds: script.endSec - script.startSec);
    _elapsedBeforePause = Duration.zero;
    _progressStartTime = DateTime.now();
    _progress = 0;

    _timer = Timer(_segmentDuration!, nextSegment);

    _startProgressUpdater();

    notifyListeners();
  }

  Future<void> _startBackgroundMusic() async {
    try {
      // await _bgmPlayer.setPlayerMode(PlayerMode.mediaPlayer);
      await _bgmPlayer.setReleaseMode(ReleaseMode.loop);
      await _bgmPlayer.setVolume(.5);
      await _bgmPlayer.play(AssetSource('audio/bgm.mp3'));
    } catch (e) {
      log("Error playing BGM: $e");
    }
  }

  void _startProgressUpdater() {
    _progressUpdater?.cancel();

    _progressUpdater = Timer.periodic(const Duration(milliseconds: 200), (
      timer,
    ) {
      if (_state != YogaSessionState.playing ||
          _progressStartTime == null ||
          _segmentDuration == null) {
        timer.cancel();
        return;
      }

      final sinceResume = DateTime.now().difference(_progressStartTime!);
      final totalElapsed = _elapsedBeforePause + sinceResume;

      _progress =
          (totalElapsed.inMilliseconds / _segmentDuration!.inMilliseconds)
              .clamp(0.0, 1.0);
      notifyListeners();

      if (_progress >= 1.0) {
        timer.cancel();
      }
    });
  }

  void nextSegment() {
    final sequence = _session!.sequence[_sequenceIndex];

    if (_scriptIndex < sequence.script.length - 1) {
      _scriptIndex++;
    } else {
      if (_sequenceIndex < _session!.sequence.length - 1) {
        _sequenceIndex++;
        _scriptIndex = 0;
      } else {
        _state = YogaSessionState.completed;
        _audioPlayer.stop();
        _bgmPlayer.stop();
        notifyListeners();
        return;
      }
    }
    _playCurrentSegment();
  }

  void pause() {
    _audioPlayer.pause();
    _bgmPlayer.pause();
    _timer?.cancel();

    if (_progressStartTime != null) {
      _elapsedBeforePause += DateTime.now().difference(_progressStartTime!);
    }

    _progressUpdater?.cancel();
    _state = YogaSessionState.paused;
    notifyListeners();
  }

  void resume() {
    _state = YogaSessionState.playing;
    _audioPlayer.resume();
    _bgmPlayer.resume();

    _progressStartTime = DateTime.now();

    final remaining = _segmentDuration! - _elapsedBeforePause;
    _timer = Timer(remaining, nextSegment);

    _startProgressUpdater();
    notifyListeners();
  }

  void resetSession() {
    _timer?.cancel();
    _progressUpdater?.cancel();
    _audioPlayer.stop();
    _bgmPlayer.stop();

    _state = YogaSessionState.loading;
    _sequenceIndex = 0;
    _scriptIndex = 0;
    _progress = 0;
    _segmentStartTime = null;
    _segmentDuration = null;
    _elapsedBeforePause = Duration.zero;

    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _bgmPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
