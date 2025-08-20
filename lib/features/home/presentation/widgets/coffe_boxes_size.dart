import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'size_cofffe_box.dart';

class CoffeBoxesSize extends StatefulWidget {
  const CoffeBoxesSize({super.key, this.onSizeSelected});
  final ValueChanged<String>? onSizeSelected;
  @override
  State<CoffeBoxesSize> createState() => _CoffeBoxesSizeState();
}

class _CoffeBoxesSizeState extends State<CoffeBoxesSize> {
  int _currentIndex = 1;
  List<String> sizes = ['S', 'M', 'L'];
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: List.generate(3, (index) {
        return Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
              });
              if (widget.onSizeSelected != null) {
                widget.onSizeSelected!(sizes[index]);
              }
            },
            child: SizeCoffeBox(
              text: sizes[index],
              isSelected: _currentIndex == index,
            ),
          ),
        );
      }),
    );
  }
}
