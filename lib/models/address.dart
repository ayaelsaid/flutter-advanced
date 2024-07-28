class Address {
  late String city;
  late String street;
  late String state;

  Address();

  Address fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      city = data['city'] ?? '';
      street = data['street'] ?? '';
      state = data['state'] ?? '';
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'state': state,
    };
  }
}
