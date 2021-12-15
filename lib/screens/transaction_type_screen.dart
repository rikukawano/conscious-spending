import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/add_transaction_screen.dart';
import '/widgets/header.dart';
import '/models/app_color.dart';
import '/models/expense_type.dart';
import '/models/transaction.dart';
import '/models/transactions.dart';
import '/widgets/overview_card.dart';
import '/widgets/transaction_item.dart';

class TransactionTypeScreen extends StatelessWidget {
  final TransactionType transactionType;
  final ExpenseType? expenseType;

  TransactionTypeScreen({
    this.expenseType,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    final UnmodifiableListView<Transaction> _transactions =
        Provider.of<Transactions>(context)
            .transactions(txType: transactionType, expType: expenseType);
    final int _totalAmount = Provider.of<Transactions>(context)
        .totalAmount(txType: transactionType, expType: expenseType);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(
                title: expenseType?.title ?? 'Income',
                isSecondRoute: true,
              ),
              Column(
                children: [
                  OverviewCard(
                    totalAmount: _totalAmount,
                    isIncome: transactionType == TransactionType.Income
                        ? true
                        : false,
                    transactions: _transactions,
                  ),
                  SizedBox(height: 32),
                  _transactions.isEmpty
                      ? Center(child: Text('No transactions'))
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.56,
                          width: 320,
                          child: ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext ctx, int index) =>
                                  TransactionItem(
                                      _transactions[index],
                                      (_transactions[index].amount /
                                              _totalAmount *
                                              100)
                                          .round()),
                              separatorBuilder: (BuildContext ctx, int index) =>
                                  SizedBox(height: 12),
                              itemCount: _transactions.length),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, _, __) => AddTransactionScreen(expenseType),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) =>
                    SlideTransition(
              child: child,
              position: Tween<Offset>(
                begin: Offset(0.0, 1),
                end: Offset.zero,
              ).animate(animation),
            ),
          ),
        ),
        child: Container(
          height: 60,
          width: 60,
          child: Icon(
            Icons.add,
            size: 24,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.primaryTransparent,
                AppColor.primary,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
