import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayer_time_autosilent/edit_view.dart';
import 'package:prayer_time_autosilent/edit_view_two.dart';
import 'package:prayer_time_autosilent/utilities/assets_manager.dart';
import 'package:flutter_switch/flutter_switch.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Map<String, String>> prayerTimes = [
    {"name": "Fajr", "time": "5:00 AM", "icon": "assets/images/fajr.png"},
    {"name": "Duhr", "time": "12:00 PM", "icon": "assets/images/duhr.png"},
    {"name": "Asr", "time": "3:30 PM", "icon": "assets/images/asr.png"},
    {"name": "Maghrib", "time": "6:20 PM", "icon": "assets/images/maghrib.png"},
    {"name": "Isha", "time": "8:00 PM", "icon": "assets/images/isha.png"},
  ];
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12.w, top: 12.h),
          child: Text(
            "Prayer Time",
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        leadingWidth: 160.w,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditViewTwo()),
                );
              },
              child: SvgPicture.asset(
                ImageAssets.appbarMenuIcon,
                height: 24.h,
                width: 24.w,
                color: Colors.black,
                placeholderBuilder: (BuildContext context) =>
                    Icon(Icons.error, size: 24.sp),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              Stack(
                children: [
                  // Image Section
                  Container(
                    width: double.infinity,
                    height: 140.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24.r),
                      child: Image.asset(
                        ImageAssets.bannerImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Text Section at the bottom of Image
                  Positioned(
                    bottom: 16.h, // Text positioned at the bottom
                    left: 16.w,
                    right: 16.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Maghrib at",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "06:20 PM",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "1 hour 2 min left",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Salat time",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                width: double.infinity.w,
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color.fromRGBO(246, 177, 2, 0.10),
                    width: 0.5,
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0.80),
                      Color.fromRGBO(255, 255, 255, 0.80),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromRGBO(248, 193, 53, 0.06),
                      offset: const Offset(8, 0),
                      blurRadius: 18,
                    ),
                    BoxShadow(
                      color: const Color.fromRGBO(248, 193, 53, 0.08),
                      offset: const Offset(-2, 2),
                      blurRadius: 16,
                      spreadRadius: -4,
                    ),
                    BoxShadow(
                      color: const Color.fromRGBO(0, 0, 0, 0.06),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity.w,
                  height: 96.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: prayerTimes.length,
                    itemBuilder: (context, index) {
                      final prayer = prayerTimes[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        child: Container(
                          height: 80.h,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFFFCA28),
                              width: 1,
                            ),
                            color: const Color.fromRGBO(255, 202, 40, 0.20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.r),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.r),
                                  color: Color(0xFFF2F4F7),
                                ),
                                child: Image.asset(
                                  prayer['icon']!,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                prayer['name']!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                prayer['time']!,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r)),
                  color: Color(0xFFFFF9E9),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Auto Silent",
                            style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 510.h,
                      child: ListView.builder(
                          itemCount: 5,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 8.w),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: index == 1
                                          ? Color(0xFFFFCA28)
                                          : Colors.white,
                                      width: 1,
                                    ),
                                    color: index == 1
                                        ? Color(0x33FFCA28)
                                        : Colors.white
                                    // color: Color(0x33FFCA28),
                                    // color: Colors.white
                                    ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12.h, horizontal: 8.w),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4.r),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                          color: Color(0xFFF2F4F7),
                                        ),
                                        child: Image.asset(
                                          "assets/images/duhr.png",
                                          height: 40.h,
                                          width: 40.w,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Duhr",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                            Text("04:00 PM -05:10 PM ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ]),
                                      Spacer(),
                                      FlutterSwitch(
                                        value: isSwitched,
                                        onToggle: (val) {
                                          setState(() {
                                            isSwitched = val;
                                          });
                                        },
                                        activeColor: Colors
                                            .green, // Green color when switched on
                                        inactiveColor: Colors
                                            .red, // Red color when switched off
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
