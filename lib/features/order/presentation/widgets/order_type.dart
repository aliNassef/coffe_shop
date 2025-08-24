import 'package:flutter/material.dart';

import 'delevery_or_pick_up.dart';

class OrderType extends StatefulWidget {
  const OrderType({super.key});

  @override
  State<OrderType> createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {
  List<String> orderTypes = ['Delivery', 'Pick Up'];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          child: DeleveryOrPickUp(
            title: orderTypes[0],
            isSelected: _selectedIndex == 0,
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: DeleveryOrPickUp(
            title: orderTypes[1],
            isSelected: _selectedIndex == 1,
          ),
        ),
      ],
    );
  }
}
