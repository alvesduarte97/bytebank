import 'dart:convert';

import 'package:bytebank02/models/transaction.dart';
import 'package:bytebank02/http/webclient.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  static const String authority = '192.168.1.106:8080';
  static const String unencodedPath = 'transactions';

  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.http(authority, unencodedPath))
        .timeout(Duration(seconds: 5));
    final List<dynamic> decodeJson = jsonDecode(response.body);
    return decodeJson.map((json) => Transaction.fromMap(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = transaction.toJson();

    final Response response = await client.post(
      Uri.http(authority, unencodedPath),
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    switch (response.statusCode) {
      case 400:
        throw Exception('there was an error submitting transaction');
        break;
      case 401:
        throw Exception('authentication failed');
        break;
    }

    return Transaction.fromJson(response.body);
  }
}
