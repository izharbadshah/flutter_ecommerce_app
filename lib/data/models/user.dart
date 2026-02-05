

import 'address.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String phone;
  final Name name;
  final Address address;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? 'N/A',
      name: Name.fromJson(json['name'] ?? {}),
      address: Address.fromJson(json['address'] ?? {}),
    );
  }

  String get fullName =>
      '${name.firstname.isNotEmpty ? name.firstname : 'User'} '
          '${name.lastname.isNotEmpty ? name.lastname : ''}';

  String get initials {
    final f = name.firstname.isNotEmpty ? name.firstname[0] : 'U';
    final l = name.lastname.isNotEmpty ? name.lastname[0] : '';
    return '$f$l'.toUpperCase();
  }
}

class Name {
  final String firstname;
  final String lastname;

  const Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }
}

