import 'package:archi/core/models/common_models/error_model.dart';
import 'package:archi/core/providers/user_provider.dart';
import 'package:archi/ui/widgets/base_view_model.dart';
import 'package:archi/ui/widgets/modals/basic_dialog.dart';
import 'package:archi/ui/widgets/utility_functions/validators.dart';
import 'package:flutter/material.dart';
import '../../widgets/bottom_curve_painter.dart';
import '../../widgets/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import './social_login_buttons.dart';
import '../../widgets/modals/common_function.dart';
import 'package:archi/ui/shared/ui_enums.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              child: ClipPath(
                clipper: BottomShapeClipper(),
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            ClipPath(
              clipper: BottomShapeClipper2(),
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _loginGradientText(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  _textAccount(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  registerFields(context)
                ],
              ),
            )
          ]),
        ));
  }

  GradientText _loginGradientText(context) {
    return GradientText('Register',
        gradient: LinearGradient(colors: [Theme.of(context).primaryColor, const Color(0xFF68D8D6)]),
        style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.bold, fontSize: 42));
  }

  Widget _textAccount(context) {
    return FittedBox(
      child: Row(
        children: <Widget>[
          Text(
            "Have you registred already? ",
            style: Theme.of(context).textTheme.headline6,
          ),
          Text("Login Here .",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: Colors.deepOrange)
                  .copyWith(fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  registerFields(context) {
    //final userProvider = Provider.of<UserAuthentificationProvider>(context);
    return BaseViewModelWidget<UserAuthentificationProvider>(
      builder: (context, userProvider) => Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.2),
                          blurRadius: 20.0,
                          offset: const Offset(0, 10))
                    ]),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
                          child: TextFormField(
                            validator: validateEmail,
                            controller: _email,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Email",
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
                          child: TextFormField(
                            obscureText: _passwordVisible,
                            validator: validatePassword,
                            controller: _password,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _confirmPassword,
                            obscureText: _passwordVisible,
                            validator: _validatePasswordConfirmation,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.grey[400]),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible ? Icons.visibility_off : Icons.visibility,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final signIndata =
                            await userProvider.signUpWithEmail(email: _email.text, password: _password.text);
                        signIndata.when(success: (success) {
                          Navigator.pushNamed(context, '/home');
                        }, failure: (failure) {
                          CommunModals.showInfoModal(
                              context, failure.errorCode!, failure.message!, BasicDialogStatus.error);
                        });
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.5),
                            ])),
                        child: Center(
                          child: userProvider.busy
                              ? CircularProgressIndicator(
                                  color: Theme.of(context).hintColor,
                                )
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const SizedBox(height: 8),
            Text(
              "Or Sign Up with",
              style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const SocialLoginButtons()
          ],
        ),
      ),
    );
  }

  String? _validatePasswordConfirmation(String? pass2) {
    return (pass2 == _password.text) ? null : "The two passwords must match";
  }
}
