import 'package:flutter/material.dart';
import 'package:turfnest_admin/Menu.dart';

import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/models/sportsmodel.dart';

class SportsPage extends StatefulWidget {
  const SportsPage({super.key});

  @override
  State<SportsPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SportsPage> {
  List<Spoert_model> fullsports = [];
  
  Spoert_model? singlesport;

  @override
  void initState() {
    super.initState();

    getsport();
  }

  getsport() async {
    fullsports = await FirebaseFirestoreHelper.instance.getsports();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GAMES",style: TextStyle(color: AppColors.blue,fontWeight: FontWeight.bold),),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child:
           
             
              Column(
               
                children: List.generate(fullsports.length, (index) {
                  singlesport = fullsports[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
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
                              Text('Game:${singlesport!.game}'),
                              Text('Price: ${singlesport!.price}'), // Time
                              // Username
                            ],
                          ),
                        ),
                        SizedBox(width: 3),
                            
                        ElevatedButton(onPressed: ()async{
                            
                          var a = await FirebaseFirestoreHelper.instance
                                .deleteGame(singlesport!.game);
                            if (a) {
                              showCustomDialog(
                                  context: context,
                                  content: "deleted sucessfully",
                                  buttonText: "ok",
                                  navigateFrom: Menu(),
                                  title: "alert");
                            } else {
                              print("ppnn");
                            }
                        }, child: Text("delete",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.red)),),
                       
                        // Show scanner button for active items
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            // Handle scanner button tap
                          },
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
