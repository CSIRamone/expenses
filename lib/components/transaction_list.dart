import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transaction_list extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  Transaction_list(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/imagens/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
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
                      trailing: MediaQuery.of(context).size.width > 430
                          ? TextButton.icon(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade400,
                              ),
                              label: Text(
                                'Excluir',
                                style: TextStyle(
                                  color: Colors.red.shade400,
                                ),
                              ),
                              onPressed: () => onRemove(tr.id),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Colors.red.shade200,
                              onPressed: () => onRemove(tr.id),
                            ),
                    ),
                  );
                },
              ));
  }
}
