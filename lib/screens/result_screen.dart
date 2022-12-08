import 'package:at_gauges/at_gauges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rob3_garam/helper/const.dart';
import 'dart:ui' as ui;
import 'dart:math' as math; // import this

class ResultScreen extends StatefulWidget {
  const ResultScreen({required this.minVal, super.key});
  final double minVal;

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
            widget.minVal == 0
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
              height: 4.h,
            ),
            SizedBox(
              height: 300.h,
              child: widget.minVal == 0
                  ? Center(
                      child: Text(
                        'No pupil detected',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xff2381C1),
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          height: 1.35,
                        ),
                      ),
                    )
                  : SimpleRadialGauge(
                      actualValue: widget.minVal,

                      maxValue: 100,
                      icon: Icon(
                        widget.minVal > 50
                            ? Icons.warning_rounded
                            : Icons.check,
                        color: widget.minVal > 50
                            ? errorColor.withOpacity(0.6)
                            : Colors.green,
                      ),
                      // Optional Parameters
                      minValue: 0,
                      title: Text(
                        widget.minVal <= 50 ? 'normal' : 'abnormal',
                        style: TextStyle(
                            // color: const Color(0xffD23B3B),
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = ui.Gradient.linear(
                                widget.minVal <= 50
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
                      unit: '%',
                      pointerColor: widget.minVal < 50
                          ? Colors.green.withOpacity(0.8)
                          : const Color(0xffD23B3B),
                      decimalPlaces: 0,
                      isAnimate: true,
                      animationDuration: 500,
                      size: 230,
                    ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.r),
              child: Text(
                'The result may differ by \n +1 mm depend on the distance between the camera and the eye',
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
            widget.minVal == 0
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
                          Padding(
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
                        ],
                      )
                    ],
                  ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
