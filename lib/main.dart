import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
 void main() => runApp(MaterialApp(
   home : MyApp(),
 ));

 class MyApp extends StatefulWidget {
   const MyApp({Key? key}) : super(key: key);

   @override
   _MyAppState createState() => _MyAppState();
 }
//simple dialog
 enum Answers{Yes,No,MAYBE}

 class _MyAppState extends State<MyApp> {
   //bottomsheet
   void _showBottom(){
     showModalBottomSheet<void>(
         context: context,
         builder:(BuildContext context){
           return Container(
             padding: EdgeInsets.all(15.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Text('Some Info Here',
                 style: TextStyle(
                   color: Colors.red,
                   fontWeight: FontWeight.bold,
                 ),
                 ),
                 ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('Close'),),
               ],
             ),
           );
         }
     );
   }

   //Snackbar
   final GlobalKey<ScaffoldState> _scaffoldstate = GlobalKey<ScaffoldState>();

   void showbar() {
     _scaffoldstate.currentState!.showSnackBar(SnackBar(content:Text('Hello World'),));
   }

   Future _showAlert(BuildContext context,String message) async {
     return showDialog(context: context, builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: Text(message),
            actions: <Widget>[
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
            ],
          ),
        );
     }  );
   }
String _value = '';
   void setValue(String value) => setState(() => _value =value);

   Future _askUser() async{
     switch(
     await showDialog(context: context, builder: (BuildContext context){
       return Container(
         child: SimpleDialog(
           title: Text('Do you like Flutter'),
           children: <Widget>[
             SimpleDialogOption(child: Text('Yes'),onPressed: () {Navigator.pop(context, Answers.Yes);},),
             SimpleDialogOption(child: Text('No'),onPressed: () {Navigator.pop(context,Answers.No);},),
             SimpleDialogOption(child: Text('Maybe'),onPressed: () {Navigator.pop(context,Answers.MAYBE);},),

           ],


         ),
       );
     })
     ) {
       case Answers.Yes:
         setValue('YES');
         break;
       case Answers.No:
         setValue('NO');
         break;
       case Answers.MAYBE:
         setValue('MAYBE');
         break;
     }
   }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       key: _scaffoldstate,
       appBar: AppBar(
         title: Text('Hello World'),

       ),
       body: Container(
         padding: EdgeInsets.all(32.0),
         child: Center(
           child: Column(
             children: <Widget>[
               Text('Add Widget Here'),
               SizedBox(height: 30.0),
               Text(_value),
               SizedBox(height: 30.0),
               ElevatedButton(onPressed: _showBottom, child: Text('Click Me')),
               SizedBox(height: 30.0),
               ElevatedButton(onPressed: showbar, child: Text('Click Me')),
               SizedBox(height: 30.0),
               ElevatedButton(onPressed: () => _showAlert(context, 'Do you like Flutter,I do'), child: Text('Click Me')),
               SizedBox(height: 30.0),
               ElevatedButton(onPressed: _askUser, child: Text('Click ME')),

             ],
           ),
         ),
       ),
     );
   }
 }
