String? validInput(String val, int min, int max, String type) {
  if (val.trim().isEmpty) {
    return "الحقل لا يمكن أن يكون فارغاً";
  }

  if (type == "username") {
    if (!RegExp(r'^[\p{L}\p{N}_. ]+$', unicode: true).hasMatch(val)) {
      return "اسم المستخدم غير صالح";
    }
  }

  if (type == "email") {
    if (!RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(val)) {
      return "البريد الإلكتروني غير صالح";
    }
  }

  if (val.length < min) {
    return "يجب ألا يقل عن $min أحرف";
  }

  if (val.length > max) {
    return "يجب ألا يزيد عن $max حرفاً";
  }

  return null; // null = الحقل سليم
}