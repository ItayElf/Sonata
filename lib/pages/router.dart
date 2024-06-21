import 'package:sonata/pages/auth/login_page.dart';
import 'package:sonata/pages/auth/register_page.dart';

const initialRoute = "/login";

final appRoutes = {
  "/login": (ctx) => const LoginPage(),
  "/register": (ctx) => const RegisterPage(),
};
