import 'package:church_control/src/core/config/app_messages.dart';

class AppEnum {
  static Map<int, String> statusCodeMap = {
    401: AppMessages.ERROR_MESSAGE_AUTH,
    400: AppMessages.ERROR_HTTP_MESSAGE,
    500: AppMessages.ERROR_HTTP_MESSAGE,
    501: AppMessages.ERROR_HTTP_MESSAGE,
    503: AppMessages.ERROR_HTTP_MESSAGE
  };
}
