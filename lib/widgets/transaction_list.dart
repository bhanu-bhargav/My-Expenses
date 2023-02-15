import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> user_transactions;
  final Function delTx;
  TransactionList(this.user_transactions, this.delTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: user_transactions.isEmpty ? Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(
              child: Text("Not Tansaction Added Yet!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),),
            ),
          )
        ],
      ):ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            color: Color.fromARGB(255, 54, 54, 54),
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 161, 15, 246),
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FittedBox(
                    child: Text("₹:${user_transactions[index].amount}",style: TextStyle(fontWeight: FontWeight.bold,),)),
                ),
              ),
              title: Text(user_transactions[index].title, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
              subtitle: Text(DateFormat.yMMMd().format(user_transactions[index].date),style: TextStyle(color: Colors.white54)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Color.fromARGB(255, 234, 49, 74),
                onPressed: () {
                delTx(user_transactions[index].id);
              },),
            ),
          );
        },
        itemCount: user_transactions.length,
      )
          
          );
  }
}