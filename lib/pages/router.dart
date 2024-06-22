import 'package:sonata/pages/auth/login_page.dart';
import 'package:sonata/pages/auth/register_page.dart';
import 'package:sonata/pages/pieces/pieces_page/pieces_page.dart';
import 'package:sonata/pages/splash/splash_page.dart';
import 'package:sonata/pages/tags/tags_page/tags_page.dart';

const initialRoute = "/";

final appRoutes = {
  "/": (ctx) => const SplashPage(),
  "/login": (ctx) => const LoginPage(),
  "/register": (ctx) => const RegisterPage(),
  "/tags": (ctx) => const TagsPage(),
  "/pieces": (ctx) => const PiecesPage(),
};
