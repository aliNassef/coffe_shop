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
      children: List.generate(2, (index) {
        return Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: DeleveryOrPickUp(
              title: orderTypes[index],
              isSelected: _selectedIndex == index,
            ),
          ),
        );
      }),
    );
  }
}
