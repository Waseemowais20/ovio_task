import '../../general_exports.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    this.onPressed,
    this.text,
    this.style,
    this.textStyle,
    super.key,
  });

  final Function? onPressed;
  final String? text;
  final ButtonStyle? style;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed?.call();
      },
      style: style,
      child: Text(
        text ?? '',
        style: textStyle ??
            Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(AppColors.white),
                ),
      ),
    );
  }
}
