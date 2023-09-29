// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:off_the_hook/screens/screens.dart';
import 'package:off_the_hook/variables.dart';
import 'package:off_the_hook/classes/video.dart';

class DummyVideoCard extends StatelessWidget {
  const DummyVideoCard({super.key,required this.displayThumbnail});
  final bool displayThumbnail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            if(displayThumbnail)...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(color: Colors.grey[800]),
                ),
              )
            ],
            const SizedBox(height: 8),
            const SizedBox(
              width : 220,
              height: 10,
              child: ColoredBox(color: Colors.white60),
              ),
            const SizedBox(height: 8),
            const SizedBox(
              width : 200,
              height: 2,
              child: ColoredBox(color: Colors.white60),
              ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
    );
  }
}
class VideoCard extends StatelessWidget {
  const VideoCard({
    super.key,
    required this.videoTitle,
    required this.channelName,
    required this.views,
    this.displayThumbnail = true,
    this.thumbnailURL = "",
    this.videoURL = "",
    this.videoDescription = "",
    this.publishedText = ""
  });

  final String thumbnailURL;
  final String videoTitle;
  final String channelName;
  final int views;
  final bool displayThumbnail;
  final String publishedText;

  final String videoDescription;
  final String videoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: GestureDetector(
        onTap: () async => await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
      appBar: AppBar(shadowColor: Colors.transparent),
      backgroundColor: bgColor,
      body: PlayingNow(channelName: channelName, videoURL: videoURL,videoDescription: videoDescription, videoTitle: videoTitle, views: views),
    )),
  ),
        child: Column(
          children: [
            if(displayThumbnail)...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(thumbnailURL, fit: BoxFit.fitWidth),
                ),
              )
            ],
            Text(
              videoTitle,
              style: generalTextStyle(videoTitleSize, FontWeight.w700, 1),
            ),
            Text(
                  "$channelName  •  $views views  •  $publishedText",
                  style: generalTextStyle(smallTextSize, FontWeight.w600, 0.6),
                ),
           
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}

class FutureVideoCard extends StatelessWidget {
  const FutureVideoCard({super.key,required this.videoId});
  final String videoId;
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Video>(
      future: fetchVideoData(videoId),
      builder: (context, snapshot) {
        if (snapshot.hasData)
        {
          var data = snapshot.data!;
          return VideoCard(
            thumbnailURL: data.thumbnailURL,
            videoTitle: data.title,
            channelName: data.channelName,
            views: data.viewCount,
            videoDescription: data.videoDescription,
            videoURL: data.videoURL,
            publishedText: data.publishedText,
          ); 
        } 
        else if (snapshot.hasError) return Text('${snapshot.error}');
        else return const DummyVideoCard(displayThumbnail: true);
      },
    );
  }
}

