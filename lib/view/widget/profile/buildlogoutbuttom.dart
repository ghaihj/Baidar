import 'package:baider_app/bloc/auth/checkauth/authcubit.dart';
import 'package:baider_app/core/localization/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Buildlogoutbuttom extends StatelessWidget {
  final Locale locale;

  const Buildlogoutbuttom({Key? key, required this.locale}) : super(key: key);

  @override
  Widget build(BuildContext context) {  
    return TextButton(
      onPressed: () {
        context.read<AuthCubit>().logout();  
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.red, size: 20),
          const SizedBox(width: 8),
          Text(
            AppTranslations.tr(locale, 'logout'),
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}