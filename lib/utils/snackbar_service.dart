import '../general_exports.dart';

class SnackbarService {
  static void showSnackbar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
    SnackStyle style = SnackStyle.FLOATING,
    Color? backgroundColor,
    TextStyle? textStyle,
    IconData? icon,
    String? title,
    double borderRadius = 10.0,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      duration: duration,
      snackPosition: position,
      backgroundColor: backgroundColor ?? Color(AppColors.gray),
      colorText: textStyle?.color,
      icon: icon != null ? Icon(icon, color: textStyle?.color) : null,
      borderRadius: borderRadius,
      snackStyle: style,
      margin: EdgeInsets.all(16),
    );
  }
}
