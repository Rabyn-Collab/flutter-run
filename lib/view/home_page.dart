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
        body: ListView(
          children: [
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Image.asset('assets/book.jpg', height: 250, width: double.infinity)),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 260,
         child: ListView.builder(
           scrollDirection: Axis.horizontal,
              itemCount: booksData.length,
             itemBuilder: (context, index){
                return Container(
                  margin: EdgeInsets.only(right: 7),
                  padding: index == 0 ? EdgeInsets.only(left: 10): null,
                  width: 390,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(booksData[index].imageUrl, width: 140, fit: BoxFit.cover, height: 200,)),
                      Expanded(
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(booksData[index].label, style: TextStyle(fontSize: 17),),
                                Text(booksData[index].detail,maxLines: 4, style: TextStyle(fontSize: 16),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(booksData[index].rating),
                                    TextButton(
                                        onPressed: (){},
                                        child: Text(booksData[index].genres)
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
             }
         ),
        ),


            Container(
              margin: EdgeInsets.only(top: 10),
              height: 300,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: booksData.length,
                  itemBuilder: (context, index){
                    return Container(
                      margin: EdgeInsets.only(right: 7),
                      padding: index == 0 ? EdgeInsets.only(left: 10): null,
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(booksData[index].imageUrl, width: 140, fit: BoxFit.cover, height: 200,)),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(booksData[index].label, style: TextStyle(fontSize: 14),),
                                TextButton(
                                    onPressed: (){},
                                    child: Text(booksData[index].genres)
                                )
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
