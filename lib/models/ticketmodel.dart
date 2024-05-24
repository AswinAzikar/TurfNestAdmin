
import 'dart:convert';

ticket_Model welcomeFromJson(String str) => ticket_Model.fromJson(json.decode(str));



class ticket_Model {
  String date;
    String id;
    String price;
    String sport;
    String status;
    int ticketid;
    int time;
    String phone;
    String email;
    String bookingtime;
  

  ticket_Model({
    required this.date,
    required this.id,
    required this.price,
    required this.sport,
    required this.status,
    required this.ticketid,
    required this.time,
    required this.phone,
    required this.email,
    required this.bookingtime,
  });

  factory ticket_Model.fromJson(Map<String, dynamic> json) => ticket_Model(
        date: json["date"],
        id: json["id"],
        price: json["price"],
        sport: json["sport"],
        status: json["status"],
        ticketid: json["ticketid"],
        time: json["time"],
        phone: json["phone"],
        email: json["email"],
        bookingtime: json["bookingtime"],
      );

  
}

















class Welcome {
    String date;
    String id;
    String price;
    String sport;
    String status;
    int ticketid;
    int time;

    Welcome({
        required this.date,
        required this.id,
        required this.price,
        required this.sport,
        required this.status,
        required this.ticketid,
        required this.time,
    });

    Welcome copyWith({
        String? date,
        String? id,
        String? price,
        String? sport,
        String? status,
        int? ticketid,
        int? time,
    }) => 
        Welcome(
            date: date ?? this.date,
            id: id ?? this.id,
            price: price ?? this.price,
            sport: sport ?? this.sport,
            status: status ?? this.status,
            ticketid: ticketid ?? this.ticketid,
            time: time ?? this.time,
        );
}