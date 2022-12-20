import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.ac_unit_sharp),
      title: Text('hello word 1'),
      subtitle: Text('lorem ipsum 1'),
    );
  }
}

