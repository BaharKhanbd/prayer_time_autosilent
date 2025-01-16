// Edit Page
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final Map<String, String> prayer;

  const EditPage({super.key, required this.prayer});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  @override
  void initState() {
    super.initState();
    startTime = TimeOfDay(hour: 5, minute: 30); // Default start time
    endTime = TimeOfDay(hour: 6, minute: 30); // Default end time
  }

  Duration _calculateDuration() {
    final start = DateTime(0, 0, 0, startTime.hour, startTime.minute);
    final end = DateTime(0, 0, 0, endTime.hour, endTime.minute);
    return end.difference(start);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.prayer['name']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Start Time'),
              trailing: TextButton(
                child: Text('${startTime.format(context)}'),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: startTime,
                  );
                  if (picked != null) {
                    setState(() {
                      startTime = picked;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: Text('End Time'),
              trailing: TextButton(
                child: Text('${endTime.format(context)}'),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: endTime,
                  );
                  if (picked != null) {
                    setState(() {
                      endTime = picked;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Direction: ${_calculateDuration().inHours}:${_calculateDuration().inMinutes % 60} h',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save updated times logic
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
