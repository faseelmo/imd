import 'package:flutter/material.dart';

class Account extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => Account(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
      ),
      body: Center(
        child: Text("Hello, Product!"),
      ),
    );
  }
}
