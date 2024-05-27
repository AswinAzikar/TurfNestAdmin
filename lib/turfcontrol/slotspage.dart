import 'package:flutter/material.dart';

import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';

import 'package:turfnest_admin/routes.dart';

class BookingScreen extends StatefulWidget {
  final DateTime date;

  const BookingScreen({Key? key, required this.date}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingState();
}

class _BookingState extends State<BookingScreen> {
  double animatedContainerHeight = 0;
  bool isAnimatedWidgetVisible = false;
  String price = "";
  List<int> slots = [];
  bool isloading = false;
  int SLOT = 0;
  DateTime? dates;

  @override
  void initState() {
    super.initState();
    Slots();
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
    slots = await FirebaseFirestoreHelper.instance
        .confirmSlotsForHoliday(widget.date);

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double overlapHeight = screenHeight * 0.3;
    double middleHeight = screenHeight * 0.4;
    dates = widget.date;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: isloading
          ? Center(
              child: Container(
                color: Colors.white,
                height: 150,
                width: 320,
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 15, 66, 107),
                ),
                alignment: Alignment.center,
              ),
            )
          : SafeArea(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    width: screenWidth,
                    height: 0.3 * screenHeight,
                    child: Container(
                      height: middleHeight,
                      color: AppColors.blue,
                    ),
                  ),
                  Positioned(
                    top: middleHeight - (overlapHeight),
                    left: 0.04 * screenWidth,
                    right: 0.04 * screenWidth,
                    child: Container(
                      height: 0.3 * screenHeight,
                      width: 0.7 * screenWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SELECT SLOT',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 30),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 1.5,
                                ),
                                itemCount: slots.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        animatedContainerHeight = 70.0;
                                        isAnimatedWidgetVisible = true;
                                        setState(() {
                                          SLOT = slots[index];
                                        });
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      shape: MaterialStateProperty.all<
                                          OutlinedBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: BorderSide(
                                              color: AppColors.green),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      '${convertTo12HourFormat(slots[index])} - ${convertTo12HourFormat(slots[index] + 1)}',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    bottom: isAnimatedWidgetVisible ? 0 : -150,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        height: 150,
                        color: AppColors.blue,

                        //add a table instead of this
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Align the column centrally
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Table(
                                  border: TableBorder.all(
                                      color: Colors
                                          .transparent), // Invisible border
                                  children: [
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Slot Time',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              convertTo12HourFormat(SLOT) +
                                                  " - " +
                                                  convertTo12HourFormat(
                                                      SLOT + 1),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign
                                                  .center, // Align center
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        TableCell(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                            ],
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              dates.toString().substring(0, 11),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign
                                                  .center, // Align center
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyles.mainButtonGreen(
                                          buttonText: "confirm",
                                        ),
                                        onPressed: () async {
                                          FirebaseFirestoreHelper.instance
                                              .addHoliday(
                                                  widget.date.toString(), SLOT);
                                          showCustomDialog(
                                              context: context,
                                              content: "Added Sucessfully",
                                              buttonText: "ok",
                                              navigateFrom: HomeScreen(),
                                              title: "note");

                                          setState(() {
                                            isAnimatedWidgetVisible = false;
                                            animatedContainerHeight = 0.0;
                                          });
                                        },
                                        child: Text(
                                          'Turn Off',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      ElevatedButton(
                                        style: ButtonStyles.mainButton(
                                          buttonText: "confirm",
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isAnimatedWidgetVisible = false;
                                            animatedContainerHeight = 0.0;
                                          });
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  )
                                ],
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
    );
  }
}
