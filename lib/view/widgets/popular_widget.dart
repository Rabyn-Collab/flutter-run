import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/movie.dart';
import '../detail_page.dart';

class PopularWidget extends StatelessWidget {
  final provider;
  final String pageKey;
  PopularWidget(this.provider, this.pageKey);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: OfflineBuilder(
          child: Container(),
          connectivityBuilder: (c, connectivity, child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Consumer(builder: (context, ref, child) {
              final movieState = ref.watch(provider);

              if (movieState.isLoad) {
                return Center(child: CircularProgressIndicator());
              } else if (movieState.err.isNotEmpty) {
                if (movieState.err == 'No Internet.') {
                  final box = Hive.box<String>('movieBox');
                  if (box.isNotEmpty) {
                    final data = jsonDecode(box.get('movie')!);
                    final newData =
                        (data as List).map((e) => Movie.fromJson(e)).toList();
                    return _buildNotificationListener(ref, newData);
                  } else {
                    return Center(child: Text(movieState.err));
                  }
                } else {
                  return Center(child: Text(movieState.err));
                }
              } else {
                return _buildNotificationListener(ref, movieState.movies);
              }
            });
          }),
    );
  }

  NotificationListener<ScrollEndNotification> _buildNotificationListener(
      WidgetRef ref, List<Movie> newData) {
    return NotificationListener(
      onNotification: (ScrollEndNotification onNotification) {
        final before = onNotification.metrics.extentBefore;
        final max = onNotification.metrics.maxScrollExtent;
        if (before == max) {
          ref.read(provider.notifier).loadMore();
        }
        return true;
      },
      child: GridView.builder(
          key: PageStorageKey(pageKey),
          itemCount: newData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5),
          itemBuilder: (context, index) {
            final movie = newData[index];
            return InkWell(
              onTap: () {
                Get.to(() => DetailPage(movie),
                    transition: Transition.leftToRight);
              },
              // splashColor: Colors.purple,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                      errorWidget: (c, s, d) {
                        return Image.asset('assets/movie.png');
                      },
                      placeholder: (context, string) {
                        return Center(
                            child: SpinKitFadingCube(
                          color: Colors.pinkAccent,
                          size: 30,
                        ));
                      },
                      imageUrl: movie.poster_path)),
            );
          }),
    );
  }
}
