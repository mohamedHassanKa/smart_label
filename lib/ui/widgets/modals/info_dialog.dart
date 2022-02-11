import 'package:archi/ui/shared/config_manager.dart';
import 'package:flutter/material.dart';
import 'package:archi/ui/shared/colors.dart';
import 'package:archi/ui/shared/ui_enums.dart';

class InfoDialogContent extends StatelessWidget {
  const InfoDialogContent({
    Key? key,
    required this.status,
    required this.title,
    required this.bodyMessage,
    required this.onConfirmFunction,
    required this.onDiscardFunction,
  }) : super(key: key);
  final BasicDialogStatus status;
  final String title;
  final String bodyMessage;
  final Function? onConfirmFunction;
  final Function? onDiscardFunction;

  @override
  Widget build(BuildContext context) {
    return ConfigManager(
      builder: (context, layoutConfig) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: layoutConfig.getResponsiveItemSize(10),
            ),
            padding: const EdgeInsets.only(
              top: 32,
              left: 16,
              right: 16,
              bottom: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: layoutConfig.getHeightResponsiveItemSize(5),
                ),
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.deepOrange)
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: layoutConfig.getHeightResponsiveItemSize(10),
                ),
                Text(
                  bodyMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: layoutConfig.getHeightResponsiveItemSize(25),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -22,
            child: GestureDetector(
              onTap: () => {onDiscardFunction!()},
              child: Container(
                decoration: BoxDecoration(
                  color: _getStatusColor(status),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: Text(
                  'cancel',
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: -28,
            child: CircleAvatar(
              minRadius: 16,
              maxRadius: 28,
              backgroundColor: _getStatusColor(status),
              child: Icon(
                _getStatusIcon(status),
                size: 28,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color _getStatusColor(dynamic customData) {
    switch (customData) {
      case BasicDialogStatus.error:
        return kcRedColor;
      case BasicDialogStatus.warning:
        return kcOrangeColor;
      default:
        return kcPrimaryColor;
    }
  }

  IconData _getStatusIcon(dynamic regionDialogStatus) {
    if (regionDialogStatus is BasicDialogStatus)
      switch (regionDialogStatus) {
        case BasicDialogStatus.error:
          return Icons.close;
        case BasicDialogStatus.warning:
          return Icons.warning_amber;
        default:
          return Icons.check;
      }
    else {
      return Icons.check;
    }
  }
}
