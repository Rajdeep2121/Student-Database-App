import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import 'package:login/services/database.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  String _currentItem;
  String _currentCount;
  String _currentEmail;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update Details',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'New Name',
                    ),
                    onChanged: (val) => setState(() => _currentItem = val),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'New Age',
                    ),
                    onChanged: (val) => setState(() => _currentCount = val),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'New Email',
                    ),
                    validator: (val) => null,
                    onChanged: (val) => setState(() => _currentEmail = val),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Color(0xff00695c),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                          _currentItem ?? userData.item,
                          _currentCount ?? userData.count,
                          _currentEmail ?? userData.email,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          }
        });
  }
}
