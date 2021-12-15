import 'expense_type.dart';

enum TransactionType {
  Expense,
  Income,
}

class Transaction {
  final String id;
  final TransactionType transactionType;
  final ExpenseType? expenseType;
  final String title;
  final int amount;
  final DateTime date;

  Transaction({
    required this.id,
    required this.transactionType,
    this.expenseType,
    required this.title,
    required this.amount,
    required this.date,
  });
}
