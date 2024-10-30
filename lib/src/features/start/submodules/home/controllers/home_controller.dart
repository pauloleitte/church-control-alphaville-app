import 'package:church_control/src/core/config/app_constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/auth/models/user_model.dart';
import '../../../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../../../core/config/app_routes.dart';
import '../../../store/start_store.dart';
import '../../management/modules/ceremony/models/ceremony_model.dart';
import '../../management/modules/ceremony/services/interfaces/ceremony_service_interface.dart';
import '../../management/modules/member/models/member_model.dart';
import '../../management/modules/member/services/interfaces/member_service_interface.dart';
import '../../management/modules/notice/models/notice_model.dart';
import '../../management/modules/notice/services/interfaces/notice_service_interface.dart';

part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final ICeremonyService _ceremonyService;
  final IUserService _userService;
  final IMemberService _memberService;
  final INoticeService _noticeService;
  final StartStore store;

  @observable
  UserModel model = UserModel();

  _HomeControllerBase(this._ceremonyService, this._userService,
      this._memberService, this._noticeService, this.store);

  @observable
  List<CeremonyModel> ceremonies = [];

  @observable
  List<MemberModel> members = [];

  @observable
  List<NoticeModel> notices = [];

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @observable
  bool busy = false;

  getWeeksAgenda() async {
    try {
      busy = true;
      var result = await _noticeService.getWeeksAgenda();
      result.fold((l) {
        Modular.to.navigate(AppRoutes.AUTH);
      }, (response) async {
        notices = response.notices!;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  getBirthdayOfMonth() async {
    try {
      busy = true;
      var result = await _memberService.getBirthdayOfMonth();
      result.fold((l) {
        Modular.to.navigate(AppRoutes.AUTH);
      }, (response) async {
        members = response.members!;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  getCeremoniesOfDay(DateTime date) async {
    try {
      busy = true;
      var result = await _ceremonyService.getCeremoniesOfDay(date);
      result.fold((l) {
        Modular.to.navigate(AppRoutes.AUTH);
      }, (ceremonies) async {
        this.ceremonies = ceremonies;
      });
    } catch (e) {
      busy = false;
    } finally {
      busy = false;
    }
  }

  getUser() async {
    try {
      busy = true;
      final user = await _userService.getCurrentUser();
      if (user.email != null) {
        model = user;
        return;
      } else {
        final result = await _userService.getUser();
        result.fold((l) {
          Modular.to.navigate(AppRoutes.AUTH);
        }, (user) async {
          model = user;
          await _userService.saveUserLocal(model);
          await _userService.saveUserEmailLocal(model.email!);
          final deviceToken =
              await messaging.getToken(vapidKey: AppConstants.PUBLIC_KEY);
          if (!model.tokens!.contains(deviceToken)) {
            model.tokens!.add(deviceToken!);
            await _userService.updateTokensUser(model);
          }
          return;
        });
      }
    } catch (e) {
      Modular.to.navigate(AppRoutes.AUTH);
    } finally {
      busy = false;
    }
  }
}
