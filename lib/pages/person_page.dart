import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_flie_fromjason/models/address.dart';
import 'package:read_flie_fromjason/models/person.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key});

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  late List<Person> persons = [];
  final ValueNotifier<bool> _isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    initList();
  }

  Future<void> initList() async {
    try {
      final result = await rootBundle.loadString('assets/data.json');
      final response = jsonDecode(result);
      if (response != null && response['data'] != null) {
        persons = List<Person>.from(
            response['data'].map((e) => Person().fromJson(e)).toList());
      }
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Person List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.grey[100],
        child: ValueListenableBuilder<bool>(
          valueListenable: _isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                final person = persons[index];
                return ListTile(
                  title: Text(person.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age: ${person.age}'),
                      Text('Phone: ${person.phone}'),
                      Text('Email: ${person.email}'),
                      if (person.address != null)
                        Text(
                          'Address: ${_formatAddress(person.address!)}',
                        ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatAddress(Address address) {
    List<String> addressParts = [];
    if (address.street.isNotEmpty) addressParts.add(address.street);
    if (address.city.isNotEmpty) addressParts.add(address.city);
    if (address.state.isNotEmpty) addressParts.add(address.state);

    return addressParts.join(', ');
  }
}
