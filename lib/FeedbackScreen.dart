

import 'package:flutter/material.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/sportsmodel.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   List<Spoert_model> fullsports = [];
  double animatedContainerHeight = 0;
  bool isAnimatedWidgetVisible = false;

  Spoert_model? singlesport;
  
  @override
  void initState() {
    super.initState();
    
    getsport();
  }



  getsport() async {
   
    fullsports = await FirebaseFirestoreHelper.instance.getsports();

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Booked Tickets",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(height:5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    fullsports.length,
                                    (index) {


                                      singlesport = fullsports[index];
                                      return GestureDetector(
                                      onTap: () {
                                        // Handle tap for each item in the list
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom:10),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      'Time:${singlesport!.game}'), 
                                                       Text(
                                                      'Ticket: ${singlesport!.price}'), // Time
                                                 // Username
                                                 
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color:
                                                     Colors
                                                        .red, // Active or Expired
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                               "delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                           // Show scanner button for active items
                                              IconButton(
                                                icon: Icon(Icons
                                                    .edit),
                                                onPressed: () {
                                                  
                                                  // Handle scanner button tap
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),);
  }
}
