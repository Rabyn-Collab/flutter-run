import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/book.dart';


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.cyanAccent,
      backgroundColor: Color(0xFFF2F5F9),
      // backgroundColor: Colors.cyan[500],
      // backgroundColor: Color.fromRGBO(20, 50, 100, 0.9),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F5F9),
          elevation: 0,
          title: Text('Hi John,', style: TextStyle(color: Colors.black),),
          actions: [
           IconButton(
               onPressed: (){},
               icon: Icon(CupertinoIcons.search, color: Colors.black,)
           ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              // padding: const EdgeInsets.all(10),
              // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: IconButton(
                  onPressed: (){},
                  icon: Icon(CupertinoIcons.bell_solid, color: Colors.black,)
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset('assets/book.jpg', height: 250, width: double.infinity)),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 300,
         child: ListView.builder(
           scrollDirection: Axis.horizontal,
              itemCount: booksData.length,
             itemBuilder: (context, index){
                return Container(
                  width: 350,
                  child: Row(
                    children: [
                      Expanded(child: Image.network(booksData[index].imageUrl)),
                      Expanded(
                        child: Column(
                          children: [
                            Text(booksData[index].label, style: TextStyle(fontSize: 20),),
                            Text(booksData[index].detail, style: TextStyle(fontSize: 20),),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
             }
         ),
        )
          ],
        )
    );
  }
}
