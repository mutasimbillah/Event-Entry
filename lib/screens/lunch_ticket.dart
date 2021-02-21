import 'dart:async';
import 'package:event_entry/screens/entry_ticket_details.dart';
import 'package:event_entry/screens/lunch_ticket_details.dart';
import 'package:event_entry/shared/error_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../shared/custom_app_bar.dart';
import '../shared/loading_page.dart';
import 'bus_ticket_details.dart';

class LunchTicket extends StatefulWidget {
  @override
  _LunchTicketState createState() => _LunchTicketState();
}

class _LunchTicketState extends State<LunchTicket> {
  TextEditingController _outputController;
  bool loading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 5),
    ));
  }

  final databaseReference = FirebaseDatabase.instance.reference();

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
            appBar: CustomAppBar("Lunch Ticket"),
            body: Builder(
              builder: (BuildContext context) {
                return Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    TextField(
                      controller: _outputController,
                      readOnly: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Please Scan Ticket',
                        hintStyle: TextStyle(fontSize: 20),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                    ),
                    SizedBox(height: 5),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        child: InkWell(
                          onTap: _scan,
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Image.asset('images/scanner.png'),
                                ),
                                Divider(height: 5),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Scan Ticket',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 60,
                        child: InkWell(
                          onTap: _check,
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child:
                                      Image.asset('images/generate_qrcode.png'),
                                ),
                                Divider(height: 5),
                                Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Check Ticket Status',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: _clear,
                        child: Card(
                          child: Column(
                            children: <Widget>[
                              Divider(height: 5),
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  'Clear Input',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Divider(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }

  Future _scan() async {
    await Permission.camera.request();
    var barcode = await scanner.scan();
    if (barcode == null) {
      _outputController.text = "Noting Found";
    } else {
      _outputController.text = barcode;
    }
  } //_scan

  void _clear() {
    _outputController.clear();
  }

  Future<void> _check() async {
    String status;
    String _phone;
    String _name;
    String _email;
    //print("Click");
    //_outputController.text = "01675339460";
    if (_outputController.text.isEmpty) {
      _showMessageInScaffold("Scan a user first");
    } else {
      setState(() => loading = true);
      DatabaseReference dataSnapshot =
          databaseReference.child(_outputController.text);
      await dataSnapshot.once().then(
            (data) => {
              if (data.value != null)
                {
                  status = data.value['lunch_ticket'],
                  if (status == 'true')
                    {
                      _name = data.value['name'],
                      _email = data.value['email'],
                      _phone = _outputController.text,
                      setState(() => loading = false),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LunchTicketDetails(
                                name: _name, email: _email, phone: _phone)),
                      ),
                    }
                  else
                    {
                      setState(() => loading = false),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ErrorPage(title: "Launch ticket already used"),
                        ),
                      ),
                    }
                }
              else
                {
                  setState(() => loading = false),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ErrorPage(title: "No Ticket Found"),
                    ),
                  ),
                }
            },
          );
    }
  }
}
