import 'package:flutter/material.dart';
import 'package:social_media_app/app/splash.dart';
import 'package:social_media_app/screens/chat_screen.dart';
import 'package:social_media_app/screens/dashboard.dart';
import 'package:social_media_app/screens/login.dart';
import 'package:social_media_app/screens/messages_screen.dart';
import 'package:social_media_app/screens/profile_screen.dart';
import 'package:social_media_app/screens/sing_up.dart';
import 'package:social_media_app/widgets/bottom_navigation_bar.dart';

class AppRouter {
  static const String splash = "/";
  static const String login = "/login";
  static const String signUp = "/sign_up";
  static const String dashboard = "/dashboard";
  static const String chat = "/chat";
  static const String profilePic = "/profile_screen";

  static const String messagesScreen = "/messages_screen";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: ((context) => const Splash()),
        );
      case login:
        return MaterialPageRoute(
          builder: ((context) => const Login()),
        );
      case signUp:
        return MaterialPageRoute(
          builder: ((context) => const SignUp()),
        );
      case dashboard:
        return MaterialPageRoute(
          builder: ((context) => const Dashboard()),
        );
      case chat:
        return MaterialPageRoute(
          builder: ((context) => const Chat()),
        );
      case messagesScreen:
        return MaterialPageRoute(
          builder: ((context) => Messages()),
        );
      case profilePic:
        return MaterialPageRoute(
          builder: ((context) => const ProfileScreen()),
        );
    }
    return null;
  }
}
