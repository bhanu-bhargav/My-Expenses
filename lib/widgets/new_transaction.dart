
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Newtransaction extends StatefulWidget {
  
  final Function addTx;

  Newtransaction(this.addTx);

  @override
  State<Newtransaction> createState() => _NewtransactionState();
}

class _NewtransactionState extends State<Newtransaction> {
  final titlecontroller = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;


  void submitData(){
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountController.text);

    if((titlecontroller.text).isEmpty || double.parse(amountController.text) <= 0 || selectedDate == null){
      return;
      }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void datePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2023), 
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
                    primary: Color.fromARGB(255, 161, 15, 246),
                    onPrimary: Colors.white,
                    surface: Color.fromARGB(255, 161, 15, 246),
                    onSurface: Colors.white,
                    ),
                dialogBackgroundColor:Color.fromARGB(255, 43, 42, 42),
      ), 
          child: child!);
      },
      ).then((value){
        if(value == null){
          return;
        }
        setState(() {
          selectedDate = value;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        color: Color.fromARGB(255, 43, 42, 42),
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      cursorColor: Color.fromARGB(255, 161, 15, 246),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle:TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 161, 15, 246),
                          )
                        )),
                      controller: titlecontroller,
                      keyboardType: TextInputType.name,
                      
                      onSubmitted: (value) => submitData(),),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Color.fromARGB(255, 161, 15, 246),
                      decoration: InputDecoration(
                        labelText: "Amount",
                        labelStyle:TextStyle(color: Colors.white),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 161, 15, 246),
                          )
                        )),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) => submitData()),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(selectedDate == null ? "No Date Chosen!" : "Picked Date : ${DateFormat.yMMMd().format(selectedDate!)}",style:TextStyle(color: Colors.white),)),
                          TextButton(onPressed: (() {
                            datePicker();
                          }), child: Text("Choose A Date", style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 161, 15, 246)),))
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 161, 15, 246))),
                      onPressed: submitData,
                      child: Text("Add Transaction",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
            ),
    );
  }
}