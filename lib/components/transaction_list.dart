import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transactions;

  Transaction_list(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 540,
        child: transactions.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 80),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 60),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/imagens/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent.shade700,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                              style: TextStyle(
                                color: Colors.red.shade900,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: TextStyle(
                          color: Colors.green.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y H mm ss').format(tr.date),
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  );
                },
              ));
  }
}
