import 'package:flutter_no_internet_widget/flutter_no_internet_widget.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:ovio_task/general_exports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return InternetWidget(
      offline: const FullScreenWidget(
        child: NoInternetWidget(),
      ),
      loadingWidget: CircularProgressIndicator(
        color: Color(AppColors.white),
      ),
      online: GetMaterialApp(
        theme: ThemeData(
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(AppColors.primary),
          ),
          splashColor: Colors.transparent,
          bottomSheetTheme: const BottomSheetThemeData(
            elevation: 0.0,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(
              AppColors.blue2,
            ),
            selectionHandleColor: Color(
              AppColors.blue2,
            ),
          ),
          useMaterial3: false,
          primaryColor: const Color(AppColors.primary),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              backgroundColor: const Color(AppColors.blue2),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.017),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DEVICE_WIDTH * 0.02),
              ),
            ),
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodySmall: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            bodyMedium: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            bodyLarge: TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          sliderTheme: const SliderThemeData(
            activeTrackColor: Color(AppColors.blue2),
            inactiveTrackColor: Color(AppColors.gray3),
            thumbColor: Color(AppColors.gold2),
            overlayColor: Color(AppColors.gold2),
            trackHeight: 2.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.0),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 16.0),
            valueIndicatorColor: Color(AppColors.black),
          ),
        ),
        fallbackLocale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: <Widget>[
              FlutterSmartDialog(child: child),
            ],
          );
        },
      ),
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: DEVICE_HEIGHT * 0.2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
