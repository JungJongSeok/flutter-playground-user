import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class TextAction {
  final String text;
  final VoidCallback action;

  TextAction({
    required this.text,
    required this.action,
  });

  Widget widget({double? width}) {
    return Container(
      width: width,
      color: Colors.black,
      child: Card(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        color: Colors.black,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: InkWell(
          onTap: action,
          child: Container(
            alignment: Alignment.center,
            margin:
                const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageTextAction extends TextAction {
  final SvgPicture image;

  ImageTextAction({
    required this.image,
    required super.text,
    required super.action,
  });

  @override
  Widget widget({double? width = null}) {
    return Container(
      width: width,
      color: Colors.black,
      child: Card(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        color: Colors.black,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.all(Radius.circular(6.0))),
        child: InkWell(
          onTap: action,
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 12, right: 10),
                  child: image,
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Text(
                      text,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
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

class CustomWidget {
  static Future<void> showAlertDialog(BuildContext context, String title,
      String description, List<TextAction> actions,
      {bool barrierDismissible = true}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title.isNotEmpty
              ? Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
          content: description.isNotEmpty
              ? Flexible(
                  child: Text(
                    description,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : null,
          actions: List.of(actions.map((data) => data.widget(width: 100))),
        );
      },
    );
  }

  static Future<void> showSimpleDialog(
      BuildContext context, String title, List<TextAction> actions,
      {bool barrierDismissible = true}) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: title.isNotEmpty
              ? Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                )
              : null,
          children: List.of(actions.map((data) => data.widget(width: 100))),
        );
      },
    );
  }

  static Future<void> showLoadingDialog(BuildContext context,
      {bool barrierDismissible = false}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return const LoadingLottieWidget();
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static Future<void> showBottomSheet(
      BuildContext context, List<TextAction> actions) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.of([
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    color: Colors.black,
                    child: Container(
                      width: 60,
                      height: 1,
                      color: Color(0xFFFAFAFAF),
                      margin: EdgeInsets.only(top: 12, bottom: 12),
                    ),
                  )
                ]) +
                List.of(actions.map((data) =>
                    Container(child: data.widget(width: double.infinity)))),
          ),
        );
      },
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

class LoadingLottieWidget extends StatelessWidget {
  const LoadingLottieWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Lottie.asset(
        'assets/lottie_loading.json',
        width: 60,
        repeat: true,
      ),
    );
  }
}
