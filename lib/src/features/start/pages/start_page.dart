import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/auth/services/interfaces/user_service_interface.dart';
import '../../../core/config/app_constants.dart';
import '../../../core/config/app_routes.dart';
import '../store/start_store.dart';

class StartPage extends StatefulWidget {
  final String title;
  const StartPage({Key? key, this.title = 'StartPage'}) : super(key: key);
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
  final StartStore store = Modular.get();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  void _showNotification(String title, String message) {
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 5),
      icon: const Icon(
        Icons.notifications_outlined,
        color: Colors.white,
      ),
    ).show(context);
  }

  void _handleMessage(RemoteMessage rm) {
    final message = rm.notification!.body;
    final title = rm.notification!.title;
    _showNotification(title!, message!);
  }

  @override
  void initState() {
    _getUser();
    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen(_handleMessage);
    super.initState();
  }

  final List<BottomNavigationBarItem> ebdItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'EBD',
      icon: Icon(Icons.book_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Configuração',
      icon: Icon(Icons.settings),
    ),
  ];

  final List<BottomNavigationBarItem> managementItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Gerenciamento',
      icon: Icon(Icons.app_registration),
    ),
    const BottomNavigationBarItem(
      label: 'Configuração',
      icon: Icon(Icons.settings),
    ),
  ];

  final List<BottomNavigationBarItem> ebdAndManagementItems = [
    const BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Gerenciamento',
      icon: Icon(Icons.app_registration),
    ),
    const BottomNavigationBarItem(
      label: 'EBD',
      icon: Icon(Icons.book_outlined),
    ),
    const BottomNavigationBarItem(
      label: 'Configuração',
      icon: Icon(Icons.settings),
    ),
  ];

  bool isEbdUser = false;
  bool isSuperUser = false;

  Future _getUser() async {
    var userService = Modular.get<IUserService>();
    final result = await userService.getUser();
    result.fold((l) {}, (user) async {
      setState(() {
        isEbdUser = user.roles!.contains(AppConstants.EBD_SECRETARY_ROLE) ||
            user.roles!.contains(AppConstants.EBD_TEACHER_ROLE) ||
            user.roles!.contains(AppConstants.EBD_ADMIN_ROLE);

        isSuperUser = user.roles!.contains(AppConstants.SUPER_ROLE);
      });
      return;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      store.currentIndex = index;
    });
    if (isEbdUser) {
      switch (index) {
        case 0:
          Modular.to.navigate(AppRoutes.HOME);
          break;
        case 1:
          Modular.to.navigate(AppRoutes.EBD);
          break;
        case 2:
          Modular.to.navigate(AppRoutes.CONFIG);
          break;
        default:
          Modular.to.navigate(AppRoutes.HOME);
      }
      return;
    }

    if (isSuperUser) {
      switch (index) {
        case 0:
          Modular.to.navigate(AppRoutes.HOME);
          break;
        case 1:
          Modular.to.navigate(AppRoutes.MANAGEMENT);
          break;
        case 2:
          Modular.to.navigate(AppRoutes.EBD);
          break;
        case 3:
          Modular.to.navigate(AppRoutes.CONFIG);
          break;
        default:
          Modular.to.navigate(AppRoutes.HOME);
      }
      return;
    } else {
      switch (index) {
        case 0:
          Modular.to.navigate(AppRoutes.HOME);
          break;
        case 1:
          Modular.to.navigate(AppRoutes.MANAGEMENT);
          break;
        case 2:
          Modular.to.navigate(AppRoutes.CONFIG);
          break;
        default:
          Modular.to.navigate(AppRoutes.HOME);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RouterOutlet(),
      bottomNavigationBar: Observer(
        builder: (context) {
          return BottomNavigationBar(
            items: isSuperUser
                ? ebdAndManagementItems
                : isEbdUser
                    ? ebdItems
                    : managementItems,
            currentIndex: store.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Colors.white.withOpacity(.60),
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Lato',
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Lato',
            ),
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}
