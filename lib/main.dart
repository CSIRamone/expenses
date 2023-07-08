import 'package:expenses/components/transaction_user.dart';

import 'package:flutter/material.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            //width: double.infinity,
            child: const Card(
              color: Colors.blueAccent,
              elevation: 8,
              child: Text('Grafico'),
            ),
          ),
          const TransactionUser(),
        ],
      ),
    );
  }
}
