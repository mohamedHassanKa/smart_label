import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:archi/core/providers/user_provider.dart';
import 'package:archi/ui/widgets/modals/modal_export.dart';
import 'package:archi/ui/shared/ui_enums.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserAuthentificationProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        socialCircleAvatar("assets/icons/apple.png", () {}),
        const SizedBox(width: 22),
        socialCircleAvatar("assets/icons/google.png", () async {
          final signUpData = await userProvider.signUpWithgoogle();
          signUpData.when(success: (success) {
            Navigator.pushNamed(context, '/home');
          }, failure: (failure) {
            CommunModals.showInfoModal(context, failure.errorCode!, failure.message!, BasicDialogStatus.error);
          });
        }),
      ],
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        maxRadius: 24,
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }
}
