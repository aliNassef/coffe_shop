import 'package:coffe_shop/core/utils/app_colors.dart';
import 'package:coffe_shop/core/utils/app_styles.dart';
import 'package:coffe_shop/features/order/presentation/views/track_order_map_view.dart';
import 'package:flutter/material.dart';

void showTopDialogWithButton(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    bool isRemoved = false;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    entry.remove();
                    isRemoved = true;
                  },
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                ),
                Expanded(
                  child: Text(
                    "Track your order",
                    style: AppStyles.semiBold24.copyWith(
                      color: AppColors.light,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (!isRemoved) {
                      entry.remove();
                      isRemoved = true;
                      Navigator.pushNamed(context, TrackOrderMapView.routeName);
                    }
                  },
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 10), () {
      if (!isRemoved) {
        entry.remove();
        isRemoved = true;
      }
    });
  });
}
