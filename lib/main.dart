import 'package:flutter/material.dart';

import 'dart:math';

import '/models/transaction.dart';

import 'components/chart.dart';
import 'components/transaction_list.dart';

import 'components/transaction_form.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.green[400]),
        fontFamily: 'Quicksand',
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transaction = [
    Transaction(
      id: 't0',
      title: 'novo tenis de basquete',
      value: 700.76,
      date: DateTime.now().subtract(Duration(days: 30)),
    ),
    Transaction(
      id: 't1',
      title: 'novo tenis de corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz',
      value: 670.89,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz 2',
      value: 4670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz 3',
      value: 56670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz 4',
      value: 566670.89,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de luz 5',
      value: 400.89,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transaction.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Despesas Pessoais",
        ),
        actions: [
          IconButton(
            onPressed: () => _openTransactionFormModal(context),
            icon: Icon(Icons.add_circle_outline_outlined),
            iconSize: 50,
            color: Colors.green[900],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            Transaction_list(_transaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(
          Icons.add_circle_outline_sharp,
          size: 50,
        ),
        backgroundColor: Colors.green[900],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
