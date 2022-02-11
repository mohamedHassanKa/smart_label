import 'package:archi/ui/widgets/modals/modal_export.dart';
import 'package:flutter/material.dart';
import 'basic_dialog.dart';
import 'package:archi/ui/shared/ui_enums.dart';

mixin CommunModals {
  static void showBasicModal(BuildContext context, String basicTitle, String basicMessage, BasicDialogStatus status,
      [Function? onConfirmFunction, Function? onDiscardFunction]) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: BasicDialogContent(
            onConfirmFunction: onConfirmFunction ?? () => Navigator.pop(context),
            onDiscardFunction: onDiscardFunction ?? () => Navigator.pop(context),
            bodyMessage: basicMessage,
            title: basicTitle,
            status: status,
          ),
        );
      },
    );
  }

  static void showInfoModal(BuildContext context, String basicTitle, String basicMessage,
      [BasicDialogStatus status = BasicDialogStatus.success,
      Function? onConfirmFunction,
      Function? onDiscardFunction]) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: InfoDialogContent(
            onConfirmFunction: onConfirmFunction ?? () => {Navigator.pop(context)},
            onDiscardFunction: onDiscardFunction ?? () => {Navigator.pop(context)},
            bodyMessage: basicMessage,
            title: basicTitle,
            status: status,
          ),
        );
      },
    );
  }
}
