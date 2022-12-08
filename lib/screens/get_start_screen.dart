import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rob3_garam/helper/const.dart';
import 'package:rob3_garam/helper/data/get_started_data.dart';
import 'package:rob3_garam/screens/fill_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GetStratedScreen extends StatefulWidget {
  const GetStratedScreen({super.key});

  @override
  State<GetStratedScreen> createState() => _GetStratedScreenState();
}

class _GetStratedScreenState extends State<GetStratedScreen> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
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
            SizedBox(
              height: 400.h,
              child: CarouselSlider.builder(
                itemCount: AppData.data.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Column(
                  children: [
                    SizedBox(
                      height: 80.h,
                    ),
                    Image.asset(
                      AppData.data[itemIndex]['img'],
                      height: 150.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.r),
                      child: Text(
                        AppData.data[itemIndex]['des'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: 18.sp, height: 1.35),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    activeIndex = index;
                    setState(() {});
                  },
                  height: 700.h,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  pauseAutoPlayInFiniteScroll: true,
                  // scrollPhysics: const NeverScrollableScrollPhysics(),
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 1300),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: AppData.data.length,
              effect: WormEffect(
                activeDotColor: whiteColor,
                dotHeight: 12.h,
                dotWidth: 12.h,
                spacing: 8.r,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            InkWell(
              onTap: () {
                if (activeIndex == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FillData(),
                  ));
                } else {
                  activeIndex = 1;
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                width: activeIndex == 0 ? 150.w : 100.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: activeIndex == 0 ? scondaryColor : thirdColor,
                  borderRadius:
                      BorderRadius.circular(activeIndex == 0 ? 15.r : 7.r),
                ),
                child: Text(
                  activeIndex == 0 ? '1/4 Gram' : 'Start',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: activeIndex == 0 ? Colors.grey : Colors.white,
                    fontWeight:
                        activeIndex == 0 ? FontWeight.bold : FontWeight.w400,
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
