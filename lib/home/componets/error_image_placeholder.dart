import 'package:flutter/material.dart';

class ErrorImagePlaceHolder extends StatelessWidget {
  const ErrorImagePlaceHolder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Center(
        child: Text(
          "Error with Provided Url",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}