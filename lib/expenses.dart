import 'package:expenses/widgets/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void newExpenseToAdd(Expense expense) {
    setState(() {
      _expensesList.add(expense);
    });
  }

  void _addNewExpenses() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(newExpenseToAdd: newExpenseToAdd));
  }

  final List<Expense> _expensesList = [
    Expense(
        title: "Lunch",
        amount: 19.99,
        date: DateTime.now(),
        category: ExpenseCategory.Food),
    Expense(
        title: "TV",
        amount: 30.9,
        date: DateTime.now(),
        category: ExpenseCategory.Home),
    Expense(
        title: "France",
        amount: 25.8,
        date: DateTime.now(),
        category: ExpenseCategory.Travel),
    Expense(
        title: "Train",
        amount: 23.2,
        date: DateTime.now(),
        category: ExpenseCategory.Transportation),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(onPressed: _addNewExpenses, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('chart'),
          Expanded(child: ExpensesList(expensesList: _expensesList))
        ],
      ),
    );
  }
}
