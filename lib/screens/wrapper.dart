import 'package:flutter/material.dart';
import 'package:login/models/user.dart';
import 'package:login/screens/authenticate/authenticate.dart';
import 'package:login/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return user == null ? Authenticate() : Home();
  }
}
