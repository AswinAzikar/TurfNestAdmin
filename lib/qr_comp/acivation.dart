import 'dart:math';
import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/ticketmodel.dart';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/routes.dart';

class studentlist extends StatefulWidget {
  final String id;

  const studentlist({
    super.key,
    required this.id,
  });

  @override
  // ignore: library_private_types_in_public_api
  _studentlistState createState() => _studentlistState();
}

class _studentlistState extends State<studentlist> {
  bool isloading = false;
  List<ticket_Model> tickethistory = [];

  ticket_Model? singlehistory;
  List<String>? both_id_and_Qr;
  String? studentPhoto;
  ticket_Model? singlestudent;

  final _controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    getstudentlist();
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  void getstudentlist() async {
    setState(() {
      isloading = true;
    });
    tickethistory = await FirebaseFirestoreHelper.instance
        .getqrdetails(int.parse(widget.id));
    ticket_Model a = tickethistory[0];
    singlestudent = a;

    setState(() {
      isloading = false;
    });
  }

  sendnotification(String title, String subtitle) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10, channelKey: "basic_channel", title: title, body: subtitle),
        actionButtons: [
          NotificationActionButton(
            label: 'OK',
            enabled: true,
            key: 'test',
          )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              "CONFIRM SLOT",
              style: TextStyle(
                color: AppColors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: isloading
              ? Center(
                  child: Container(
                    color: Colors.white,
                    height: 150,
                    width: 300,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                    alignment: Alignment.center,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Container(
                    height: 500,
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0),
                      border: Border.all(color: Colors.black, width: 3),
                    ),
                    child: Column(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: AppColors.blue,
                          foregroundColor: AppColors.white,
                          child: Icon(Icons.airplane_ticket),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Ticket Number:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text('Email:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text('Phone:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text('Time Slot:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text('Date:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text('Sport:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10.0),
                                  Text('Amount:',
                                      style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(
                                width: 16.0), // Add space between columns
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  singlestudent!.ticketid.toString(),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.email,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.phone,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.time.toString(),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.date.substring(0, 11),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.sport,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  singlestudent!.price,
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blue),
                                    onPressed: () async {
                                      print(singlestudent!.id);
                                      bool a = await FirebaseFirestoreHelper
                                          .instance
                                          .expireTicket(singlestudent!.id,singlestudent!.ticketid);

                                      if (a) {
                                        _controller.play();

                                        sendnotification(
                                            "Slot activated sucessfully",
                                            "enjoy");

                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("sucessful"),
                                              content: Text(
                                                  "Slot activated sucessfully"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    _controller.stop();

                                                    Routes.instance.push(
                                                        HomeScreen(), context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      if (a == false) {
                                        showCustomDialog(
                                            context: context,
                                            content: "ERROR",
                                            buttonText: "CLOSE",
                                            navigateFrom: HomeScreen(),
                                            title: "ALERT");
                                      }
                                    },
                                    child: const Text(
                                      'ACTIVATE',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          blastDirection: pi / 2,
          colors: [
            Color.fromARGB(255, 15, 66, 107),
            const Color.fromARGB(255, 134, 191, 220),
            Colors.white,
          ],
          emissionFrequency: 0.1,
          gravity: 0.1,
        )
      ],
    );
  }
}
