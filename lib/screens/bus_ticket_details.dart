import 'dart:async';
import 'package:event_entry/screens/bus_ticket.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class BusTicketDetails extends StatelessWidget {
  BusTicketDetails({Key key, @required this.phone, this.name, this.email})
      : super(key: key);

  final databaseReference = FirebaseDatabase.instance.reference();
  final String phone;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bus Ticket Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  "Mobile : " + phone,
                  style: TextStyle(fontSize: 15.0),
                ),
                Divider(
                  height: 20.0,
                  color: Colors.black,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text('Register Ticket',
                      style: TextStyle(fontSize: 20)),
                  color: Colors.blueGrey,
                  onPressed: () async {
                    databaseReference
                        .child(this.phone)
                        .update({'bus_ticket': 'false'});
                    Navigator.pop(context);
                    //_showAlertDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} //BusTicketDetails

void _showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Success"),
    content: Text("Ticket status updated"),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
