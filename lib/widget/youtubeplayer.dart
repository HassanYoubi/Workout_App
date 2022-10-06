//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatelessWidget {
  static String myVideoId = 'PQSagzssvUQ';
  final String urlVideo;
  //YoutubePlayerController _controller;

  const YoutubePlayerWidget({Key? key, required this.urlVideo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final YoutubePlayerController _controller = YoutubePlayerController(
      // ignore: unnecessary_this
      initialVideoId: YoutubePlayer.convertUrlToId(urlVideo) ?? 'PQSagzssvUQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Container(
        color: Colors.blue[900],
        child: YoutubePlayer(
          //aspectRatio: 1.25,
          controller: _controller,
          liveUIColor: Colors.grey,
        ));
  }
}
