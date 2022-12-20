import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterrun/view/search_page.dart';
import 'package:flutterrun/view/widgets/popular_widget.dart';
import 'package:flutterrun/view/widgets/tabs_widget.dart';
import 'package:get/get.dart';
import '../providers/movie_provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
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
                    IconButton(onPressed: (){
                      Get.to(() => SearchPage(), transition: Transition.leftToRight);
                    }, icon: Icon(Icons.search_outlined))
                  ],
                ),
              ),
            ),
          ),
          bottom: TabBar(
            physics: NeverScrollableScrollPhysics(),
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
            physics: NeverScrollableScrollPhysics(),
              children: [
            PopularWidget(popularProvider, 'popular'),
            TabsWidget(topProvider, 'top'),
            TabsWidget(upcomingProvider, 'upcoming'),
          ])
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
//
// import '../common_widgets/tile_widget.dart';
//
// class HomePage1 extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               _buildListTile(Icons.add_chart_outlined, 'hello world', 'lorem2'),
//               _buildListTile(Icons.account_tree, 'hello world1', 'lorem3'),
//               _buildListTile(Icons.add_call, 'hello world2', 'lorem4'),
//               ListTileWidget()
//             ],
//           ),
//         )
//     );
//   }
//
//   ListTile _buildListTile(IconData icons, String label, String sub) {
//     return ListTile(
//       leading: Icon(icons),
//       title: Text(label),
//       subtitle: Text(sub),
//     );
//   }
// }
//





