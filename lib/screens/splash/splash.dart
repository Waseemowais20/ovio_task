import 'package:video_cached_player/video_cached_player.dart';

import '../../general_exports.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(AppColors.white),
      body: GetBuilder<SplashController>(
        init: SplashController(),
        builder: (SplashController controller) {
          return controller.videoController == null
              ? const Center()
              : SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Transform.scale(
                      scale: 1.1,
                      child: SizedBox(
                        width: controller.videoController!.value.size.width,
                        height: controller.videoController!.value.size.height,
                        child: CachedVideoPlayer(controller.videoController!),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
