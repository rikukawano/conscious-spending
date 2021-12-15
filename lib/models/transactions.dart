import 'dart:collection';
import 'package:flutter/material.dart';
import 'expense_type.dart';
import 'transaction.dart';

class Transactions with ChangeNotifier {
  List<Transaction> _items = [
    Transaction(
      id: '001',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.FixedCost,
      title: 'Rent',
      amount: 37250,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '002',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.FixedCost,
      title: 'Groceries',
      amount: 25000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '003',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.FixedCost,
      title: 'Wifi',
      amount: 2500,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '004',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.FixedCost,
      title: 'Gas',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.FixedCost,
      title: 'Utilities',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.Investment,
      title: 'Bitcoin',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.Investment,
      title: 'ETF',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.Investment,
      title: 'Netflix',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.Savings,
      title: 'Travel',
      amount: 50000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.Savings,
      title: 'House',
      amount: 50000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.GuiltFree,
      title: 'Netflix',
      amount: 1000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.GuiltFree,
      title: 'Trousers',
      amount: 5000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.GuiltFree,
      title: 'French Dinner',
      amount: 10000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Expense,
      expenseType: ExpenseType.GuiltFree,
      title: 'Water bottle',
      amount: 1000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Income,
      title: 'ZMP Salary',
      amount: 200000,
      date: DateTime.utc(2021, 6, 18),
    ),
    Transaction(
      id: '005',
      transactionType: TransactionType.Income,
      title: 'Borda',
      amount: 60000,
      date: DateTime.utc(2021, 6, 18),
    ),
  ];

  UnmodifiableListView<Transaction> get items => UnmodifiableListView(_items);

  UnmodifiableListView<Transaction> transactions(
      {required TransactionType txType, ExpenseType? expType}) {
    if (txType == TransactionType.Income) {
      return UnmodifiableListView(_items
          .where((tx) => tx.transactionType == TransactionType.Income)
          .toList());
    } else {
      return UnmodifiableListView(
          _items.where((tx) => tx.expenseType == expType).toList());
    }
  }

  int totalAmount({required TransactionType txType, ExpenseType? expType}) {
    if (txType == TransactionType.Income) {
      int sum = 0;
      this.transactions(txType: txType).forEach((tx) => sum += tx.amount);
      return sum;
    } else {
      int sum = 0;
      this
          .transactions(txType: txType, expType: expType)
          .forEach((tx) => sum += tx.amount);
      return sum;
    }
  }

  void addItem({
    required TransactionType txType,
    ExpenseType? expenseType,
    required String title,
    required int amount,
    required DateTime date,
  }) {
    _items.add(Transaction(
      id: DateTime.now().toString(),
      transactionType: txType,
      title: title,
      amount: amount,
      date: date,
    ));
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
}
