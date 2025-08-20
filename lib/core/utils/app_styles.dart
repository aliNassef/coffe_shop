import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle _createStyle({
    required String fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.getFont(
      fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static final regular20 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );
  static final regular22 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 22,
    fontWeight: FontWeight.w400,
  );
  static final regular16 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );
  static final regular14 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static final regular12 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final regular10 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );
  static final regular8 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 8,
    fontWeight: FontWeight.w400,
  );
  static final semiBold16 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static final semiBold24 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );
  static final semiBold14 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static final semiBold12 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static final semiBold10 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
  static final semiBold8 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 8,
    fontWeight: FontWeight.w600,
  );

  static final bold16 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static final bold20 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );
  static final bold24 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
  static final bold14 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final bold12 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static final bold10 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 10,
    fontWeight: FontWeight.w700,
  );
  static final bold8 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 8,
    fontWeight: FontWeight.w700,
  );

  static final medium16 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static final medium14 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static final medium12 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );
  static final medium10 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static final medium8 = _createStyle(
    fontFamily: 'Sora',
    fontSize: 8,
    fontWeight: FontWeight.w500,
  );
}
