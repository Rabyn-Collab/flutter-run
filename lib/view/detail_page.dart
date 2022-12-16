import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/models/movie.dart';
import 'package:flutterrun/services/movie_service.dart';
import 'package:pod_player/pod_player.dart';


class DetailPage extends StatelessWidget {
final Movie movie;
DetailPage(this.movie);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
          builder: (context, ref, child) {
            final videoData = ref.watch(videoProvider(movie.id));
            return ListView(
              children: [
                 videoData.when(
                     data: (data){
                      return VideoWidget(data[0].key);
                       // return Column(
                       //   children: data.map((e) => VideoWidget(e.key)).toList(),
                       // );
                     },
                     error: (err, stack) => Center(child: Text('$err')),
                     loading: () => Container()
                 )
              ],
            );
          }

        )
    );
  }
}





class VideoWidget extends StatefulWidget {
  final String videoKey;
  VideoWidget(this.videoKey);
  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.videoKey}'),
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: false,
      ),
    )..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      controller: controller,
      videoThumbnail: const DecorationImage(
        image: NetworkImage(
          'https://images.unsplash.com/photo-1569317002804-ab77bcf1bce4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dW5zcGxhc2h8ZW58MHx8MHx8&w=1000&q=80',
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}
