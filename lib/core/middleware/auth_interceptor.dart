import 'package:dio/dio.dart';
import '../services/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  AuthInterceptor(this.tokenStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorage.read();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options); // كمّل الطلب
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await tokenStorage.clear(); // التوكن منتهي أو غلط
      // لاحقاً: نوجّه المستخدم لصفحة تسجيل الدخول
    }
    handler.next(err); // مرّر الخطأ للـ Cubit
  }
}