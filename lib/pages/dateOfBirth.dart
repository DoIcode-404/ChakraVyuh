import 'package:chakravyuh/pages/birthTime.dart';
import 'package:flutter/material.dart';

class DateBirth extends StatefulWidget {
  const DateBirth({super.key});

  @override
  _DateBirthState createState() => _DateBirthState();
}

class _DateBirthState extends State<DateBirth> {
  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = 2023;

  final List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  int _getDaysInMonth(int month, int year) {
    if (month == 2) {
      return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
    }
    return [4, 6, 9, 11].contains(month) ? 30 : 31;
  }

  @override
  Widget build(BuildContext context) {
    final int maxDaysInMonth = _getDaysInMonth(selectedMonth, selectedYear);

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Date of Birth Selection'),
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.black,
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
            center: Alignment.center,
            radius: 0.5,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/Theme-img.png', height: 200),
                const SizedBox(height: 10),
                const Text(
                  'Set your birth date.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 31,
                    color: Color.fromARGB(255, 126, 172, 196),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your journey through the stars begins with the right date to unlock your cosmic destiny.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  // decoration: BoxDecoration(
                  //   color:
                  //       const Color.fromARGB(255, 4, 67, 103).withOpacity(0.8),
                  //   borderRadius: BorderRadius.circular(12),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.black.withOpacity(0.3),
                  //       blurRadius: 8,
                  //       offset: const Offset(0, 4),
                  //     ),
                  //   ],
                  // ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildPicker(
                            title: 'Day',
                            itemCount: maxDaysInMonth,
                            selectedIndex: selectedDay - 1,
                            onItemChanged: (index) =>
                                setState(() => selectedDay = index + 1),
                          ),
                          const SizedBox(width: 36),
                          _buildPicker(
                            title: 'Month',
                            itemCount: 12,
                            selectedIndex: selectedMonth - 1,
                            onItemChanged: (index) =>
                                setState(() => selectedMonth = index + 1),
                          ),
                          const SizedBox(width: 36),
                          _buildPicker(
                            title: 'Year',
                            itemCount: 200,
                            selectedIndex: selectedYear - 1900,
                            onItemChanged: (index) =>
                                setState(() => selectedYear = 1900 + index),
                          ),
                        ],
                      ),
                      const SizedBox(height: 36),
                      Text(
                        'Selected Date: $selectedDay/${selectedMonth.toString().padLeft(2, '0')}/$selectedYear',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 26),

                      // Next button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BirthTime()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 25, 57, 82), // Button color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(double.infinity, 30),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontFamily: 'ShantellSans',
                            fontSize: 23,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPicker({
    required String title,
    required int itemCount,
    required int selectedIndex,
    required ValueChanged<int> onItemChanged,
  }) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 150,
          width: 70,
          child: ListWheelScrollView.useDelegate(
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40,
            onSelectedItemChanged: onItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) => Center(
                child: Text(
                  title == 'Month'
                      ? monthNames[index]
                      : '${index + (title == 'Year' ? 1900 : 1)}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              childCount: itemCount,
            ),
          ),
        ),
      ],
    );
  }
}
