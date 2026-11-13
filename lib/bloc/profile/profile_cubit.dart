import 'package:baider_app/data/datasource/remote/profile_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:baider_app/bloc/profile/profile_state.dart';
import 'package:baider_app/data/model/profile_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileData profileData;

  ProfileCubit(this.profileData) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      var data = await profileData.getProfile();
      var profile = ProfileModel.fromJson(data);
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<bool> updateProfile({
    required String name,
    required String email,
    required String location,
  }) async {
    final current = state;
    if (current is! ProfileLoaded) return false;

    // setState: isUpdating = true (الزر يطلع loading)
    emit(current.copyWith(isUpdating: true));

    try {
      await profileData.updateProfile(
        name: name,
        email: email,
        location: location,
      );

      final updatedProfile = ProfileModel(
        id: current.profile.id,
        name: name,
        email: email,
        location: location,
        image: current.profile.image,
      );

      emit(ProfileLoaded(profile: updatedProfile, isUpdating: false));
      return true;  
    } catch (e) {
      emit(current.copyWith(isUpdating: false));  // رجّع isUpdating = false
      emit(ProfileError(e.toString()));
      return false;  
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final current = state;
    if (current is! ProfileLoaded) return false;

    emit(current.copyWith(isUpdating: true));

    try {
      await profileData.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      emit(current.copyWith(isUpdating: false));
      return true; 
    } catch (e) {
      emit(current.copyWith(isUpdating: false));
      emit(ProfileError(e.toString()));
      return false;
    }
  }
}