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
  bool _showChart = false;
  final List<Transaction> _transaction = [
    /* Transaction(
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
    ),*/
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

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transaction.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transaction.removeWhere((tr) => tr.id == id);
    });
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
    final appBar = AppBar(
      title: Text(
        "Despesas Pessoais",
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
          iconSize: 50,
          color: Colors.green[900],
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Exibir gráfico',
                ),
                Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  },
                ),
              ],
            ),
            if (_showChart)
              SizedBox(
                height: availableHeight * 0.3,
                child: Chart(
                  _recentTransactions,
                ),
              ),
            if (!_showChart)
              SizedBox(
                height: availableHeight * 0.7,
                child: Transaction_list(
                  _transaction,
                  _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(
          Icons.add_circle,
          size: 50,
        ),
        backgroundColor: Colors.green[200],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
