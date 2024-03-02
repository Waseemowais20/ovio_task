import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../general_exports.dart';

void startLoading() {
  SmartDialog.showLoading(
    builder: (BuildContext context) => const CircularProgressIndicator(
      color: Color(AppColors.white),
    ),
    clickMaskDismiss: true,
  );
}

void dismissLoading() {
  SmartDialog.dismiss();
}
