import 'package:flutter/material.dart';


class ChartBar extends StatelessWidget {

  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label,this.spendingAmount,this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, Constraints) {
      return Column(
      children: [
        Container(
          height: Constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text('₹${spendingAmount.toStringAsFixed(0)}',style: TextStyle(color: Colors.white),)),
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.05,
        ),
        Container(
          height: Constraints.maxHeight * 0.6,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromARGB(255, 183, 182, 182),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 161, 15, 246),
                    borderRadius: BorderRadius.circular(10)),
                    
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: Constraints.maxHeight * 0.05,
          ),
        Container(
          height: Constraints.maxHeight * 0.15,
          child: FittedBox(
            child: Text(label,style: TextStyle(color: Colors.white)))),
      ],
    );
    }); 
  }
}