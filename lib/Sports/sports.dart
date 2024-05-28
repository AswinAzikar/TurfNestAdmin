import 'package:flutter/material.dart';
import 'package:turfnest_admin/Menu.dart';
import 'addgame.dart';
import 'package:turfnest_admin/constants.dart';
import 'editcost.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/sportsmodel.dart';
import 'package:turfnest_admin/routes.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SportsPage> {
  List<Spoert_model> fullsports = [];

  @override
  void initState() {
    super.initState();
    getsport();
  }

  getsport() async {
    fullsports = await FirebaseFirestoreHelper.instance.getsports();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        backgroundColor: AppColors.scbgd,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.blue),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Sports",
          style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        onPressed: () {
          Routes.instance.push(AddGame(), context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView.builder(
            itemCount: fullsports.length,
            itemBuilder: (context, index) {
              Spoert_model singlesport = fullsports[index];
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
                          Text('Game: ${singlesport.game}'),
                          Text('Price: ${singlesport.price}'),
                        ],
                      ),
                    ),
                    SizedBox(width: 3),
                    IconButton(
                      onPressed: () async {
                        var success = await FirebaseFirestoreHelper.instance
                            .deleteGame(singlesport.game);
                        if (success) {
                          showCustomDialog(
                            context: context,
                            content: "Deleted successfully",
                            buttonText: "OK",
                            navigateFrom: Menu(),
                            title: "Alert",
                          );
                          getsport(); // Refresh the list after deletion
                        } else {
                          print("Deletion failed");
                        }
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Routes.instance
                            .push(EditCost(game: singlesport.game), context);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
