import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

showSnackBar(BuildContext context, String message, {bool progress = false}) {
  var snackBar;
  if (progress) {
    snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(message),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      ),
      duration: Duration(seconds: 20),
    );
  } else {
    snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 1),
    );
  }
  Scaffold.of(context).showSnackBar(snackBar);
}

removeSnackBar(BuildContext context) {
  Scaffold.of(context).removeCurrentSnackBar();
}

Widget noInternet() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Colors.white,
    child: Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: Image.asset(
            "assets/images/nointernet.jpg",
            fit: BoxFit.fitWidth,
          ),
        ),
        Align(
          alignment: FractionalOffset(0.0, 0.25),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Couldn't connect to internet. \n Please Check your network setting.",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      "RETRY",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

showDialogBox(String message, BuildContext context, {bool isCancelable}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => isCancelable,
          child: AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularProgressIndicator(),
                Text("$message"),
              ],
            ),
          ),
        );
      });
}

removeDialogBox(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop('dialog');
}

getLoadingUi() {
  return Container(
    color: Color(0xffF1F5F8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: Image.asset('assets/images/loadingdata.jpg'),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Getting Your Stuff . . .",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0, right: 38.0),
          child: LinearProgressIndicator(
            backgroundColor: Colors.grey,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: Text(
            "If waiting makes you Anxious , Stand Up . Go grab some snacks and chill .",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
