import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/chart.dart';
import '/widgets/transaction_list.dart';
import '/widgets/new_transaction.dart';
import 'models/transaction.dart';



void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp
  //   ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
  //   Transaction(
  //       id: 'id1', title: 'New Shoes', amount: 400, date: DateTime.now()),
  //   Transaction(
  //       id: 'id2', title: 'Groceries', amount: 100, date: DateTime.now()),
  ];

  bool showChart = false;

  List<Transaction> get recentTransaction{
    return transactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void addNewTransaction(String Title, double Amount, DateTime dateSelected){
    var newTx = Transaction(
      id: DateTime.now().toString(), 
      title: Title, 
      amount: Amount, 
      date: dateSelected);

      setState(() {
        transactions.add(newTx);
      });
  }

  void startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      backgroundColor:Color.fromARGB(255, 43, 42, 42),
      builder: (_){
      return Newtransaction(addNewTransaction);
    });
  }

  void deleteTransaction(String id){
    setState(() {
      return transactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {

    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    
    final appBar = AppBar(
        actions: [
          Platform.isIOS ? 
          IconButton(onPressed: () {
            startAddNewTransaction(context);
          }, 
          icon: Icon(Icons.add, color: Colors.white,)) : 
          Container(),
        ],
        backgroundColor:Color.fromARGB(255, 161, 15, 246) ,
        title: Text("My Expenses"),
      );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              if(isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart",style: TextStyle(color: Colors.white),),
                  Switch.adaptive(
                    inactiveTrackColor: Colors.grey,
                    activeColor: Color.fromARGB(255, 161, 15, 246),
                    value: showChart, 
                    onChanged: ((val) {
                    setState(() {
                      showChart = val;
                    });
                  }))
                ],
              ),

              if(!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height - MediaQuery.of(context).padding.top)* 0.3,
                child: Chart(recentTransaction)),

              if(!isLandscape)
              Container(
                height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                child: TransactionList(transactions,deleteTransaction)),
                
              if(isLandscape)showChart
              ? Container(
                height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height - MediaQuery.of(context).padding.top)* 0.6,
                child: Chart(recentTransaction))
                
              : Container(
                height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
                child: TransactionList(transactions,deleteTransaction)),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS?Container():
         FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 161, 15, 246),
          child: Icon(Icons.add),
          onPressed: () {
            startAddNewTransaction(context);
          },
        ),
      ),
    );
  }
}
