import 'package:flutter/material.dart';

class NoDataCard extends StatelessWidget {
  final String message;

  const NoDataCard({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Center(
            child:  Text(message, style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(.2)
            ), textAlign: TextAlign.center),
          )
      ),
    );
  }
}