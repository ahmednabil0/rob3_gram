import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rob3_garam/helper/const.dart';
import 'package:rob3_garam/screens/camera_veiw.dart';

class FillData extends StatefulWidget {
  const FillData({super.key});

  @override
  State<FillData> createState() => _FillDataState();
}

class _FillDataState extends State<FillData> {
  int? _value;
  int? _value2;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.grey[900]!,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/images/logo_no.png',
          height: 30.h,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 45.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17.r),
              child: Text(
                'Please FIll in The datails Below So That We Can Get In Correct Result',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 1.r),
              decoration: BoxDecoration(
                color: scondaryColor,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: _value,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "Male",
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        "Female",
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value = value!;
                    });
                  },
                  hint: Text(
                    "Gender",
                    style: TextStyle(
                      color: whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Container(
              width: 300.w,
              padding: EdgeInsets.symmetric(horizontal: 15.r, vertical: 1.r),
              decoration: BoxDecoration(
                color: scondaryColor,
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  underline: const Divider(
                    color: whiteColor,
                    height: 10,
                  ),
                  value: _value2,
                  items: const [
                    DropdownMenuItem(
                      value: 1,
                      child: Text(
                        "20:40",
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text(
                        "40:60",
                      ),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text(
                        "60:80",
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      _value2 = value!;
                    });
                  },
                  hint: Text(
                    "Age",
                    style: TextStyle(
                      color: whiteColor.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 18.sp,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              error,
              style: TextStyle(
                color: errorColor,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(
              height: 160.h,
            ),
            InkWell(
              onTap: () async {
                if (_value == null && _value2 == null) {
                  error = 'Required, enter your data';
                  setState(() {});
                } else {
                  error = '';
                  setState(() {});
                  await availableCameras().then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CameraVeiw(cameras: value),
                      ),
                    );
                  });
                }
              },
              child: Container(
                width: 100.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: thirdColor,
                    borderRadius: BorderRadius.circular(5.r)),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20.sp,
                    height: 1.35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
