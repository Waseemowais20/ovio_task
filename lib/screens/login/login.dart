import '../../general_exports.dart';

class SignInSheet extends StatelessWidget {
  SignInSheet({
    super.key,
  });

  final TextEditingController userName =
      TextEditingController(text: 'aa_owais_waseem');
  final TextEditingController password =
      TextEditingController(text: 'a1e1DwX5Ln');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: <Widget>[
              SizedBox(width: DEVICE_WIDTH * 0.02),
              Expanded(
                child: CustomInput(
                  controller: userName,
                  hint: 'UserName',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            children: <Widget>[
              SizedBox(width: DEVICE_WIDTH * 0.02),
              Expanded(
                child: CustomInput(
                  controller: password,
                  hint: 'Password',
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.05),
        GetBuilder<LoginController>(
          init: LoginController(),
          builder: (LoginController controller) {
            return SizedBox(
              width: DEVICE_WIDTH,
              child: AppButton(
                onPressed: () {
                  controller.getToken(
                    userName.text.trim(),
                    password.text,
                  );
                },
                text: 'Sign In'.tr,
              ),
            );
          },
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
      ],
    );
  }
}
