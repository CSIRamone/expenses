import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
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

  Widget _getIconButton(IconData icon, Function() fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final iconList = Platform.isIOS ? CupertinoIcons.list_dash : Icons.list;
    final chartList =
        Platform.isIOS ? CupertinoIcons.chart_pie : Icons.pie_chart;

    final actions = [
      if (isLandScape)
        _getIconButton(
          _showChart ? iconList : chartList,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];

    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Despesas Pessoais'),
      actions: actions,
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*if (isLandScape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Exibir gráfico',
                    ),
                    Switch.adaptive(
                      value: _showChart,
                      onChanged: (value) {
                        setState(() {
                          _showChart = value;
                        });
                      },
                    ),
                  ],
                ),*/
            if (_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 0.6 : 0.3),
                child: Chart(
                  _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandScape)
              SizedBox(
                height: availableHeight * (isLandScape ? 1 : 0.7),
                child: Transaction_list(
                  _transaction,
                  _deleteTransaction,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Despesas Pessoais'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? SizedBox()
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(
                      Icons.add,
                      size: 50,
                    ),
                    backgroundColor: Colors.green[100],
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
