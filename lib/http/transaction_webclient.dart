import 'dart:convert';

import 'package:bytebank02/models/transaction.dart';
import 'package:bytebank02/http/webclient.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  static const String authority = '192.168.1.106:8080';
  static const String unencodedPath = 'transactions';

  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get(Uri.http(authority, unencodedPath));
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

    if (response.statusCode == 200) {
      return Transaction.fromJson(response.body);
    }
    _throwHttpError(response.statusCode);
  }

  void _throwHttpError(int statusCode) =>
      throw HttpException(_getMessage(statusCode));

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting transaction',
    401: 'Authentication failed',
    409: 'Transaction already exists',
  };

  String _getMessage(int statusCode) {
    String message = _statusCodeResponses[statusCode];

    if (message == null) {
      message = 'Unkown Error';
    }

    return message;
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
