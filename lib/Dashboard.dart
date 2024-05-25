import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turfnest_admin/capsuleButton.dart';
import 'package:turfnest_admin/constants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int rectangle1Count = 0;
  int rectangle2Count = 0;
  int flag = 1;
  var Aswin = 0;

  static const double commonSpace = 16.0; // Common space on both sides

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
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                          color: Colors.blue,
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
                            'Today\'s booking: $a',
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
                        color: AppColors.red,
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
                          'Available Slots: $b',
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
                                    4,
                                    (index) => GestureDetector(
                                      onTap: () {
                                        // Handle tap for each item in the list
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 0.01 * screenHeight),
                                        padding: EdgeInsets.all(10),
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
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: index % 2 == 0
                                                    ? Colors.green
                                                    : Colors
                                                        .red, // Active or Expired
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                index % 2 == 0
                                                    ? 'Active'
                                                    : 'Expired',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            if (index % 2 ==
                                                0) // Show scanner button for active items
                                              IconButton(
                                                icon: Icon(Icons
                                                    .qr_code_scanner_outlined),
                                                onPressed: () {
                                                  // Handle scanner button tap
                                                },
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                      itemCount:
                                          9, // Number of slots, adjust as needed
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
                                              '${index + 1} PM', // Time label (example: 1 PM, 2 PM, ...)
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
