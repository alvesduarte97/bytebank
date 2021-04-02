import 'package:bytebank02/database/app_database.dart';
import 'package:bytebank02/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();

    return db.insert('contacts', _toMap(contact));
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();

    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query('contacts');

    return _toList(result);
  }

  List<Contact> _toList(List<Map<String, dynamic>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> map in result) {
      final Contact contact = Contact(
        id: map[_id],
        name: map[_name],
        accountNumber: map[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}
