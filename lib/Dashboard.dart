import 'package:flutter/material.dart';

import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/profile.dart';
import 'package:turfnest_admin/models/ticketmodel.dart';
import 'package:turfnest_admin/qr_comp/qrpage.dart';
import 'package:turfnest_admin/routes.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ticket_Model> tickethistory = [];
  double animatedContainerHeight = 0;
  bool isAnimatedWidgetVisible = false;

  ticket_Model? singlehistory;
  int rectangle1Count = 0;
  int rectangle2Count = 0;
  int flag = 1;

  static const double commonSpace = 16.0;

  bool isloading = true;
  List<int> slots = [];

  @override
  void initState() {
    super.initState();
    Slots();
    getcategorylist();
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

  Slots() async {
    setState(() {
      isloading = true;
    });
    slots = await FirebaseFirestoreHelper.instance.confirmslots();

    setState(() {
      isloading = false;
    });
  }

  void getcategorylist() async {
    setState(() {
      isloading = true;
    });
    tickethistory = await FirebaseFirestoreHelper.instance.getticket();

    setState(() {
      isloading = false;
    });
  }

  // Common space on both sides

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleHeight = screenHeight * 0.13;
    double rectangleWidth = screenWidth * 0.9;

    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = AppColors.redGradient.createShader(
                Rect.fromLTWH(0, 0, 200, 50),
              ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scbgd,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            iconSize: 32,
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
<<<<<<< HEAD
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: .005 * screenHeight),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: commonSpace),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          flag = 1;
                        });
                      },
                      child: Container(
                        width: rectangleWidth,
                        height: rectangleHeight,
                        decoration: BoxDecoration(
                          gradient: AppColors.blueGradient,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Today\'s booking: ${tickethistory.length}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01 * screenHeight),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        flag = 2;
                      });
                    },
                    child: Container(
                      width: rectangleWidth,
                      height: rectangleHeight,
                      decoration: BoxDecoration(
                        gradient: AppColors.redGradient,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Available Slots: ${slots.length}',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.01 * screenHeight),
                  flag == 1
                      ? Container(
                          width: rectangleWidth,
                          height: screenHeight * 0.55,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
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
                                SizedBox(height: 0.02 * screenHeight),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(tickethistory.length,
                                      (index) {
                                    singlehistory = tickethistory[index];
                                    return GestureDetector(
                                      onTap: () {
                                        // Handle tap for each item in the list
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 0.01 * screenHeight),
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
                                                      '${convertTo12HourFormat(singlehistory!.time)} - ${convertTo12HourFormat(singlehistory!.time + 1)}'),
                                                  Text(
                                                      'Ticket: ${singlehistory!.ticketid}'), // Time
                                                  // Username
                                                  Text(
                                                      'Mobile:${singlehistory!.phone}'),
                                                  Text(
                                                      'Email:${singlehistory!.email}',
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight: FontWeight
                                                              .bold)), // Mobile number

                                                  Text(
                                                    'Booking time: ${singlehistory!.bookingtime.substring(0, 11)}',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ), // Ticket number
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 0.03 * screenWidth),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: singlehistory!.status ==
                                                        "active"
                                                    ? Colors.green
                                                    : Colors
                                                        .red, // Active or Expired
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                singlehistory!.status,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            if (singlehistory!.status ==
                                                "active") // Show scanner button for active items
                                              IconButton(
                                                icon: Icon(Icons
                                                    .qr_code_scanner_outlined),
                                                onPressed: () {
                                                  Routes.instance.push(
                                                      ScanCodePage(), context);
                                                  // Handle scanner button tap
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                        )
                      : flag == 2
                          ? Container(
                              width: rectangleWidth,
                              height: screenHeight * 0.4,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColors.white,
=======
      body: isloading
          ? Center(
              child: Container(
                color: Colors.white,
                height: 150,
                width: 300,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 15, 66, 107),
                ),
                alignment: Alignment.center,
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: .005 * screenHeight),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: commonSpace),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                flag = 1;
                              });
                            },
                            child: Container(
                              width: rectangleWidth,
                              height: rectangleHeight,
                              decoration: BoxDecoration(
                                gradient: AppColors.blueGradient,
>>>>>>> cddf457 (hi)
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
<<<<<<< HEAD
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Available slots',
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 0.03 * screenHeight),
                                  Expanded(
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            4, // Number of columns in the grid
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio:
                                            1.5, // Aspect ratio of each grid item
                                      ),
                                      itemCount: slots
                                          .length, // Number of slots, adjust as needed
                                      itemBuilder: (context, index) {
                                        // Generate grid items with time labels
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Center(
                                            child: Text(
                                              slots[index]
                                                  .toString(), // Time label (example: 1 PM, 2 PM, ...)
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                ],
              ),
            ],
          ),
        ],
      ),
=======
                              child: Center(
                                child: Text(
                                  'Today\'s booking: ${tickethistory.length}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              flag = 2;
                            });
                          },
                          child: Container(
                            width: rectangleWidth,
                            height: rectangleHeight,
                            decoration: BoxDecoration(
                              gradient: AppColors.redGradient,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'Available Slots: ${slots.length}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 0.01 * screenHeight),
                        flag == 1
                            ? Container(
                                width: rectangleWidth,
                                height: screenHeight * 0.55,
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: SingleChildScrollView(
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
                                      SizedBox(height: 0.02 * screenHeight),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            tickethistory.length, (index) {
                                          singlehistory = tickethistory[index];
                                          return GestureDetector(
                                            onTap: () {
                                              // Handle tap for each item in the list
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 0.01 * screenHeight),
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${convertTo12HourFormat(singlehistory!.time)} - ${convertTo12HourFormat(singlehistory!.time + 1)}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                          'Ticket: ${singlehistory!.ticketid}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ), // Time
                                                        // Username
                                                        Text(
                                                          'Mobile:${singlehistory!.phone}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Text(
                                                            'Email:${singlehistory!.email}',
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)), // Mobile number

                                                        Text(
                                                          'Booking time: ${singlehistory!.bookingtime.substring(0, 11)}',
                                                          style: TextStyle(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ), // Ticket number
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width:
                                                          0.03 * screenWidth),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: singlehistory!
                                                                  .status ==
                                                              "active"
                                                          ? Colors.green
                                                          : Colors
                                                              .red, // Active or Expired
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      singlehistory!.status,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  if (singlehistory!.status ==
                                                      "active") // Show scanner button for active items
                                                    IconButton(
                                                      icon: Icon(Icons
                                                          .qr_code_scanner_outlined),
                                                      onPressed: () {
                                                        Routes.instance.push(
                                                            ScanCodePage(),
                                                            context);
                                                        // Handle scanner button tap
                                                      },
                                                    ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : flag == 2
                                ? Container(
                                    width: rectangleWidth,
                                    height: screenHeight * 0.4,
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Available slots',
                                          style: TextStyle(
                                            color: AppColors.red,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 0.03 * screenHeight),
                                        Expanded(
                                          child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  4, // Number of columns in the grid
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              childAspectRatio:
                                                  1.5, // Aspect ratio of each grid item
                                            ),
                                            itemCount: slots
                                                .length, // Number of slots, adjust as needed
                                            itemBuilder: (context, index) {
                                              // Generate grid items with time labels
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${convertTo12HourFormat(slots[index])} - ${convertTo12HourFormat(slots[index] + 1)}',
                                                    // Time label (example: 1 PM, 2 PM, ...)
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
>>>>>>> cddf457 (hi)
    );
  }
}
