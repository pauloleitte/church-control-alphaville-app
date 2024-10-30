// ignore_for_file: unnecessary_const, constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppConstants {
  static const PUBLIC_KEY =
      "BHKYsfo2L1vpJPhVnlR8INiN3T2MfE3dey5uPMda0xazcBqLycS8n1RU3msqyciC9rQ-83nsylS3u6bZuAdgkY0";
  static const PATH_USER = "users";
  static const API_URL = kReleaseMode
      ? "https://church-control-api-5snxldjlxq-uc.a.run.app/api/v1"
      : "https://church-control-api-5snxldjlxq-uc.a.run.app/api/v1";
  static const PRIMARY_COLOR = "#000000";
  static const GENRE_LIST = ["Masculino", "Feminino"];
  static const ADMIN_ROLE = "admin";
  static const SUPER_ROLE = "super";
  static const EBD_ADMIN_ROLE = "ebd-admin";
  static const EBD_SECRETARY_ROLE = "secretary";
  static const EBD_TEACHER_ROLE = "teacher";
  static const ROLES = [ADMIN_ROLE, EBD_ADMIN_ROLE, EBD_SECRETARY_ROLE, EBD_TEACHER_ROLE];
  static const JOB_LIST = [
    "Cooperador",
    "Diácono",
    "Evangelista",
    "Presbítero",
    "Pastor",
    "Regente",
    "Músico",
    "Secretária",
    "Tesoureiro"
  ];
  static const SCAFFOLD_BACKGROUND_COLOR = "#F1F2F0";
  static const SECONDARY_COLOR = "#FFFFFF";
  static const MaterialColor PRIMARY_COLOR_SWATCH = const MaterialColor(
    0xFF000000,
    const <int, Color>{
      50: const Color(0xFF000000),
      100: Color(0xFF000000),
      200: const Color(0xFF000000),
      300: const Color(0xFF000000),
      400: const Color(0xFF000000),
      500: const Color(0xFF000000),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );

  static const TOKEN_KEY = "current_token";
  static const USER_KEY = "current_user";
}
