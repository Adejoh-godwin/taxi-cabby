import 'package:flutter/material.dart';

class DialogBuilderMode {
  DialogBuilderMode(this.context);
  Color newMorph = Colors.black87;
  // Color newMorph = Color(0xff3e4095);

  Color newMorphTwo = const Color(0xffffcc28);
  final BuildContext context;
  Future<void> hideOpenDialog() async {
    Navigator.of(context).pop();
  }

  void showErrorDialog([String? text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              backgroundColor: Colors.red,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 8),
                      child: Text(
                        text ?? 'Something went wrong',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ));
      },
    );
  }

  void showLoadingIndicator([String? text]) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 15)).then((_) {
          Navigator.pop(context);
        });
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0))),
              backgroundColor: newMorph,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: newMorphTwo,
                    color: const Color(0xff3e4095),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4, top: 8),
                      child: Text(
                        text ?? 'loading',
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      )),
                ],
              ),
            ));
      },
    );
  }
}
