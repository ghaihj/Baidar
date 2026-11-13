import 'package:baider_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  const InfoCard({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.gray1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.primarycolor,
            ),
          ),
        ],
      ),
    );
  }
}



// InfoCard(label: 'PH min', value: '${plant.phMin}') <------ هيك الاستدعاء 

// ========================= هي مشان طريقة العرص ===========================


// Column(
//   children: [
//     // بطاقة بعرض كامل
//     InfoCard(label: 'Soil Type', value: 'Clayey Sandy Well-Drained'),
//     const SizedBox(height: 12),

//     // صف بطاقتين
//     Row(
//       children: [
//         Expanded(child: InfoCard(label: 'PH min', value: '6')),
//         const SizedBox(width: 12),
//         Expanded(child: InfoCard(label: 'PH max', value: '7')),
//       ],
//     ),
//     const SizedBox(height: 12),

//     Row(
//       children: [
//         Expanded(child: InfoCard(label: 'Min Temp (°C)', value: '18°C')),
//         const SizedBox(width: 12),
//         Expanded(child: InfoCard(label: 'Max Temp (°C)', value: '30°C')),
//       ],
//     ),
//     const SizedBox(height: 12),

//     Row(
//       children: [
//         Expanded(child: InfoCard(label: 'Min Humidity (%)', value: '60%')),
//         const SizedBox(width: 12),
//         Expanded(child: InfoCard(label: 'Max Humidity (%)', value: '80%')),
//       ],
//     ),
//   ],
// )