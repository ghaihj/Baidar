import 'package:baider_app/core/constant/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const CustomSearchField({
    Key? key,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,  //  يكبّر القيمة للـ parent
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(Icons.search, color: AppColors.primarycolor),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}