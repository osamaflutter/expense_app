import 'package:expense_app/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});
  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _regExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 10.9,
      date: DateTime.now(),
      category: Category.work,
    ),

    Expense(
      title: 'Holiday',
      amount: 50.9,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openExpenseOverLay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: addExpense);
      },
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _regExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _regExpenses.indexOf(expense);
    setState(() {
      _regExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _regExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense tracker'),
        actions: [
          IconButton(onPressed: _openExpenseOverLay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(expense: _regExpenses, onRemove: removeExpense),
          ),
        ],
      ),
    );
  }
}
