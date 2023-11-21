import 'package:flutter/material.dart';
import 'package:manu/routes/routes_name.dart';
import 'package:manu/views/add_cable.dart';
import 'package:manu/views/cable_view.dart';
import 'package:manu/views/contact_view.dart';
import 'package:manu/views/home_view.dart';
import 'package:manu/views/settings_view.dart';
import 'package:manu/views/setup_view.dart';
import 'package:manu/views/welcome_view.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {

      case RoutesName.contactView:
        return MaterialPageRoute(
            builder: (BuildContext context) => ContactView(),
            settings: settings
        );

      case RoutesName.settings:
        return PageTransition(
            child: SettingsView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

      case RoutesName.addCable:
        return PageTransition(
            child: AddCableView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

      case RoutesName.welcome:
        return PageTransition(
            child: WelcomeView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

      case RoutesName.cableView:
        return PageTransition(
            child: CableView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

      case RoutesName.homeView:
        return PageTransition(
            child: HomeView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

      case RoutesName.setupView:
        return PageTransition(
            child: SetupView(),
            type: PageTransitionType.bottomToTop,
            settings: settings
        );

    default:
      return MaterialPageRoute(builder: (_) {
        return const Scaffold(
          body: Center(
            child: Text("No route defined"),
          ),
        );
      });
    }
  }
}