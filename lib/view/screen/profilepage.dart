import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () async {
          await context.read<AuthCubit>().resetApp();
          // ✅ الـ redirect رح يحوّل تلقائياً لـ onboarding
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red, // لون أحمر عشان يبان إنه خطير
        ),
        child: Text('إعادة ضبط التطبيق'),
      ),
    );
  }
}
