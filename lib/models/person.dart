
import 'package:read_flie_fromjason/models/address.dart';

class Person {
  late int id;
  late String name;
  late int age;
  late String phone;
  late String email;
  Address? address;

  Person();

  Person fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? 0;
    name = data['name'] ?? '';
    age = data['age'] ?? 0;
    phone = data['phone'] ?? '';
    email = data['email'] ?? '';
    address = data.containsKey('address') && data['address'] != null
        ? Address().fromJson(data['address'])
        : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'phone': phone,
      'email': email,
      'address': address?.toJson(),
    };
  }
}
