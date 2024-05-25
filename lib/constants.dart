import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppColors {
  static const Color blue = Color.fromARGB(255, 87, 150, 232);
  static const Color white = Colors.white;
<<<<<<< HEAD
  static const Color black = Colors.black;
  static const Color red = Color.fromARGB(255, 223, 65, 86);
=======
  static const Color black = Color.fromARGB(255, 214, 68, 68);
  static const Color red = Color.fromARGB(255, 236, 72, 93);
  static const Color darkblue = Color.fromARGB(255, 28, 116, 232);
  static const Color darkred = Color.fromARGB(255, 193, 0, 0);

  static const Gradient blueGradient = LinearGradient(
    colors: [
      AppColors.darkblue,
      AppColors.blue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient redGradient = LinearGradient(
    colors: [
      AppColors.darkred,
      AppColors.red,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
  static const Color green = Color.fromARGB(255, 67, 222, 72);
  static const Color grey = Colors.grey;
  static const Color white2 = Color.fromARGB(236, 35, 133, 214);
  static const Color gradientStartColor = Color.fromARGB(255, 231, 233, 241);
  static const Color gradientEndColor = AppColors.white;
<<<<<<< HEAD
  static const Color scbgd = Color.fromARGB(255, 229, 248, 249);
=======
  static const Color scbgd = Color.fromARGB(255, 236, 239, 233);
>>>>>>> 3a8db8fe0cb95fd1eb809e16487f9e61737faf2e
}

class ButtonStyles {
  static ButtonStyle styleFromWhiteRed() {
    return ElevatedButton.styleFrom(
      foregroundColor: AppColors.red,
      backgroundColor: AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static ButtonStyle mainButton({required String buttonText}) {
    return ElevatedButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ).copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 16),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(120, 48),
      ),
      elevation: MaterialStateProperty.all<double>(4),
      shadowColor: MaterialStateProperty.all<Color>(AppColors.grey),
    );
  }

  static ButtonStyle lsButton({required String buttonText}) {
    return ElevatedButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: const Color.fromARGB(255, 30, 90, 139),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ).copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 16),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(120, 48),
      ),
      elevation: MaterialStateProperty.all<double>(4),
      shadowColor: MaterialStateProperty.all<Color>(AppColors.grey),
    );
  }

  static ButtonStyle mainButtonGreen({required String buttonText}) {
    return ElevatedButton.styleFrom(
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ).copyWith(
      textStyle: MaterialStateProperty.all<TextStyle>(
        const TextStyle(fontSize: 16),
      ),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
      minimumSize: MaterialStateProperty.all<Size>(
        const Size(120, 48),
      ),
      elevation: MaterialStateProperty.all<double>(4),
      shadowColor: MaterialStateProperty.all<Color>(AppColors.grey),
    );
  }
}

class TextStyles {
  static const TextStyle normalText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.black,
  );

  static const TextStyle boldText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static const TextStyle bigBoldText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
}

void showmessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      backgroundColor: Color.fromARGB(255, 15, 66, 107),
      textColor: Colors.white,
      fontSize: 16.0);
}

ShowLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          height: 100,
          child: Column(
            children: [
              CircularProgressIndicator(
                color: Color.fromARGB(255, 15, 66, 107),
              ),
              SizedBox(
                height: 18,
              ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text("loading"),
              )
            ],
          ),
        );
      },
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return alert;
    },
  );
}

void showCustomDialog(
    {required BuildContext context,
    required String content,
    required String buttonText,
    required Widget navigateFrom,
    required String title}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Color.fromARGB(255, 15, 66, 107)),
        ),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => navigateFrom),
              );
            },
            child: Text(
              buttonText,
              style: TextStyle(color: Color.fromARGB(255, 15, 66, 107)),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> delayedFlow() async {
  print('Before delay');
  await Future.delayed(Duration(seconds: 3));
  print('After delay');
}
