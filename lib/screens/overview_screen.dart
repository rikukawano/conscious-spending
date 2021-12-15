import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/add_transaction_screen.dart';
import '/screens/transaction_type_screen.dart';
import '/models/transaction.dart';
import '/models/transactions.dart';
import '/models/app_color.dart';
import '/models/expense_type.dart';
import '/widgets/header.dart';
import '/widgets/expense_type_card.dart';
import '/widgets/overview_card.dart';

class OverviewScreen extends StatelessWidget {
  Widget _buildExpenseTypeCards() {
    return Container(
      width: 320,
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext ctx, int index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                ctx,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => TransactionTypeScreen(
                      transactionType: TransactionType.Income),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) =>
                          SlideTransition(
                    child: child,
                    position: Tween<Offset>(
                      begin: Offset(1, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                  ),
                ),
              ),
              child: ExpenseTypeCard(
                expenseType: ExpenseType.values.elementAt(index),
                expenseAmount: Provider.of<Transactions>(ctx).totalAmount(
                  txType: TransactionType.Expense,
                  expType: ExpenseType.values.elementAt(index),
                ),
                income: Provider.of<Transactions>(ctx)
                    .totalAmount(txType: TransactionType.Income),
              ),
            );
          },
          separatorBuilder: (BuildContext ctx, int index) =>
              SizedBox(height: 12),
          itemCount: ExpenseType.values.length),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(
                title: 'Overview',
                isSecondRoute: false,
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => TransactionTypeScreen(
                          transactionType: TransactionType.Income,
                        ),
                        transitionsBuilder: (_, Animation<double> animation, __,
                                Widget child) =>
                            SlideTransition(
                          child: child,
                          position: new Tween<Offset>(
                            begin: Offset(1, 0.0),
                            end: Offset.zero,
                          ).animate(animation),
                        ),
                      ),
                    ),
                    child: OverviewCard(
                      totalAmount: Provider.of<Transactions>(context)
                          .totalAmount(txType: TransactionType.Income),
                      isIncome: true,
                      transactions: Provider.of<Transactions>(context)
                          .transactions(txType: TransactionType.Income),
                    ),
                  ),
                  SizedBox(height: 32),
                  _buildExpenseTypeCards(),
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
            pageBuilder: (context, _, __) => AddTransactionScreen(
              onSubmit: _addNewTransaction,
              expenseType: ExpenseType.FixedCost,
            ),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) =>
                    SlideTransition(
              child: child,
              position: new Tween<Offset>(
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
