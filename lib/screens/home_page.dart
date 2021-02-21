import 'package:event_entry/screens/lunch_ticket.dart';
import 'package:event_entry/screens/return_bus.dart';
import 'package:flutter/material.dart';

import 'package:event_entry/screens/bus_ticket.dart';
import '../shared/custom_app_bar.dart';
import 'package:event_entry/screens/entry_ticket.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _outputController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: 10),
    ));
  }

  @override
  initState() {
    super.initState();
    _outputController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar("Event Entry"),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BusTicket(),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset('images/bus.png'),
                          ),
                          Divider(height: 5),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Bus Ticket',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EntryTicket(),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset('images/ticket.png'),
                          ),
                          Divider(height: 5),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Entry Ticket',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LunchTicket(),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset('images/food.png'),
                          ),
                          Divider(height: 5),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Lunch Ticket',
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReturnBusTicket(),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Image.asset('images/bus_return.png'),
                          ),
                          Divider(height: 5),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Return Bus Ticket',
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
            ],
          );
        },
      ),
    );
  }
} //HomePage
