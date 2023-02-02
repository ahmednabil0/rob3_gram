import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

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
                'Loading...',
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

void showdataDialog(BuildContext context, TextEditingController controller,
    double val, String status) {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  showDialog(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        scrollable: true,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Enter Name of Client",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              Form(
                key: key,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0.r),
                  child: TextFormField(
                    controller: controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name is required";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.r),
                      hintStyle: TextStyle(
                        color: primaryColor.withOpacity(0.4),
                        fontWeight: FontWeight.w600,
                        fontSize: 10.sp,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (key.currentState!.validate()) {
                    Navigator.of(context).pop();
                    Share.share(
                      '''sir ${controller.text} this is your tests  
                    status is $status and value is $val mm  by:(1/4 gram) ''',
                      subject:
                          '''this ia a drug test of sir ${controller.text} and 
                              the resuls is $status and value is $val mm
                                    created by 1/4 gram app ''',
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  width: 150.w,
                  height: 40.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: thirdColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    'share reuslt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
