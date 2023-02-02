import 'dart:math' as math; // import this
import 'dart:ui' as ui;

import 'package:at_gauges/at_gauges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helper/const.dart';
import '../helper/dialog.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    Key? key,
    this.Val,
    this.msg,
    this.status,
  }) : super(key: key);
  final double? Val;
  final String? msg;
  final String? status;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[900]!,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo_no.png',
          height: 28.h,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            widget.Val == 0
                ? const SizedBox()
                : Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                          color: scondaryColor.withOpacity(0.5),
                          size: 45.w,
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 300.h,
              child: widget.Val == 0
                  ? Center(
                      child: Text(
                        widget.msg ?? 'No pupil detected , try agian',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff2381C1),
                          fontWeight: FontWeight.w500,
                          fontSize: 19.sp,
                          height: 1.35,
                        ),
                      ),
                    )
                  : SimpleRadialGauge(
                      actualValue: widget.Val!,

                      maxValue: 100,

                      icon: Icon(
                        widget.status == 'abnormal'
                            ? Icons.warning_rounded
                            : Icons.check,
                        color: widget.status == 'abnormal'
                            ? errorColor.withOpacity(0.6)
                            : Colors.green,
                      ),
                      // Optional Parameters
                      minValue: 0,
                      title: Text(
                        widget.status != 'abnormal' ? 'normal' : 'abnormal',
                        style: TextStyle(
                            // color: const Color(0xffD23B3B),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                widget.status != 'abnormal'
                                    ? const Offset(0, 25)
                                    : const Offset(100, 0),
                                const Offset(0, 25),
                                <Color>[
                                  const Color(0xffD23B3B),
                                  const Color(0xff2381C1),
                                ],
                              )),
                      ),
                      titlePosition: TitlePosition.bottom,
                      unit: 'mm',
                      pointerColor: widget.status != 'abnormal'
                          ? Colors.green.withOpacity(0.8)
                          : const Color(0xffD23B3B),
                      decimalPlaces: 1,
                      isAnimate: true,
                      animationDuration: 500,
                      size: 235,
                    ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.r),
              child: Text(
                'The result varies depending on \n the distance between the eye and the camera',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: const Color(0xff393939),
                    fontWeight: FontWeight.w400,
                    fontSize: 16.5.sp,
                    height: 1.35,
                    letterSpacing: 1),
              ),
            ),
            const Spacer(),
            widget.Val == 0
                ? IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.replay_outlined,
                      color: errorColor.withOpacity(0.8),
                      size: 50.w,
                    ),
                  )
                : Row(
                    children: [
                      Column(
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Icon(
                              Icons.reply_all_rounded,
                              color: const Color(0xff2381C1),
                              size: 25.w,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showdataDialog(
                                context,
                                TextEditingController(),
                                widget.Val!,
                                widget.status!,
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.r),
                              child: Text(
                                'share result',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: const Color(0xff2381C1),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
