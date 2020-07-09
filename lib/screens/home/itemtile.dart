import 'package:flutter/material.dart';
import 'package:login/models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[300],
        ),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Icon(
              Icons.person,
              size: 45,
              color: Colors.white,
            ),
            backgroundColor: Colors.black,
          ),
          title: Text(
            item.item,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          isThreeLine: true,
          subtitle: Text(
            'Email: ${item.email}\nAge: ${item.count}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
