class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String country;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    print(map);
    print(map["phone"]);
    return User(
      id: map["_id"],
      name: map["fullName"],
      email: map["email"],
      phone: map["phone"],
      country: map["country"],
    );
  }
}
