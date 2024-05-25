
import 'dart:convert';

feedback_model welcomeFromJson(String str) => feedback_model.fromJson(json.decode(str));



class feedback_model {
  String content;
    String email;
    String id;
    String phone;
  
  

  feedback_model({
    required this.content,
    required this.id,
   
    required this.phone,
    required this.email,
   
  });

  factory feedback_model.fromJson(Map<String, dynamic> json) => feedback_model(
        content: json["content"],
        email: json["email"],
        id: json["id"],
        phone: json["phone"],
        
      );

  
}












