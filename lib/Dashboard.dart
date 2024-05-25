import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/widgets.dart';
import 'package:turfnest_admin/capsuleButton.dart';
import 'package:turfnest_admin/constants.dart';
=======


import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/ticketmodel.dart';
import 'package:turfnest_admin/qr_comp/qrpage.dart';
import 'package:turfnest_admin/routes.dart';
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
<<<<<<< HEAD
  int rectangle1Count = 0;
  int rectangle2Count = 0;
  int flag = 1;
  var Aswin = 0;

  static const double commonSpace = 16.0; // Common space on both sides
=======
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
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double rectangleHeight = screenHeight * 0.13;
    double rectangleWidth = screenWidth * 0.9;
    var a = 5;
    var b = 7;
    var page = 1;
    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        title: Text(
          "Dashboard",
<<<<<<< HEAD
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
=======
          style: TextStyle(
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..shader = AppColors.redGradient.createShader(
                Rect.fromLTWH(0, 0, 200, 50),
              ),
          ),
        ),
        automaticallyImplyLeading: false,
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
        backgroundColor: AppColors.scbgd,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            iconSize: 32,
            onPressed: () {
              // Handle user icon button press
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
<<<<<<< HEAD
        children: [
          Center(
            child: ToggleButtonWidget(
              onPressed: () {
                if (page == 1) {
                  Navigator.pushNamed(context, '/menu');
                } else {
                  Navigator.pushNamed(context, '/dashboard');
                }
                setState(() {});
              },
            ),
          ),
=======
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                          color: Colors.blue,
=======
                          gradient: AppColors.blueGradient,
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                            'Today\'s booking: $a',
=======
                            'Today\'s booking: ${tickethistory.length}',
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                        color: AppColors.red,
=======
                        gradient: AppColors.redGradient,
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                          'Available Slots: $b',
=======
                          'Available Slots: ${slots.length}',
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
                                  children: List.generate(
<<<<<<< HEAD
                                    4,
                                    (index) => GestureDetector(
=======
                                    tickethistory.length,
                                    (index) {


                                      singlehistory = tickethistory[index];
                                      return GestureDetector(
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                      onTap: () {
                                        // Handle tap for each item in the list
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 0.01 * screenHeight),
<<<<<<< HEAD
                                        padding: EdgeInsets.all(10),
=======
                                        padding: EdgeInsets.all(8),
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                                                      'Time: 10:00 AM'), // Time
                                                  Text(
                                                      'Username: John Doe'), // Username
                                                  Text(
                                                      'Mobile: +1234567890'), // Mobile number
                                                  Text(
                                                      'Ticket: 123456'), // Ticket number
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 0.09 * screenWidth),
=======
                                                      'Time:${singlehistory!.time}'), 
                                                       Text(
                                                      'Ticket: ${singlehistory!.ticketid}'), // Time
                                                 // Username
                                                  Text(
                                                      'Mobile:${singlehistory!.phone}'), 
                                                       Text(
                                                      'Email:${singlehistory!.email}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)), // Mobile number
                                                 
                                                      Text(
                                                      'Booking time: ${singlehistory!.bookingtime.substring(0,11)}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),), // Ticket number
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 0.03 * screenWidth),
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
<<<<<<< HEAD
                                                color: index % 2 == 0
=======
                                                color: singlehistory!.status=="active"
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                                    ? Colors.green
                                                    : Colors
                                                        .red, // Active or Expired
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
<<<<<<< HEAD
                                                index % 2 == 0
                                                    ? 'Active'
                                                    : 'Expired',
=======
                                                singlehistory!.status,
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
<<<<<<< HEAD
                                            if (index % 2 ==
                                                0) // Show scanner button for active items
=======
                                            if (singlehistory!.status=="active") // Show scanner button for active items
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                              IconButton(
                                                icon: Icon(Icons
                                                    .qr_code_scanner_outlined),
                                                onPressed: () {
<<<<<<< HEAD
=======
                                                  Routes.instance.push(ScanCodePage(), context);
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                                  // Handle scanner button tap
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
<<<<<<< HEAD
                                    ),
=======
                                    );
                                    }
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
                                  ),
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
<<<<<<< HEAD
                                      itemCount:
                                          9, // Number of slots, adjust as needed
=======
                                      itemCount: slots
                                          .length, // Number of slots, adjust as needed
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
<<<<<<< HEAD
                                              '${index + 1} PM', // Time label (example: 1 PM, 2 PM, ...)
=======
                                              slots[index]
                                                  .toString(), // Time label (example: 1 PM, 2 PM, ...)
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
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
    );
  }
}
