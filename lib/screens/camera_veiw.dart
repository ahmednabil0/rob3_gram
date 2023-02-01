// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rob3_garam/screens/result_screen.dart';

import '../api/api_services.dart';
import '../helper/const.dart';
import '../helper/dialog.dart';

class CameraVeiw extends StatefulWidget {
  const CameraVeiw({
    Key? key,
    required this.cameras,
    required this.age,
  }) : super(key: key);
  final List<CameraDescription> cameras;
  final int age;

  @override
  State<CameraVeiw> createState() => _CameraVeiwState();
}

class _CameraVeiwState extends State<CameraVeiw> {
  late CameraController controller;
  XFile? pickedImage;
  XFile? newImage;
  int selectedCamera = 0;
  final ImagePicker _picker = ImagePicker();
  String msg = '';
  String? status = '';
  int? dgree;

  @override
  void initState() {
    controller =
        CameraController(widget.cameras[selectedCamera], ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[850]!,
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
            Container(
              height: 320.h,
              color: blackColor,
              child: !controller.value.isInitialized
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : pickedImage != null
                      ? Image.file(
                          File(
                            pickedImage!.path,
                          ),
                          fit: BoxFit.fitWidth,
                          width: double.infinity,
                        )
                      : Stack(children: <Widget>[
                          Center(
                            child: Transform.scale(
                              scale: controller.value.aspectRatio /
                                  deviceRatio *
                                  0.22,
                              child: AspectRatio(
                                aspectRatio: controller.value.aspectRatio * 0.6,
                                child: CameraPreview(controller),
                              ),
                            ),
                          ),
                        ]),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Container(
                    width: 50.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scondaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        if (pickedImage != null) {
                          pickedImage = newImage;
                        } else {
                          pickedImage = await controller.takePicture();
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        pickedImage == null
                            ? Icons.camera_alt_rounded
                            : Icons.refresh_rounded,
                        size: 30.w,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0.r),
                  child: Container(
                    width: 50.w,
                    height: 40.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: scondaryColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: IconButton(
                      onPressed: () async {
                        pickedImage = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.camera,
                        size: 30.w,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
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
                  letterSpacing: 1,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () async {
                showAlertDialog(context);
                ApiServices controller = ApiServices();
                String i = await controller.upload(
                  File(pickedImage!.path),
                  widget.age,
                );
                Navigator.of(context).pop();
                if (i != 'null') {
                  Map valueMap = jsonDecode(i);
                  if (valueMap.containsKey('error')) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        Val: 0,
                        msg: valueMap['error'],
                      ),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        Val: double.parse(valueMap['Horizontal Diameter']),
                        status: valueMap['status'],
                      ),
                    ));
                  }
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ResultScreen(
                      Val: 0,
                    ),
                  ));
                }
              },
              child: AnimatedContainer(
                duration: const Duration(microseconds: 1000),
                width: 100.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: pickedImage == null ? scondaryColor : thirdColor,
                  borderRadius: BorderRadius.circular(7.r),
                ),
                child: Text(
                  'Result',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: pickedImage == null
                        ? Colors.grey.withOpacity(0.8)
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
          ],
        ),
      ),
    );
  }
}
