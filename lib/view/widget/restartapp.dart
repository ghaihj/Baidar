//  Container(
//       child: ElevatedButton(
//         onPressed: () async {
//           await context.read<AuthCubit>().resetApp();
//           // ✅ الـ redirect رح يحوّل تلقائياً لـ onboarding
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red, // لون أحمر عشان يبان إنه خطير
//         ),
//         child: Text('إعادة ضبط التطبيق'),
//       ),
//     );