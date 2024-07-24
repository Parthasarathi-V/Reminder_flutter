import 'package:flutter/material.dart';

class summa extends StatefulWidget {

  @override
  State<summa> createState() => _summaState();
}

class _summaState extends State<summa> {
  bool imp = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    print(h);
    print(w);
    return Scaffold(
      appBar: AppBar(toolbarHeight: 100, backgroundColor: Colors.blue.shade500,),
      body: Center(
        child: Checkbox(value: imp,onChanged: (val) {
          setState(() {
            imp = val!;
          });
        },)
      ),
    );
  }
}
