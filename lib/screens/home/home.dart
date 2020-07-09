import 'package:flutter/material.dart';
import 'package:login/models/item.dart';
import 'package:login/screens/home/itemtile.dart';
import 'package:login/screens/home/settingsform.dart';
import 'package:login/services/auth.dart';
import 'package:login/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    _showSettings() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Item>>.value(
      value: DatabaseService().items,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Color(0xff5e5ce6),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton.icon(
              onPressed: () {
                _showSettings();
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              label: Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: ItemList(),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ItemTile(item: items[index]);
      },
    );
  }
}
