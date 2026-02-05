

class Address {
  final String city;
  final String street;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city']?.toString() ?? '',
      street: json['street']?.toString() ?? '',
      zipcode: json['zipcode']?.toString() ?? '',
    );
  }

  String get formatted => '$street, $city, $zipcode';
}
