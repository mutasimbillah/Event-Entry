import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ReturnBusTicketDetails extends StatelessWidget {
  ReturnBusTicketDetails({Key key, @required this.phone, this.name, this.email})
      : super(key: key);

  final databaseReference = FirebaseDatabase.instance.reference();
  final String phone;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Return Bus Ticket Details"),
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
                        .update({'bus_return_ticket': 'false'});
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
