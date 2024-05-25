import 'package:flutter/material.dart';
import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/Menu.dart';

import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/feedback_model.dart';
import 'package:turfnest_admin/models/sportsmodel.dart';
import 'package:turfnest_admin/routes.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<FeedbackPage> {
  List<feedback_model> fullfeedback = [];

  feedback_model? singlefeedback;

  @override
  void initState() {
    super.initState();

    getsport();
  }

  getsport() async {
    fullfeedback = await FirebaseFirestoreHelper.instance.getfeedback();
    setState(() {});
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
          "FEEDBACKS",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: List.generate(fullfeedback.length, (index) {
              singlefeedback = fullfeedback[index];
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(13),
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('email:${singlefeedback!.email}'),
                          Text('Phone: ${singlefeedback!.phone}'), // Time
                          Text('content: ${singlefeedback!.content}'),
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
