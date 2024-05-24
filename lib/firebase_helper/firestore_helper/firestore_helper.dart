import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FirebaseFirestoreHelper {
  static FirebaseFirestoreHelper instance = FirebaseFirestoreHelper();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<int>> getSlotsGreaterThanCurrentHour() async {
    int currentHour = DateTime.now().hour;
    print(currentHour);

    CollectionReference slotsCollection =
        FirebaseFirestore.instance.collection('slots');

    QuerySnapshot snapshot =
        await slotsCollection.where('slot', isGreaterThan: currentHour).get();

    List<int> slots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['slot'] != null) {
        slots.add(data['slot'] as int);
      }
    });

    return slots;
  }

Future<List<int>> getTicketsForCurrentDate() async {
  // Get the current date and format it
  final DateTime currentDate = DateTime.now();
  final String formattedDate = DateFormat('yyyy-MM-dd 00:00:00.000').format(currentDate);

  // Perform a collection group query for `bookedtickets` collections
  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collectionGroup('bookedtickets')
      .where('date', isEqualTo: formattedDate)
      .get();
  
  // Initialize a list to hold the ticket time slots
  List<int> ticketSlots = [];
  
  // Process the query results
  snapshot.docs.forEach((doc) {
    final data = doc.data() as Map<String, dynamic>?;
    if (data != null && data['time'] != null) {
      ticketSlots.add(data['time'] as int);
    }
  });
  
  // Return the list of ticket time slots
  return ticketSlots;
}

  Future<List<String>> getAllGames() async {
    List<String> names = [];

    try {
      CollectionReference institutions =
          FirebaseFirestore.instance.collection('games');

      QuerySnapshot querySnapshot = await institutions.get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        String name = data['game'];
        names.add(name);
      }
    } catch (e) {
      print("Error fetching names: $e");
    }

    return names;
  }

  bool compareDateWithCurrent(DateTime providedDateTime) {
    DateTime currentDate = DateTime.now();

    return providedDateTime.day == currentDate.day &&
        providedDateTime.month == currentDate.month &&
        providedDateTime.year == currentDate.year;
  }

  Future<List<int>> getAllSlots() async {
    int currentHour = DateTime.now().hour;
    print(currentHour);

    CollectionReference slotsCollection =
        FirebaseFirestore.instance.collection('slots');

    QuerySnapshot snapshot = await slotsCollection.get();

    List<int> slots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['slot'] != null) {
        slots.add(data['slot'] as int);
      }
    });

    return slots;
  }

  confirmslots() async {
   
      List<int> slot = await getTicketsForCurrentDate();
     
      return slot;
   
  }

  Future<String?> getPhoneById() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    CollectionReference collection =
        FirebaseFirestore.instance.collection('users');

    QuerySnapshot snapshot =
        await collection.where('id', isEqualTo: userid).get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          snapshot.docs.first.data() as Map<String, dynamic>;

      return data['phonenumber']?.toString();
    } else {
      return null;
    }
  }

  Future<void> feedback(String content, String phone, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    _firebaseFirestore.collection("feedback").add({
      "id": userid,
      "content": content,
      "phone": phone,
      "email": email,
    });
  }

  Future<String?> getGameCost(String gameName) async {
    CollectionReference gamesCollection =
        FirebaseFirestore.instance.collection('games');

    QuerySnapshot snapshot =
        await gamesCollection.where('game', isEqualTo: gameName).get();

    if (snapshot.docs.isNotEmpty) {
      Map<String, dynamic> data =
          snapshot.docs.first.data() as Map<String, dynamic>;

      return data['price']?.toString();
    } else {
      return null;
    }
  }
}
