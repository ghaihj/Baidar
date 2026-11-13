import 'package:baider_app/data/model/profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  final bool isUpdating;  //  لتتبع حالة التعديل (Save changes)

  ProfileLoaded({
    required this.profile,
    this.isUpdating = false,
  });

  ProfileLoaded copyWith({
    ProfileModel? profile,
    bool? isUpdating,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}