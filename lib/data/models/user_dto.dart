class UserDto {
  final String name;
  final String email;
  final String? profileImageUrl;

  const UserDto({
    required this.name,
    required this.email,
    required this.profileImageUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    // Be defensive about possible key variations.
    final name = (json['name'] ?? json['fullName'] ?? json['username'] ?? '').toString();
    final email = (json['email'] ?? '').toString();

    final profileImageUrl =
        (json['profileImageUrl'] ?? json['profileImage'] ?? json['image'] ?? json['avatar'] ?? json['profile_pic'])
            ?.toString();

    return UserDto(
      name: name,
      email: email,
      profileImageUrl: profileImageUrl,
    );
  }
}

