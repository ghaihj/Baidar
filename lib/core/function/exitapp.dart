import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> alertExit(BuildContext context) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('تنبيه'),
      content: const Text('هل تريد الخروج من التطبيق؟'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('لا'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('نعم'),
        ),
      ],
    ),
  );

  if (confirm == true) {
    SystemNavigator.pop(); // يغلق التطبيق
  }
}