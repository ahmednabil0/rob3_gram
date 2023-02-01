import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'const.dart';

void showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: MediaQuery.of(context).size.width / 0.5,
          height: MediaQuery.of(context).size.height / 4,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: thirdColor, width: 2),
            color: whiteColor.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Loading The Result',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: primaryColor.withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const CircularProgressIndicator(
                color: thirdColor,
              )
            ],
          ),
        ),
      );
    },
  );
}
