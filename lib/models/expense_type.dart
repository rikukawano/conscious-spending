import 'package:flutter/material.dart';

import 'app_color.dart';

enum ExpenseType {
  FixedCost,
  Investment,
  Savings,
  GuiltFree,
}

extension ExpenseTypeExtension on ExpenseType {
  String get title {
    switch (this) {
      case ExpenseType.FixedCost:
        return 'Fixed Cost';
      case ExpenseType.Investment:
        return 'Investment';
      case ExpenseType.Savings:
        return 'Savings';
      case ExpenseType.GuiltFree:
        return 'Guilt Free';
    }
  }

  String get icon {
    switch (this) {
      case ExpenseType.FixedCost:
        return '🏠';
      case ExpenseType.Investment:
        return '🪴';
      case ExpenseType.Savings:
        return '💰';
      case ExpenseType.GuiltFree:
        return '🍻';
    }
  }

  Map<String, Color> get colors {
    switch (this) {
      case ExpenseType.FixedCost:
        return {
          'opaque': AppColor.fixedCost,
          'transparent': AppColor.fixedCostTransparent
        };
      case ExpenseType.Investment:
        return {
          'opaque': AppColor.investment,
          'transparent': AppColor.investmentTransparent
        };
      case ExpenseType.Savings:
        return {
          'opaque': AppColor.savings,
          'transparent': AppColor.savingsTransparent
        };
      case ExpenseType.GuiltFree:
        return {
          'opaque': AppColor.guiltFree,
          'transparent': AppColor.guiltFreeTransparent
        };
    }
  }

  String get routeName {
    switch (this) {
      case ExpenseType.FixedCost:
        return '/fixed-cost';
      case ExpenseType.Investment:
        return '/investment';
      case ExpenseType.Savings:
        return '/savings';
      case ExpenseType.GuiltFree:
        return '/guilt-free';
    }
  }
}
