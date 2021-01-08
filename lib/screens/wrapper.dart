import 'package:flutter/material.dart';
import 'package:imd/screens/authenticate/authenticate.dart';
import 'package:imd/models/user.dart';
import 'package:provider/provider.dart';

import 'bottom tabs/tabspage.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);

    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Tabs();
    }
  }
}
