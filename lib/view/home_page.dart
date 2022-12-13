import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/view/widgets/tabs_widget.dart';
import '../providers/movie_provider.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 79,
          flexibleSpace: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('MovieShow', style: TextStyle(color: Colors.red, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined))
                  ],
                ),
              ),
            ),
          ),
          bottom: TabBar(
            indicator: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(20)
            ),
              tabs: [
                Tab(text: 'Popular'),
                Tab(text: 'Top_rated'),
                Tab(text: 'UpComing'),
              ]
          ),
        ),
          body: TabBarView(
              children: [
            TabsWidget(popularProvider),
            TabsWidget(topProvider),
            TabsWidget(upcomingProvider),
          ])
      ),
    );
  }
}
