// dependencies:
//   flutter:
//     sdk: flutter
//   provider: ^6.0.5
//   shared_preferences: ^2.1.0
//   android_alarm_manager_plus: ^2.0.7
//   flutter_local_notifications: ^13.0.0

// Step 1: ডাটাবেস ও স্টেট ম্যানেজমেন্ট (Shared Preferences + Provider)
// PrayerTime Model:

// class PrayerTime {
//   final String name;
//   final String startTime;
//   final String endTime;

//   PrayerTime({
//     required this.name,
//     required this.startTime,
//     required this.endTime,
//   });

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'startTime': startTime,
//         'endTime': endTime,
//       };

//   factory PrayerTime.fromJson(Map<String, dynamic> json) {
//     return PrayerTime(
//       name: json['name'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//     );
//   }
// }


// PrayerTimeProvider:


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'prayer_time.dart';

// class PrayerTimeProvider extends ChangeNotifier {
//   List<PrayerTime> _prayerTimes = [];

//   List<PrayerTime> get prayerTimes => _prayerTimes;

//   Future<void> loadPrayerTimes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? data = prefs.getString('prayerTimes');
//     if (data != null) {
//       List<dynamic> jsonData = json.decode(data);
//       _prayerTimes = jsonData.map((e) => PrayerTime.fromJson(e)).toList();
//       notifyListeners();
//     }
//   }

//   Future<void> savePrayerTime(PrayerTime prayerTime) async {
//     int index = _prayerTimes.indexWhere((p) => p.name == prayerTime.name);
//     if (index != -1) {
//       _prayerTimes[index] = prayerTime;
//     } else {
//       _prayerTimes.add(prayerTime);
//     }
//     await _saveToPreferences();
//     notifyListeners();
//   }

//   Future<void> _saveToPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String data = json.encode(_prayerTimes.map((e) => e.toJson()).toList());
//     prefs.setString('prayerTimes', data);
//   }
// }


// আপনি যদি Shared Preferences, Provider, android_alarm_manager_plus, এবং flutter_local_notifications ব্যবহার করতে চান, তাহলে এর মাধ্যমে একটি শক্তিশালী এবং কার্যকরী সমাধান তৈরি করা সম্ভব। নিচে ধাপে ধাপে ব্যাখ্যা করছি কীভাবে এই টুলগুলো ব্যবহার করবেন।

// প্রোজেক্ট সেটআপ
// প্রয়োজনীয় প্যাকেজ ইনস্টল করুন:

// yaml
// Copy code
// dependencies:
//   flutter:
//     sdk: flutter
//   provider: ^6.0.5
//   shared_preferences: ^2.1.0
//   android_alarm_manager_plus: ^2.0.7
//   flutter_local_notifications: ^13.0.0
// ডিজাইন ও ফাংশনালিটি বাস্তবায়ন
// Step 1: ডাটাবেস ও স্টেট ম্যানেজমেন্ট (Shared Preferences + Provider)
// PrayerTime Model:
// dart
// Copy code
// class PrayerTime {
//   final String name;
//   final String startTime;
//   final String endTime;

//   PrayerTime({
//     required this.name,
//     required this.startTime,
//     required this.endTime,
//   });

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'startTime': startTime,
//         'endTime': endTime,
//       };

//   factory PrayerTime.fromJson(Map<String, dynamic> json) {
//     return PrayerTime(
//       name: json['name'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//     );
//   }
// }
// PrayerTimeProvider:
// dart
// Copy code
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'prayer_time.dart';

// class PrayerTimeProvider extends ChangeNotifier {
//   List<PrayerTime> _prayerTimes = [];

//   List<PrayerTime> get prayerTimes => _prayerTimes;

//   Future<void> loadPrayerTimes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? data = prefs.getString('prayerTimes');
//     if (data != null) {
//       List<dynamic> jsonData = json.decode(data);
//       _prayerTimes = jsonData.map((e) => PrayerTime.fromJson(e)).toList();
//       notifyListeners();
//     }
//   }

//   Future<void> savePrayerTime(PrayerTime prayerTime) async {
//     int index = _prayerTimes.indexWhere((p) => p.name == prayerTime.name);
//     if (index != -1) {
//       _prayerTimes[index] = prayerTime;
//     } else {
//       _prayerTimes.add(prayerTime);
//     }
//     await _saveToPreferences();
//     notifyListeners();
//   }

//   Future<void> _saveToPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String data = json.encode(_prayerTimes.map((e) => e.toJson()).toList());
//     prefs.setString('prayerTimes', data);
//   }
// }


// Step 2: Home Page Design

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Prayer Time Auto Silent')),
//       body: Consumer<PrayerTimeProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             itemCount: provider.prayerTimes.length,
//             itemBuilder: (context, index) {
//               final prayer = provider.prayerTimes[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(prayer.name),
//                   subtitle: Text(
//                       'Start: ${prayer.startTime}, End: ${prayer.endTime}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditPage(prayer: prayer),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditPage(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// আপনি যদি Shared Preferences, Provider, android_alarm_manager_plus, এবং flutter_local_notifications ব্যবহার করতে চান, তাহলে এর মাধ্যমে একটি শক্তিশালী এবং কার্যকরী সমাধান তৈরি করা সম্ভব। নিচে ধাপে ধাপে ব্যাখ্যা করছি কীভাবে এই টুলগুলো ব্যবহার করবেন।

// প্রোজেক্ট সেটআপ
// প্রয়োজনীয় প্যাকেজ ইনস্টল করুন:

// yaml
// Copy code
// dependencies:
//   flutter:
//     sdk: flutter
//   provider: ^6.0.5
//   shared_preferences: ^2.1.0
//   android_alarm_manager_plus: ^2.0.7
//   flutter_local_notifications: ^13.0.0
// ডিজাইন ও ফাংশনালিটি বাস্তবায়ন
// Step 1: ডাটাবেস ও স্টেট ম্যানেজমেন্ট (Shared Preferences + Provider)
// PrayerTime Model:
// dart
// Copy code
// class PrayerTime {
//   final String name;
//   final String startTime;
//   final String endTime;

//   PrayerTime({
//     required this.name,
//     required this.startTime,
//     required this.endTime,
//   });

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'startTime': startTime,
//         'endTime': endTime,
//       };

//   factory PrayerTime.fromJson(Map<String, dynamic> json) {
//     return PrayerTime(
//       name: json['name'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//     );
//   }
// }
// PrayerTimeProvider:
// dart
// Copy code
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'prayer_time.dart';

// class PrayerTimeProvider extends ChangeNotifier {
//   List<PrayerTime> _prayerTimes = [];

//   List<PrayerTime> get prayerTimes => _prayerTimes;

//   Future<void> loadPrayerTimes() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? data = prefs.getString('prayerTimes');
//     if (data != null) {
//       List<dynamic> jsonData = json.decode(data);
//       _prayerTimes = jsonData.map((e) => PrayerTime.fromJson(e)).toList();
//       notifyListeners();
//     }
//   }

//   Future<void> savePrayerTime(PrayerTime prayerTime) async {
//     int index = _prayerTimes.indexWhere((p) => p.name == prayerTime.name);
//     if (index != -1) {
//       _prayerTimes[index] = prayerTime;
//     } else {
//       _prayerTimes.add(prayerTime);
//     }
//     await _saveToPreferences();
//     notifyListeners();
//   }

//   Future<void> _saveToPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String data = json.encode(_prayerTimes.map((e) => e.toJson()).toList());
//     prefs.setString('prayerTimes', data);
//   }
// }
// Step 2: Home Page Design
// dart
// Copy code
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Prayer Time Auto Silent')),
//       body: Consumer<PrayerTimeProvider>(
//         builder: (context, provider, child) {
//           return ListView.builder(
//             itemCount: provider.prayerTimes.length,
//             itemBuilder: (context, index) {
//               final prayer = provider.prayerTimes[index];
//               return Card(
//                 child: ListTile(
//                   title: Text(prayer.name),
//                   subtitle: Text(
//                       'Start: ${prayer.startTime}, End: ${prayer.endTime}'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EditPage(prayer: prayer),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => EditPage(),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// Step 3: Edit Page Design

// class EditPage extends StatefulWidget {
//   final PrayerTime? prayer;

//   EditPage({this.prayer});

//   @override
//   _EditPageState createState() => _EditPageState();
// }

// class _EditPageState extends State<EditPage> {
//   late TextEditingController _startController;
//   late TextEditingController _endController;

//   @override
//   void initState() {
//     super.initState();
//     _startController =
//         TextEditingController(text: widget.prayer?.startTime ?? '');
//     _endController =
//         TextEditingController(text: widget.prayer?.endTime ?? '');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Prayer Time')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _startController,
//               decoration: InputDecoration(labelText: 'Start Time'),
//               onTap: () async {
//                 TimeOfDay? time = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (time != null) {
//                   _startController.text = time.format(context);
//                 }
//               },
//             ),
//             TextField(
//               controller: _endController,
//               decoration: InputDecoration(labelText: 'End Time'),
//               onTap: () async {
//                 TimeOfDay? time = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (time != null) {
//                   _endController.text = time.format(context);
//                 }
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 if (_startController.text.isNotEmpty &&
//                     _endController.text.isNotEmpty) {
//                   final prayer = PrayerTime(
//                     name: widget.prayer?.name ?? 'New Prayer',
//                     startTime: _startController.text,
//                     endTime: _endController.text,
//                   );
//                   Provider.of<PrayerTimeProvider>(context, listen: false)
//                       .savePrayerTime(prayer);
//                   Navigator.pop(context);
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// Step 4: অটো সাইলেন্ট ও নোটিফিকেশন (android_alarm_manager_plus)
// Silent Mode:

// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// void silentModeTask() {
//   // Silent mode চালু করতে নেটিভ কোড ব্যবহার করুন।
//   print('Silent Mode ON');
// }

// void normalModeTask() {
//   // Normal mode চালু করতে নেটিভ কোড ব্যবহার করুন।
//   print('Silent Mode OFF');
// }


// Alarm Manager সেটআপ:

// void setAlarm(DateTime time, Function callback) {
//   AndroidAlarmManager.oneShotAt(
//     time,
//     // Unique alarm ID
//     time.millisecondsSinceEpoch,
//     callback,
//   );
// }


// Step 5: Notification System (flutter_local_notifications)

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// void showNotification(String title, String body) {
//   flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     NotificationDetails(
//       android: AndroidNotificationDetails(
//         'prayer_channel',
//         'Prayer Notifications',
//         importance: Importance.max,
//         priority: Priority.high,
//       ),
//     ),
//   );
// }
