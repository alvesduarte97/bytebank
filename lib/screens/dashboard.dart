import 'package:bytebank02/screens/contacts_lista.dart';
import 'package:bytebank02/screens/transactions_list.dart';
import 'package:bytebank02/screens/transfer_lista.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("images/bytebank_logo.png"),
          ),
          Container(
            height: 116,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _FeatureItem(
                  "Contacts",
                  Icons.people_alt,
                  onClick: () {
                    _showContactsList(context);
                  },
                ),
                _FeatureItem(
                  "Transfer",
                  Icons.monetization_on,
                  onClick: () {
                    _showTransferList(context);
                  },
                ),
                _FeatureItem("Transaction Feed", Icons.description,
                    onClick: () => _showTransactionFeed(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void _showContactsList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ContactsList()));
}

void _showTransferList(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TransferList()));
}

void _showTransactionFeed(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => TransactionsList()));
}

class _FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  const _FeatureItem(
    this.name,
    this.icon, {
    @required this.onClick,
  })  : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () {
            onClick();
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => TransferList(),
            //   ),
            // );
          },
          child: Container(
            padding: EdgeInsets.all(8.0),
            // height: 100,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  this.icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  this.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
