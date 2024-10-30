import 'package:flutter/material.dart';

Widget subTitle({required String title, required BuildContext context}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 24,
              fontFamily: 'Lato',
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    ],
  );
}
