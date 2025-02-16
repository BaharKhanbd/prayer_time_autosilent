import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prayer_time_autosilent/home_view.dart';
import 'package:quickalert/quickalert.dart';

class EditViewTwo extends StatefulWidget {
  final int index;
  final TimeOfDay initialStart;
  final TimeOfDay initialEnd;
  const EditViewTwo({
    super.key,
    required this.index,
    required this.initialStart,
    required this.initialEnd,
  });

  @override
  State<EditViewTwo> createState() => _EditViewTwoState();
}

class _EditViewTwoState extends State<EditViewTwo> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  String totalDuration = "";

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStart;
    endTime = widget.initialEnd;
    totalDuration = _calculateDuration(); // Initialize duration
  }

  String _calculateDuration() {
    final start = DateTime(0, 0, 0, startTime.hour, startTime.minute);
    final end = DateTime(0, 0, 0, endTime.hour, endTime.minute);
    final duration = end.difference(start);

    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    if (hours > 0 && minutes > 0) {
      return "$hours hour $minutes minute";
    } else if (hours > 0) {
      return "$hours hour";
    } else {
      return "$minutes minute";
    }
  }

  void _updateStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
        totalDuration = _calculateDuration(); // Update duration
      });
    }
  }

  void _updateEndTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
        totalDuration = _calculateDuration(); // Update duration
      });
    }
  }

  void saveUpdatedTimes() {
    saveSilentTimes(widget.index, startTime, endTime); // Save updated times
    Navigator.pop(context, {
      'start': startTime,
      'end': endTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Pops the current screen
          },
        ),
        title: Text("Edit ${prayerNames[widget.index]}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Added padding for layout
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Time Period",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _updateStartTime,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFEAECF0),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Start",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            startTime.format(context),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w), // Space between the two containers
                Expanded(
                  child: InkWell(
                    onTap: _updateEndTime,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFEAECF0),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "End",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            endTime.format(context),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: Color(0xFFEAECF0),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text("Direction ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Text(_calculateDuration(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFEAECF0),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text("Not Now",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                InkWell(
                  onTap: () {
                    // Show success message for 3 seconds
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.success,
                      title: 'Success!',
                      text: 'Updated Successfully!',
                      showConfirmBtn: false,
                      barrierDismissible: true,
                      autoCloseDuration: const Duration(seconds: 3),
                    );

                    // Wait for 3 seconds, then call saveUpdatedTimes
                    Future.delayed(const Duration(seconds: 3), () {
                      saveUpdatedTimes();
                    });
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Color(0xFF2EC9C9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text("Update ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ))),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
