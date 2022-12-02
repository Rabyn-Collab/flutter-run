import 'package:flutter/material.dart';
import 'package:flutterrun/models/book.dart';


class DetailPage extends StatelessWidget {

  final Book book;
  DetailPage(this.book);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              Image.network(book.imageUrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(book.label),
                        Column(
                          children: [
                            Text(book.genres),
                            Text(book.rating),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(book.detail),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: (){}, child: Text('Read book')),
                        SizedBox(width: 17,),
                        OutlinedButton(onPressed: (){}, child: Text('more info'))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
