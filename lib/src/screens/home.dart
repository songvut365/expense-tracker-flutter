import 'package:expense_tracker/src/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import '../widgets/transaction.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title, required this.location});
  final String title;
  final String location;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = json.decode(
      '''
      {
        "month":1,
        "year":2023,
        "remaining_balance":500,
        "transactions": [
          {"id":"1","sequence":1,"description":"Salary","amount":100000,"date":"1/1/2023","type":"income","category":"","color":""},
          {"id":"2","sequence":2,"description":"Shirt","amount":2000,"date":"2/1/2023","type":"expense","category":"online","color":"orange"},
          {"id":"3","sequence":3,"description":"Smart Phone","amount":30000,"date":"3/1/2023","type":"expense","category":"credit card","color":"blue"},
          {"id":"4","sequence":4,"description":"Shoes","amount":5000,"date":"3/1/2023","type":"expense","category":"credit card","color":"blue"}
        ]
      }
      ''');

  double remainingBalance = 0;

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    remainingBalance = calculateLastRemainingBalance();
  }

  double calculateLastRemainingBalance() {
    var transactions = data['transactions'];
    double balance = data['remaining_balance'].toDouble();

    transactions.forEach((trx) {
      if (trx['type'] == "income") {
        balance += trx['amount'].toDouble();
      } else if (trx['type'] == 'expense') {
        balance -= trx['amount'].toDouble();
      }
    });

    return balance;
  }

  ListView buildTransactionList() {
    double balance = data['remaining_balance'].toDouble();

    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: data['transactions'].length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = data['transactions'][index];

          TransactionModel trx = TransactionModel(
              description: item['description'],
              date: item['date'],
              amount: item['amount'].toDouble(),
              remainingBalance: remainingBalance,
              type: item['type'],
              color: item['color']);

          if (trx.type == "income") {
            balance += trx.amount;
          } else if (trx.type == "expense") {
            balance -= trx.amount;
          }

          return Transaction(
            description: trx.description,
            date: trx.date,
            amount: trx.amount,
            remainingBalance: balance,
            type: trx.type,
            color: trx.color,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String year = data['year'].toString();
    String month =
        DateFormat.MMMM().format(DateTime(data['year'], data['month']));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[100],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title,
                style: Theme.of(context).textTheme.headlineSmall),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                Text(
                  widget.location,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            )
          ],
        ),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 20, top: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      '$month $year',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: 520,
                  child: buildTransactionList(),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('Balance ',
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(NumberFormat.decimalPattern().format(remainingBalance),
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        padding: EdgeInsets.zero,
        shape: const CircularNotchedRectangle(),
        color: Colors.grey[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  ModalRoute<dynamic>? currentRoute = ModalRoute.of(context);
                  if (currentRoute != null) {
                    if (currentRoute.settings.name != "/home") {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  }
                },
                iconSize: 40,
                icon: const Icon(Icons.home_rounded)),
            IconButton(

                onPressed: () {},
                iconSize: 36,
                icon: const Icon(Icons.bar_chart_rounded)),
            IconButton(
                onPressed: () {},
                iconSize: 36,
                icon: const Icon(Icons.library_books_rounded)),
            IconButton(
                onPressed: () {},
                iconSize: 36,
                icon: const Icon(Icons.notifications_rounded)),
            IconButton(
                onPressed: () {},
                iconSize: 36,
                icon: const Icon(Icons.menu_rounded)),
          ],
        ),
      ),
    );
  }
}
