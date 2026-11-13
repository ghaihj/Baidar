class ProfileModel {
  final int id;
  final String name;
  final String email;
  final String location;
  final String? image;

  const ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    this.image,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'email': email,
  //     'location': location,
  //   };
  // }
}