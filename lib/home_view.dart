import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prayer_time_autosilent/edit_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final prayerTimes = [
    {'name': 'Fajr', 'start': '5:00 AM', 'end': '6:30 AM'},
    {'name': 'Dhuhr', 'start': '12:00 PM', 'end': '1:30 PM'},
    {'name': 'Asr', 'start': '4:00 PM', 'end': '5:30 PM'},
    {'name': 'Maghrib', 'start': '6:00 PM', 'end': '7:30 PM'},
    {'name': 'Isha', 'start': '8:00 PM', 'end': '9:30 PM'},
  ];

  String _calculateNextPrayer() {
    // Example logic to calculate time left for next prayer
    DateTime now = DateTime.now();
    DateTime nextPrayerTime =
        DateTime(now.year, now.month, now.day, 5, 0); // Example: Fajr
    Duration difference = nextPrayerTime.difference(now);
    return difference.inMinutes > 0
        ? '${difference.inHours} hours ${difference.inMinutes % 60} minutes left'
        : 'Prayer time passed';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Islamic App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Next Prayer: ${_calculateNextPrayer()}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Date: ${DateFormat('dd - EEE').format(DateTime.now())}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prayerTimes.length,
              itemBuilder: (context, index) {
                final prayer = prayerTimes[index];
                return Card(
                  child: ListTile(
                    title: Text(prayer['name']!),
                    subtitle: Text('${prayer['start']} - ${prayer['end']}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(prayer: prayer),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
