import 'dart:async';
import 'package:event_entry/shared/error_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../shared/custom_app_bar.dart';
import '../shared/loading_page.dart';
import 'package:event_entry/shared/error_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _outputController;
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 10),
    ));
  }

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  initState() {
    super.initState();
    _outputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingPage()
        : Scaffold(
            key: _scaffoldKey,
            appBar: CustomAppBar("Event Entry"),
            body: Builder(
              builder: (BuildContext context) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextField(
                      controller: _outputController,
                      readOnly: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Please Scan user id...',
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                    ),
                    SizedBox(height: 20),
                    _buttonGroup(),
                    SizedBox(height: 50),
                    RaisedButton(
                      padding: const EdgeInsets.all(20.0),
                      child: const Text('Clear input',
                          style: TextStyle(fontSize: 20)),
                      color: Colors.blueGrey,
                      onPressed: () {
                        _outputController.clear();
                      },
                    ),
                  ],
                );
              },
            ),
          );
  }

  Widget _buttonGroup() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 150,
            child: InkWell(
              onTap: _scan,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/scanner.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text('Scan')),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: SizedBox(
            height: 150,
            child: InkWell(
              onTap: _registerUser,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.asset('images/generate_qrcode.png'),
                    ),
                    Divider(height: 20),
                    Expanded(flex: 1, child: Text('Register')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future _scan() async {
    await Permission.camera.request();
    var barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      _outputController.text = barcode;
    }
  } //_scan

  void _registerUser() async {
    if (_outputController.text.isEmpty) {
      _showMessageInScaffold("Scan a user first");
    } else {
      setState(() => loading = true);
      DocumentSnapshot docSnapshot = await firestoreInstance
          .collection('users')
          .doc(_outputController.text)
          .get();

      if (docSnapshot.data() != null) {
        Map<String, dynamic> user = docSnapshot.data();
        bool entryPermission = user['entryPermission'];
        if (entryPermission) {
          await firestoreInstance
              .collection('users')
              .doc(_outputController.text)
              .set({
            'entryPermission': false,
          });
          _outputController.clear();
          setState(() => loading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ErrorPage(title: "Valid User")),
          );
        } else {
          _outputController.clear();
          setState(() => loading = false);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ErrorPage(title: "User already entered")),
          );
        } //else
      } else {
        _outputController.clear();
        setState(() => loading = false);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ErrorPage(title: "No user found")),
        );
      } //else
    } //else
  } //_registerUser
} //class
