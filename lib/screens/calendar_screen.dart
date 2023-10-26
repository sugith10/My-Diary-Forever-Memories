
import 'package:diary/screens/create_page.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CalendarScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

 

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    DateFormat('d MMMM,y').format(today),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Ionicons.chevron_down_outline,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 0.1,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 237, 237, 237),
              child: Container(
                color: Color.fromARGB(255, 237, 237, 237),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: TableCalendar(
                  headerStyle: HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  firstDay: DateTime(2000, 10, 1),
                  lastDay: DateTime(2025, 12, 31),
                  focusedDay: today,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                  weekendDays: [DateTime.sunday],
                  onDaySelected: _onDaySelected,
                ),
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePage(selectedDate: today),
                            ),
                          );
                        },
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Start writing about your day...',
                              style: TextStyle(
                                color: Color.fromARGB(255, 31, 31, 31),
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Click this text to create your personal diary',
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget customIcon() {
  return Image.asset(
    'images/start_writing.png',
    width: 64, 
    height: 64,
  );
}
