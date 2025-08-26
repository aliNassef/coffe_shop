import 'package:flutter/material.dart';

import '../widgets/deleivery_view_body.dart';

class DelieveryView extends StatelessWidget {
  const DelieveryView({super.key});
  static const routeName = 'delivery';

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DelieveryViewBody());
  }
}
