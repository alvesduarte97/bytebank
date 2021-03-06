import 'package:bytebank02/http/transaction_webclient.dart';
import 'package:bytebank02/models/transaction.dart';
import 'package:bytebank02/widgets/centeredMessage.dart';
import 'package:bytebank02/widgets/progress.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = TransactionWebClient();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactionsss'),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 1))
            .then((value) => _webClient.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Progress();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transaction> transactions = snapshot.data;
              if (snapshot.hasData && transactions.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Transaction transaction = transactions[index];
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.monetization_on),
                        title: Text(
                          transaction.value.toString(),
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          transaction.contact.accountNumber.toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                );
              }

              return CenteredMessage(
                "No data found",
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage(
            "Er",
            icon: Icons.warning,
          );
        },
      ),
    );
  }
}
