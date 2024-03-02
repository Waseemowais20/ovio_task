import 'package:ovio_task/general_exports.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case routeSplash:
        return GetPageRoute(
          page: () => const Splash(),
        );
      case routeHome:
        return GetPageRoute(
          page: () => const Home(),
        );
      default:
        return null;
    }
  }
}
