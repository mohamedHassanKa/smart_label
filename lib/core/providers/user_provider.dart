import 'package:archi/core/models/common_models/api_result_model.dart';
import 'package:archi/core/providers/base_provider.dart';
import 'package:archi/ui/shared/locator_setup/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import './base_provider.dart';
import 'package:injectable/injectable.dart';
import '../services/firebase_auth.dart';

@injectable
class UserAuthentificationProvider extends BaseProvider {
  final FirebaseAuthService firebaseAuth = locator<FirebaseAuthService>();
  var user;

  Future<ApiResultModel> signUpWithEmail({required email, required password}) async {
    setBusy(true);
    ApiResultModel? call = await firebaseAuth.registerWithEmail(email: email, password: password);
    setBusy(false);
    return call.when(success: (succ) {
      print('----- user Registred Succesfully');
      user = FirebaseAuth.instance.currentUser;
      return ApiResultModel.success(data: User);
    }, failure: (error) {
      print('An error Occured while registerin The User');
      return ApiResultModel.failure(errorModel: error);
    });
  }

  Future<ApiResultModel> signUpWithgoogle() async {
    setBusy(true);
    ApiResultModel? call = await firebaseAuth.signUpWithGoogle();

    return call.when(success: (succ) {
      setBusy(false);
      print('----- user signed Succesfully with google');
      user = FirebaseAuth.instance.currentUser;
      return ApiResultModel.success(data: User);
    }, failure: (error) {
      setBusy(false);
      print('An error Occured while signning in');
      return ApiResultModel.failure(errorModel: error);
    });
  }

  Future<ApiResultModel> signInWithEmailAndPassword({required email, required password}) async {
    setBusy(true);
    ApiResultModel? call = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    setBusy(false);
    return call.when(success: (succ) {
      print('----- user Login Succesfully');
      user = FirebaseAuth.instance.currentUser;
      return ApiResultModel.success(data: User);
    }, failure: (error) {
      print('An error Occured while Loggingg The User');
      return ApiResultModel.failure(errorModel: error);
    });
  }
}
