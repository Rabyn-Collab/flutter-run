import 'package:flutter/material.dart';



class Sample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final actualH = height - MediaQuery.of(context).padding.top -70;
    print(height);
    print(width);
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            title: Text('hello'),
          ),
          preferredSize: Size(double.infinity, 70)),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.purple,
                height: actualH * 0.25,
                width: width,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.50,
                          width: width * 0.20,
                          color: Colors.white,
                        )
                      ],
                    );
                  }
                ),
              ),
              Container(
                color: Colors.redAccent,
                height: actualH * 0.25,
                width: width,
              ),
              Container(
                color: Colors.black,
                height: actualH * 0.25,
                width: width,
              ),
              Container(
                color: Colors.teal,
                height: actualH * 0.25,
                width: width,
              ),
            ],
          ),
        )
    );
  }
}
