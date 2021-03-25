import 'package:flutter/material.dart';
import 'package:login_bloc/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${bloc.emailValue}'),
          Divider(),
          Text('${bloc.passwordValue}'),
        ],
      ),
    );
  }
}
