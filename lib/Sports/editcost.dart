import 'package:flutter/material.dart';
import 'package:turfnest_admin/Menu.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';

class EditCost extends StatefulWidget {
  final String game;
   const EditCost({
    super.key,
    required this.game,
  });
  @override
  _AddGameState createState() => _AddGameState();
}

class _AddGameState extends State<EditCost> {
  final _formKey = GlobalKey<FormState>();
  late String  price = '';
  bool _isLoading = false;

  void _addGame() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
     await FirebaseFirestoreHelper.instance.editcost(widget.game, price);
      showCustomDialog(
          context: context,
          content: "Sport added successfully",
          buttonText: "OK",
          navigateFrom: Menu(),
          title: "NOTE");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'EDIT AMOUNT',
                  style: TextStyle(
                    color: AppColors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                  initialValue: widget.game
                  ,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Sports Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                 
                ),
                SizedBox(height: screenHeight * 0.03),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSaved: (value) => price = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    price = value;
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.03),
                ElevatedButton(
                  onPressed: _addGame,
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text('Update'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.25,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
