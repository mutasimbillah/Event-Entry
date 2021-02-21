import 'package:flutter/material.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({Key key, @required this.mobile, this.name, this.email})
      : super(key: key);
  final String mobile;
  final String name;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Name : " + name,
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 20.0),
              Text(
                "Email : " + email,
                style: TextStyle(fontSize: 15.0),
              ),
              SizedBox(height: 20.0),
              Text(
                "Mobile : " + mobile,
                style: TextStyle(fontSize: 15.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
} //ErrorPage
