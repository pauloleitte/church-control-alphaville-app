import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'app_constants.dart';

class ThemeHelper {
  Color primaryColor = HexColor(AppConstants.PRIMARY_COLOR);
  Color secondaryColor = HexColor(AppConstants.SECONDARY_COLOR);
  Color scaffoldBackgroundColor =
      HexColor(AppConstants.SCAFFOLD_BACKGROUND_COLOR);

  ThemeData themeData() {
    return ThemeData(
      textTheme: TextTheme(
          titleSmall: TextStyle(
              color: primaryColor,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              color: primaryColor,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
          titleMedium: TextStyle(
              color: primaryColor,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold),
          bodySmall: TextStyle(
              color: primaryColor,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600),
          labelLarge: TextStyle(
            color: primaryColor,
            fontFamily: 'Lato',
            fontWeight: FontWeight.w600,
          )),
      fontFamily: 'Lato',
      dialogBackgroundColor: secondaryColor,
      floatingActionButtonTheme: ThemeHelper().floatingActionButtonThemeData(),
      appBarTheme: ThemeHelper().appBarTheme(),
      snackBarTheme: ThemeHelper().snackBarThemeData(),
      iconTheme: ThemeHelper().iconThemeData(),
      buttonTheme: ThemeHelper().buttonThemeData(),
      primaryColor: primaryColor,
      canvasColor: scaffoldBackgroundColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      colorScheme: ThemeHelper().colorScheme(),
      checkboxTheme: ThemeHelper().checkboxThemeData(),
      cardTheme: ThemeHelper().cardTheme(),
      // dropdownMenuTheme: ThemeHelper().dropdownMenuTheme(),
    );
  }

  TextStyle hintTextStyle() {
    return TextStyle(
      backgroundColor: Colors.white,
      decorationColor: primaryColor,
      color: primaryColor,
      fontFamily: 'Lato',
      fontWeight: FontWeight.bold,
    );
  }

  InputDecoration dropDownMultiselectDecoration(String labelText) {
    return InputDecoration(
        label: Text(labelText),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        fillColor: Colors.white,
        isCollapsed: false,
        isDense: true,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ));
  }

  DropdownMenuThemeData dropdownMenuTheme() {
    return DropdownMenuThemeData(
      menuStyle: MenuStyle(
        surfaceTintColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        elevation: WidgetStateProperty.all(2),
      ),
      textStyle: TextStyle(
        color: primaryColor,
        fontFamily: 'Lato',
        fontWeight: FontWeight.bold,
      ),
    );
  }

  InputDecoration textInputDecoration(
      [String lableText = "", String hintText = "", Icon? icon]) {
    return InputDecoration(
      prefixIcon: icon,
      labelText: lableText,
      hintText: hintText,
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(fontFamily: 'Lato', color: primaryColor),
      contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
      errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0)),
    );
  }

  CheckboxThemeData checkboxThemeData() {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      fillColor: WidgetStateProperty.all(secondaryColor),
      checkColor: WidgetStateProperty.all(primaryColor),
    );
  }

  AppBarTheme appBarTheme() {
    return AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actionsIconTheme:
            IconThemeData(color: HexColor(AppConstants.PRIMARY_COLOR)),
        iconTheme: IconThemeData(color: HexColor(AppConstants.PRIMARY_COLOR)),
        centerTitle: true,
        surfaceTintColor: HexColor(AppConstants.PRIMARY_COLOR),
        titleTextStyle: TextStyle(
          fontFamily: 'Lato',
          fontWeight: FontWeight.w700,
          fontSize: 24,
          color: primaryColor,
        ));
  }

  BoxDecoration inputBoxDecorationShaddow() {
    return BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 20,
        offset: const Offset(0, 5),
      )
    ]);
  }

  BoxDecoration buttonBoxDecoration(
      {required BuildContext context, bool showBoxShadow = true}) {
    Color c1 = Theme.of(context).primaryColor;
    if (showBoxShadow) {
      return BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: c1.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(10, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      );
    } else {
      return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      );
    }
  }

  ButtonStyle buttonStyle(BuildContext context) {
    return ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size.fromRadius(10)),
      backgroundColor:
          WidgetStateProperty.all(Theme.of(context).primaryColor),
    );
  }

  TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.secondary);
  }

  FloatingActionButtonThemeData floatingActionButtonThemeData() {
    return FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: HexColor(AppConstants.SECONDARY_COLOR));
  }

  IconThemeData iconThemeData() {
    return IconThemeData(
      color: HexColor(AppConstants.PRIMARY_COLOR),
    );
  }

  SnackBarThemeData snackBarThemeData() {
    return SnackBarThemeData(
        elevation: 2,
        backgroundColor: HexColor(AppConstants.SECONDARY_COLOR),
        contentTextStyle:
            TextStyle(color: primaryColor, fontWeight: FontWeight.bold));
  }

  ButtonThemeData buttonThemeData() {
    return ButtonThemeData(
        disabledColor: Colors.grey.shade400,
        buttonColor: primaryColor,
        textTheme: ButtonTextTheme.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ));
  }

  ColorScheme colorScheme() {
    return ColorScheme.fromSwatch(
      primarySwatch: AppConstants.PRIMARY_COLOR_SWATCH,
      accentColor: HexColor(AppConstants.SECONDARY_COLOR),
      errorColor: Colors.red,
    );
  }

  AlertDialog alartDialog(String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      backgroundColor: secondaryColor,
      surfaceTintColor: secondaryColor,
      actions: [
        TextButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(secondaryColor)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "OK",
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
    );
  }

  CardTheme cardTheme() {
    return CardTheme(
      elevation: 2,
      surfaceTintColor: Colors.white,
      color: Colors.white,
      shadowColor: primaryColor,
    );
  }
}
