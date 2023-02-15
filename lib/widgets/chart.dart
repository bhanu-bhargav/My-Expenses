import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {

  List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get getGroupedTransactionValues{
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      
      for(var i =0; i<recentTransaction.length; i++){

        if(recentTransaction[i].date.day == weekDay.day &&
           recentTransaction[i].date.month == weekDay.month &&
           recentTransaction[i].date.year == weekDay.year){

            totalSum += recentTransaction[i].amount;
           }
      }
      return{'day': DateFormat.E().format(weekDay).substring(0,1), 'amount': totalSum};
    }).reversed.toList();
  }
  double get maxSpending{
    return getGroupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 43, 42, 42),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: getGroupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'].toString(), 
                data['amount'] as double,
                maxSpending == 0.0 ? 0.0: (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}