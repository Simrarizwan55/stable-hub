class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String country;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] as String,
      name: map["fullName"] as String,
      email: map["email"] as String,
      phone: map["phone"] as String,
      country: map["country"] as String,
    );
  }
}
