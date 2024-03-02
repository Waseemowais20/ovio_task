import '../../general_exports.dart';

class BottomSheetContainer extends StatelessWidget {
  const BottomSheetContainer({
    this.child,
    this.title,
    this.subTitle,
    this.withCloseButton = true,
    Key? key,
    this.titlePadding,
  }) : super(key: key);

  final Widget? child;
  final String? title;
  final String? subTitle;
  final double? titlePadding;
  final bool withCloseButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: DEVICE_HEIGHT * 0.8,
      ),
      decoration: BoxDecoration(
        color: const Color(AppColors.white),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DEVICE_WIDTH * 0.02),
          topRight: Radius.circular(DEVICE_WIDTH * 0.02),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(DEVICE_WIDTH * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (withCloseButton)
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: GestureDetector(
                  onTap: Get.back,
                  child: const Icon(Icons.close),
                ),
              ),
            if (title != null && title!.isNotEmpty)
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                ),
              ),
            if (subTitle != null && subTitle!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: DEVICE_WIDTH * 0.04),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    subTitle!,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                  ),
                ),
              ),
            SizedBox(height: titlePadding ?? DEVICE_HEIGHT * 0.04),
            child ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
