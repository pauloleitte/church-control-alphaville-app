import 'package:flutter/material.dart';

Widget buildTitle({required String title, required BuildContext context}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 32,
              fontFamily: 'Lato',
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
