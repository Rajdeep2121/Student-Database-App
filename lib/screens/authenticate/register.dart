import 'package:flutter/material.dart';
import 'package:login/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: InputDecoration(
                  labelText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      email = val;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) =>
                    val.length < 6 ? 'Enter a password longer' : null,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                elevation: 10,
                color: Colors.black,
                child: Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.registerWithEmailnPass(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Error logging in";
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
