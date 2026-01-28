import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

class AudioNoteTile extends StatefulWidget {
  const AudioNoteTile({
    super.key,
    required this.path,
    required this.title,
    this.onDelete,
  });

  final String path;
  final String title;
  final VoidCallback? onDelete;

  @override
  State<AudioNoteTile> createState() => _AudioNoteTileState();
}

class _AudioNoteTileState extends State<AudioNoteTile> {
  FlutterSoundPlayer? _player;
  bool _ready = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _player = FlutterSoundPlayer();
    await _player!.openPlayer();
    if (!mounted) return;
    setState(() => _ready = true);
  }

  @override
  void dispose() {
    _player?.closePlayer();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (!_ready) return;
    final file = File(widget.path);
    if (!file.existsSync()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio file not found.')),
      );
      return;
    }

    if (_isPlaying) {
      await _player!.stopPlayer();
      if (!mounted) return;
      setState(() => _isPlaying = false);
      return;
    }

    setState(() => _isPlaying = true);
    await _player!.startPlayer(
      fromURI: widget.path,
      codec: Codec.aacMP4,
      whenFinished: () {
        if (!mounted) return;
        setState(() => _isPlaying = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final icon = _isPlaying ? Icons.stop_circle_outlined : Icons.play_circle_outline;
    return Row(
      children: [
        IconButton(
          tooltip: _isPlaying ? 'Stop' : 'Play',
          onPressed: _ready ? _toggle : null,
          icon: Icon(icon),
        ),
        Expanded(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        if (widget.onDelete != null)
          IconButton(
            tooltip: 'Delete',
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete_outline),
          ),
      ],
    );
  }
}

