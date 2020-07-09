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
        title: Text('Student Database'),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  color: Colors.grey[200],
                ),
                height: 200,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 10),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 60,
                          color: Color(0xff77cc6d),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '.',
                        style: TextStyle(
                          fontSize: 70,
                          color: Color(0xff007aff),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                elevation: 10,
                color: Color(0xff007aff),
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
                        error = "Wrong credentials! Try again...";
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
              FlatButton.icon(
                icon: Icon(
                  Icons.person_add,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () => widget.toggleView(),
                label: Text('Dont have an account?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
