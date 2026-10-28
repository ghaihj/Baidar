abstract class VerifyCodeState {}

class VerifyCodeInitial extends VerifyCodeState {}
class VerifyCodeLoading extends VerifyCodeState {}
class VerifyCodeSuccess extends VerifyCodeState {}
class VerifyCodeFailure extends VerifyCodeState {
  final String message;
  VerifyCodeFailure(this.message);
}

class ResendCodeSuccess extends VerifyCodeState {}
class ResendCodeFailure extends VerifyCodeState {
  final String message;
  ResendCodeFailure(this.message);
}