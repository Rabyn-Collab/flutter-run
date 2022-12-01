import 'package:flutter/material.dart';


class Sample extends StatelessWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: 200,
            color: Colors.brown,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Image.asset('assets/book.jpg'),
                SizedBox(width: 10,),
                Column(
                  children: [
                    Text('hello world 5', style: TextStyle(color: Colors.white, fontSize: 20),),
                    SizedBox(height: 20,),
                    Text('hello world 5', style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
