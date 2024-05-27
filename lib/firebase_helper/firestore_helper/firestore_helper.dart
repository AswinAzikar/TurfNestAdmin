import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:intl/intl.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/models/feedback_model.dart';
import 'package:turfnest_admin/models/sportsmodel.dart';
import 'package:turfnest_admin/models/ticketmodel.dart';
import 'package:turfnest_admin/models/turfhistorymodel.dart';

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
    final String formattedDate =
        DateFormat('yyyy-MM-dd 00:00:00.000').format(currentDate);

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
    List<int> slot = await getSlotsGreaterThanCurrentHour();
    List<int> slot2 = await getTicketsForCurrentDate();

    slot.removeWhere((element) => slot2.contains(element));
    slot.sort();

    slot.removeWhere((element) => slot2.contains(element));
    slot.sort();
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

  Future<List<ticket_Model>> getticket() async {
    final DateTime currentDate = DateTime.now();
    final String formattedDate =
        DateFormat('yyyy-MM-dd 00:00:00.000').format(currentDate);

    try {
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore
              .collectionGroup("bookedtickets")
              .where('date', isEqualTo: formattedDate)
              .get();

      List<ticket_Model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => ticket_Model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<List<ticket_Model>> getqrdetails(int id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore
              .collectionGroup("bookedtickets")
              .where('ticketid', isEqualTo: id)
              .get();

      List<ticket_Model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => ticket_Model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<bool> expireTicket(String id, int ticketnumber) async {
    // Reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Query the collection 'bookedtickets' where 'ticketnumber' matches the provided ticketNumber
      QuerySnapshot querySnapshot = await firestore
          .collection("users")
          .doc(id)
          .collection('bookedtickets')
          .where('ticketid', isEqualTo: ticketnumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming ticket numbers are unique, we take the first matched document
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Get the document ID
        String docId = documentSnapshot.id;

        // Update the 'status' field to 'expired'
        await firestore
            .collection("users")
            .doc(id)
            .collection('bookedtickets')
            .doc(docId)
            .update({
          'status': 'expired',
        });

        print('Ticket status updated to expired.');
        return true;
      } else {
        print('No ticket found with the given ticket number.');
        return false;
      }
    } catch (e) {
      print('Failed to update ticket status: $e');
      return false;
    }
  }

  Future<List<Spoert_model>> getsports() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore.collection("games").get();

      List<Spoert_model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => Spoert_model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<bool> deleteGame(String game) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('games')
          .where('game', isEqualTo: game)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        String docId = documentSnapshot.id;

        await firestore.collection('games').doc(docId).delete();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to delete game: $e');
      return false;
    }
  }

  Future<List<feedback_model>> getfeedback() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore.collection("feedback").get();

      List<feedback_model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => feedback_model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<void> addgame(String game, String price) async {
    _firebaseFirestore.collection("games").add({
      "game": game,
      "price": price,
    });
  }

  Future<bool> editcost(String game, String price) async {
    // Reference to the Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Query the collection 'bookedtickets' where 'ticketnumber' matches the provided ticketNumber
      QuerySnapshot querySnapshot = await firestore
          .collection('games')
          .where('game', isEqualTo: game)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming ticket numbers are unique, we take the first matched document
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Get the document ID
        String docId = documentSnapshot.id;

        // Update the 'status' field to 'expired'
        await firestore.collection('games').doc(docId).update({
          'price': price,
        });

        print('Ticket status updated to expired.');
        return true;
      } else {
        print('No ticket found with the given ticket number.');
        return false;
      }
    } catch (e) {
      print('Failed to update ticket status: $e');
      return false;
    }
  }

  confirmSlotsForHoliday(DateTime date) async {
    bool a = compareDateWithCurrent(date);
    if (a) {
      List<int> slot = await getSlotsGreaterThanCurrentHour();
      List<int> slot2 = await getTicketsForDate(date);
      List<int> slot3 = await holidayDates(date);

      slot.removeWhere((element) => slot2.contains(element));
      slot.removeWhere((element) => slot3.contains(element));
      slot.sort();
      return slot;
    } else {
      List<int> slot = await getAllSlots();
      List<int> slot2 = await getTicketsForDate(date);
      List<int> slot3 = await holidayDates(date);
      slot.removeWhere((element) => slot2.contains(element));
      slot.removeWhere((element) => slot3.contains(element));
      slot.sort();
      return slot;
    }
  }

  Future<List<int>> getTicketsForDate(DateTime selectedDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userid = prefs.getString('userid');

    CollectionReference usersCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userid)
        .collection('bookedtickets');

    QuerySnapshot snapshot = await usersCollection
        .where('date', isEqualTo: selectedDate.toString())
        .get();

    List<int> ticketSlots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['time'] != null) {
        ticketSlots.add(data['time'] as int);
      }
    });

    return ticketSlots;
  }

  Future<List<int>> holidayDates(DateTime selectedDate) async {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('holidays');

    QuerySnapshot snapshot = await usersCollection
        .where('date', isEqualTo: selectedDate.toString())
        .get();

    List<int> ticketSlots = [];
    snapshot.docs.forEach((doc) {
      final data = doc.data() as Map<String, dynamic>?;
      if (data != null && data['time'] != null) {
        ticketSlots.add(data['time'] as int);
      }
    });

    return ticketSlots;
  }

  Future<void> addHoliday(String date, int time) async {
    _firebaseFirestore.collection("holidays").add({"date": date, "time": time});
  }

  addTurfHistory(String id, int ticketid, String email, String sport,
      String phone, String price, String date, int time) {
    final DateTime now = DateTime.now();
    final String formattedDateTime = now.toIso8601String();

    _firebaseFirestore.collection("turfhistory").add({
      "id": id,
      "ticketid": ticketid,
      "email": email,
      "sport": sport,
      "phone": phone,
      "price": price,
      "activationTime": formattedDateTime,
      "date": date,
      "time": time
    });
  }

  Future<List<turfhistory_model>> getTurfHistory() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querrysnapshot =
          await _firebaseFirestore.collection("turfhistory").get();

      List<turfhistory_model> boardingrequestdetails = querrysnapshot.docs
          .map((e) => turfhistory_model.fromJson(e.data()))
          .toList();
      return boardingrequestdetails;
    } catch (e) {
      showmessage(e.toString());
      print(e.toString());
      return [];
    }
  }

  Future<bool> isAdminCollectionEmpty() async {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('admin').get();
    return querySnapshot.docs.isEmpty;
  }
   

}
