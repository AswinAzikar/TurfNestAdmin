
import 'dart:convert';

Spoert_model welcomeFromJson(String str) => Spoert_model.fromJson(json.decode(str));



class Spoert_model {
  String game;
    String price;
    
  

  Spoert_model({
    required this.game,
    required this.price,
   
  });

  factory Spoert_model.fromJson(Map<String, dynamic> json) => Spoert_model(
        game: json["game"],
        price: json["price"],
       
      );

  
}











