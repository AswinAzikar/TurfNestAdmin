import 'dart:convert';

turfhistory_model welcomeFromJson(String str) =>
    turfhistory_model.fromJson(json.decode(str));

class turfhistory_model {
  String id;
  int ticketid;
  String email;
  String sport;
  String phone;
  String price;
  String activationTime;
  String date;
  int time;

  turfhistory_model(
      {required this.id,
      required this.price,
      required this.sport,
      required this.ticketid,
      required this.phone,
      required this.email,
      required this.activationTime,
      required this.date,
      required this.time});

  factory turfhistory_model.fromJson(Map<String, dynamic> json) => turfhistory_model(
        id: json["id"],
        price: json["price"],
        sport: json["sport"],
        ticketid: json["ticketid"],
        phone: json["phone"],
        email: json["email"],
        date: json["date"],
        time: json["time"],
        activationTime: json["activationTime"],
      );
}
