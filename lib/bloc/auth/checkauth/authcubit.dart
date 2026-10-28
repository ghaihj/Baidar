import 'package:baider_app/bloc/auth/checkauth/authstate.dart';
import 'package:baider_app/core/services/token_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final TokenStorage _tokenStorage;

  AuthCubit(this._tokenStorage) : super(AuthInitial());

  /// ناديها بداية التطبيق لفحص التوكن
  Future<void> checkAuth() async {
    final token = await _tokenStorage.read();
    if (token != null && token.isNotEmpty) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  /// ناديها لما المستخدم يسجل دخول بنجاح
  Future<void> setAuthenticated(String token) async {
    await _tokenStorage.save(token);
    emit(Authenticated());
  }

  /// ناديها لما المستخدم يعمل logout
  Future<void> logout() async {
    await _tokenStorage.clear();
    emit(Unauthenticated());
  }
}
