import 'package:flutter/material.dart';
import 'package:login/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  String email;
  String password;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
            label: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
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
                  fillColor: Colors.grey[200],
                  filled: true,
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
                  fillColor: Colors.grey[200],
                  filled: true,
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
                  'Sign In',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result =
                        await _auth.signInWithEmailnPass(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Couldnt sign in";
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
