import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction extends StatefulWidget {
  const Transaction({
    super.key,
    required this.description,
    required this.date,
    required this.amount,
    this.color,
    required this.remainingBalance,
    required this.type,
  });

  final String description;
  final String date;
  final double amount;
  final double remainingBalance;
  final String? color;
  final String type;

  @override
  State<StatefulWidget> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  late final String _amount = classifyAmount(widget.type, widget.amount);
  late final Color? _color = translateColorToBorder(widget.color);
  late final BoxBorder? _border = translateBorder(_color);

  String classifyAmount(String type, double amount) {
    String prefix = "";
    String amountStr = NumberFormat.decimalPattern().format(widget.amount);

    if (type == "income") {
      prefix = "+";
    } else if (type == "expense") {
      prefix = "-";
    }

    return prefix + amountStr;
  }

  String calculateRemainingBalance(
      double amount, double remainingBalance, String type) {
    if (type == "income") {
      remainingBalance = remainingBalance + amount;
    } else if (type == "expense") {
      remainingBalance = remainingBalance - amount;
    }

    return NumberFormat.decimalPattern().format(remainingBalance);
  }

  Color? translateColorToBorder(String? color) {
    switch (color) {
      case "orange":
        return Colors.orangeAccent;
      case "blue":
        return Colors.blueAccent;
      default:
        return null;
    }
  }

  BoxBorder? translateBorder(Color? color) {
    if (color == null) {
      return Border.all(color: Colors.black26);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    String balance = NumberFormat.decimalPattern()
        .format(widget.remainingBalance.toDouble());

    return Container(
        margin: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: _color,
            border: _border,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(widget.description,
                      style: Theme.of(context).textTheme.headlineSmall),
                  Text(_amount,
                      style: Theme.of(context).textTheme.headlineSmall)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text(widget.date),
                  Text(
                    'Balance $balance',
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
