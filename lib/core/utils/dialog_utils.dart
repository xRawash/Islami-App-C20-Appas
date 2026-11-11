import 'package:flutter/material.dart';
import 'package:quran_app_abbas/core/sources/colors_manager.dart';

class DialogUtils {
  static void showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String positiveButtonText = "OK",
    VoidCallback? onPositivePressed,
  }) {
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsManager.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: ColorsManager.gold, width: 2),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: ColorsManager.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onPositivePressed != null) {
                onPositivePressed();
              }
            },
            child: Text(
              positiveButtonText,
              style: const TextStyle(
                color: ColorsManager.gold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
