class ExpenseIncomeModel {
  String year;
  int month;
  double remainingBalance;
  List<TransactionModel> transaction;

  ExpenseIncomeModel({
    required this.year,
    required this.month,
    required this.remainingBalance,
    required this.transaction,
  });
}

class TransactionModel {
  String description;
  String date;
  double amount;
  double remainingBalance;
  String type;
  String? color;

  TransactionModel(
      {required this.description,
      required this.date,
      required this.amount,
      required this.remainingBalance,
      required this.type,
      this.color});
}
