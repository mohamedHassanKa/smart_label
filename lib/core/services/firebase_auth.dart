import 'package:archi/core/models/common_models/api_result_model.dart';
import 'package:archi/core/models/common_models/error_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'package:injectable/injectable.dart';
import 'dart:math';
import 'dart:convert';
import '../constants/app_constants.dart' as constants;
import './connectivity_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';

@lazySingleton
class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ConnectivityService _connectivityService = ConnectivityService();
  Future<ApiResultModel> registerWithEmail({required email, required password}) async {
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);

        return const ApiResultModel.success(data: null);
      } on FirebaseAuthException catch (e) {
        return ApiResultModel.failure(
            errorModel: ErrorModel(
          errorCode: e.code,
          message: e.message,
          statusCode: 400,
        ));
      }
    } else {
      return ApiResultModel.failure(
        errorModel: ErrorModel(
          message: constants.connectionFailedString,
          errorCode: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel> signUpWithGoogle() async {
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        final googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          return const ApiResultModel.success(data: null);
        }
        final googleAuth = await googleUser.authentication;
        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(authCredential);

        return ApiResultModel.success(data: googleUser);
      } on FirebaseAuthException catch (e) {
        return ApiResultModel.failure(
            errorModel: ErrorModel(
          errorCode: e.code,
          message: e.message,
          statusCode: 400,
        ));
      }
    } else {
      return ApiResultModel.failure(
        errorModel: ErrorModel(
          message: constants.connectionFailedString,
          errorCode: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }

  Future<ApiResultModel> signInWithEmailAndPassword({required email, required password}) async {
    final bool connectivityResult = await _connectivityService.checkConnectivity();
    if (connectivityResult) {
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: password);

        return const ApiResultModel.success(data: null);
      } on FirebaseAuthException catch (e) {
        return ApiResultModel.failure(
            errorModel: ErrorModel(
          errorCode: e.code,
          message: e.message,
          statusCode: 400,
        ));
      }
    } else {
      return ApiResultModel.failure(
        errorModel: ErrorModel(
          message: constants.connectionFailedString,
          errorCode: constants.connectionFailedString,
          statusCode: constants.socketExceptionStatusCode,
        ),
      );
    }
  }
}
