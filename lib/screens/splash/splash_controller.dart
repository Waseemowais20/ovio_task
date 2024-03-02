import 'package:video_cached_player/video_cached_player.dart';

import '../../general_exports.dart';

class SplashController extends GetxController {
  CachedVideoPlayerController? videoController;

  bool isVideoFinished = false;
  bool isDataLoaded = false;

  bool shouldUpdate = false;

  @override
  Future<void> onReady() async {
    super.onReady();
    videoController = CachedVideoPlayerController.asset(
      videoSplash,
    )..initialize().then(
        (_) {
          videoController?.play();
          update();
          videoController?.addListener(
            () {
              if (videoController?.value.position ==
                      videoController?.value.duration &&
                  !isVideoFinished) {
                isVideoFinished = true;
              }
            },
          );
        },
      );

    Future.delayed(const Duration(seconds: 5)).whenComplete(() {
      openSignInSheet();
    });
  }

  void openSignInSheet({Function()? action}) async {
    // String? token = await SecureStorageService().read(key: 'auth_token');
    // if (token != null) {
    //   Get.offAllNamed(routeHome);
    //   return;
    // }

    Get.bottomSheet(
      BottomSheetContainer(
        withCloseButton: false,
        title: 'Sign in',
        child: SignInSheet(),
      ),
      isScrollControlled: true,
    );
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }
}
