import 'package:flutter/material.dart';
import 'package:imd/screens/authenticate/authenticate.dart';
import 'package:imd/models/user.dart';
import 'package:provider/provider.dart';
import 'package:imd/sevices/database.dart';
import 'package:imd/global.dart' as global;

import 'bottom tabs/tabspage.dart';

class Wrapper extends StatelessWidget {
  void initState() {
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    String email = await DatabaseService().getCurrentUser();
    global.uemail = email;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      doSomeAsyncStuff();
      return Tabs();
    }
  }
}
