import 'package:flutter/material.dart';
import 'package:taxi_app/component/status_tile/status_tile.dart';

extension StatusTileSnackbar on BuildContext {
  void showStatusTileSnackbar({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    bool isCenter = false,
    bool isButton = false,
    StatusTileType type = StatusTileType.error,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      backgroundColor:Colors.transparent,
      elevation: 0,
      content: StatusTile(
        error: message,
        isCenter: isCenter,
        isButton: isButton,
        backgroundColor: backgroundColor,
        textColor: textColor,
        type: type,
      ),
      duration: duration,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
