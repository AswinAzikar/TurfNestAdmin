import 'package:flutter/material.dart';
import 'package:turfnest_admin/HomeScreen.dart';

import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';

import 'package:turfnest_admin/models/turfhistorymodel.dart';

import 'package:turfnest_admin/routes.dart';

class TurfhistoryPage extends StatefulWidget {
  const TurfhistoryPage({super.key});

  @override
  State<TurfhistoryPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<TurfhistoryPage> {
  List<turfhistory_model> fullhistory = [];

  turfhistory_model? singlehistory;

  @override
  void initState() {
    super.initState();

    getsport();
  }

  getsport() async {
    fullhistory = await FirebaseFirestoreHelper.instance.getTurfHistory();
    setState(() {});
  }

  String convertTo12HourFormat(int hour) {
    String period = 'AM';
    if (hour >= 12) {
      period = 'PM';
    }
    if (hour > 12) {
      hour -= 12;
    }
    return '$hour $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blue),
          onPressed: () {
            Routes.instance.push(HomeScreen(), context);
          },
        ),
        title: Text(
          "History",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: List.generate(fullhistory.length, (index) {
              singlehistory = fullhistory[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  // border: Border.all(width: 2),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ticket Id: ${singlehistory!.ticketid}'),
                          Text('Email:${singlehistory!.email}'),
                          Text('Phone: ${singlehistory!.phone}'), // Time
                          Text(
                              '${convertTo12HourFormat(singlehistory!.time)} - ${convertTo12HourFormat(singlehistory!.time + 1)}'),
                          Text('Date: ${singlehistory!.date.substring(0, 11)}'),
                          Text('Sport: ${singlehistory!.sport}'),
                          Text(
                              'Activation time: ${singlehistory!.activationTime.substring(0, 19)}'),
                          // Username
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
