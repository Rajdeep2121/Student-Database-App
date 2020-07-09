import 'package:flutter/material.dart';
import 'package:login/models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 10,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.blue,
          ),
          title: Text(item.item),
          subtitle: Text('Age: ${item.count}'),
        ),
      ),
    );
  }
}
