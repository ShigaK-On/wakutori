import 'package:flutter/material.dart';

class NoLine extends StatelessWidget {
  const NoLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '公式LINEから開き直してください:(',
          style: TextStyle(
            color: Colors.red,
            fontSize: MediaQuery.of(context).size.width * 0.025,
          ),
        ),
      ),
    );
  }
}