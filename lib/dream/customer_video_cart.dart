import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String title, category, videoUrl;

  const VideoCard({super.key, required this.title, required this.category, required this.videoUrl});

  @override
  _VideoCardState createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          ListTile(
            title: Text(widget.title),
            subtitle: Text(widget.category),
            trailing: IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  _isPlaying ? _controller.pause() : _controller.play();
                  _isPlaying = !_isPlaying;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}