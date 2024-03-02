import '../../general_exports.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onChange,
    this.fillColor = AppColors.gray9,
    this.textInputAction = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.validator,
    this.initialValue,
    this.hintStyle,
    this.onFieldSubmitted,
    this.obscureText = false,
  });

  final String? hint;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int fillColor;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function? onChange;
  final Function? onFieldSubmitted;
  final int? borderColor;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: const Color(
        AppColors.blue2,
      ),
      initialValue: initialValue,
      onChanged: (String value) {
        onChange?.call(value);
      },
      onFieldSubmitted: (String value) {
        onFieldSubmitted?.call(value);
      },
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: const Color(AppColors.black),
          ),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        isCollapsed: true,
        hintText: hint,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.symmetric(
          horizontal: DEVICE_WIDTH * 0.04,
          vertical: DEVICE_HEIGHT * 0.015,
        ),
        fillColor: Color(fillColor),
        filled: true,
        enabledBorder: _getInputBorder(),
        focusedBorder: _getInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }

  InputBorder _getInputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(
          borderColor ?? fillColor,
        ),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(DEVICE_WIDTH * 0.01),
      ),
    );
  }
}
