// import 'package:chakravyuh/pages/location.dart';
// import 'package:flutter/material.dart';

// class BirthTime extends StatefulWidget {
//   const BirthTime({super.key});

//   @override
//   _BirthTimeState createState() => _BirthTimeState();
// }

// class _BirthTimeState extends State<BirthTime> {
//   int selectedHour = 1;
//   int selectedMinute = 0;
//   String selectedPeriod = 'AM';

//   final List<int> hours = List<int>.generate(12, (index) => index + 1);
//   final List<int> minutes = List<int>.generate(60, (index) => index);
//   final List<String> periods = ['AM', 'PM'];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Select Your TOB"),
//         backgroundColor: Color(0xFF071223),
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: RadialGradient(
//             colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//             center: Alignment.center,
//             radius: 0.5,
//           ),
//         ),
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset('assets/images/Theme-img.png', height: 200),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'At What Time Were You Born?',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 31,
//                     color: Color.fromARGB(255, 126, 172, 196),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 const Text(
//                   'Unlock your cosmic destiny by selecting the time you were born.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _buildPicker(
//                             title: 'Hour',
//                             itemCount: hours.length,
//                             selectedIndex: selectedHour - 1,
//                             onItemChanged: (index) =>
//                                 setState(() => selectedHour = hours[index]),
//                           ),
//                           const SizedBox(width: 36),
//                           _buildPicker(
//                             title: 'Minute',
//                             itemCount: minutes.length,
//                             selectedIndex: selectedMinute,
//                             onItemChanged: (index) =>
//                                 setState(() => selectedMinute = minutes[index]),
//                           ),
//                           const SizedBox(width: 36),
//                           _buildPicker(
//                             title: 'Period',
//                             itemCount: periods.length,
//                             selectedIndex: selectedPeriod == 'AM' ? 0 : 1,
//                             onItemChanged: (index) =>
//                                 setState(() => selectedPeriod = periods[index]),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 36),
//                       Text(
//                         'Selected Time: ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 23,
//                         ),
//                       ),
//                       const SizedBox(height: 26),

//                       // Next button
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigate to the next screen
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LocationPage()),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color.fromARGB(
//                               255, 25, 57, 82), // Button color
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 30, vertical: 10),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           minimumSize: const Size(double.infinity, 30),
//                         ),
//                         child: const Text(
//                           'Next',
//                           style: TextStyle(
//                             fontFamily: 'ShantellSans',
//                             fontSize: 23,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPicker({
//     required String title,
//     required int itemCount,
//     required int selectedIndex,
//     required ValueChanged<int> onItemChanged,
//   }) {
//     return Column(
//       children: [
//         Text(
//           title,
//           style: const TextStyle(color: Colors.white, fontSize: 18),
//         ),
//         SizedBox(
//           height: 150,
//           width: 70,
//           child: ListWheelScrollView.useDelegate(
//             physics: const FixedExtentScrollPhysics(),
//             controller: FixedExtentScrollController(initialItem: selectedIndex),
//             itemExtent: 40,
//             onSelectedItemChanged: onItemChanged,
//             childDelegate: ListWheelChildBuilderDelegate(
//               builder: (context, index) => Center(
//                 child: Text(
//                   title == 'Period'
//                       ? periods[index]
//                       : '${(title == 'Hour' ? hours[index] : minutes[index]).toString().padLeft(2, '0')}',
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//               childCount: itemCount,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:chakravyuh/models/birth_details.dart';
import 'package:chakravyuh/pages/location.dart';
import 'package:flutter/material.dart';

class BirthTime extends StatefulWidget {
  const BirthTime({super.key, required this.birthDetails});
  final BirthDetails birthDetails;

  @override
  _BirthTimeState createState() => _BirthTimeState();
}

class _BirthTimeState extends State<BirthTime> {
  late BirthDetails birthDetails;

  @override
  void initState() {
    super.initState();
    // Copy of the received birthDetails to update later
    birthDetails = widget.birthDetails;
  }

  int selectedHour = 1;
  int selectedMinute = 0;
  String selectedPeriod = 'AM';

  final List<int> hours = List<int>.generate(24, (index) => index + 1);
  final List<int> minutes = List<int>.generate(60, (index) => index);
  final List<String> periods = ['AM', 'PM'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your TOB"),
        backgroundColor: Color(0xFF071223),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  Image.asset('assets/images/time.png', height: 200),
                  const SizedBox(height: 10),
                  const Text(
                    'At What Time Were You Born?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 31,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Unlock your cosmic destiny by selecting the time you were born.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPicker(
                              title: 'Hour',
                              itemCount: hours.length,
                              selectedIndex: selectedHour - 1,
                              onItemChanged: (index) =>
                                  setState(() => selectedHour = hours[index]),
                            ),
                            const SizedBox(width: 36),
                            _buildPicker(
                              title: 'Minute',
                              itemCount: minutes.length,
                              selectedIndex: selectedMinute,
                              onItemChanged: (index) => setState(
                                  () => selectedMinute = minutes[index]),
                            ),
                            const SizedBox(width: 36),
                            _buildPicker(
                              title: 'Period',
                              itemCount: periods.length,
                              selectedIndex: selectedPeriod == 'AM' ? 0 : 1,
                              onItemChanged: (index) => setState(
                                  () => selectedPeriod = periods[index]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 36),
                        Text(
                          'Selected Time: ${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')} $selectedPeriod',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                          ),
                        ),
                        const SizedBox(height: 26),

                        // Next button
                        ElevatedButton(
                          onPressed: () {
                            final updatedDetails = birthDetails.copyWith(
                              birthTime: TimeOfDay(
                                  hour: selectedHour, minute: selectedMinute),
                            );
                            // Navigate to the next screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationPage(
                                      birthDetails: updatedDetails)),
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

        Container(
          height: 4,
          width: 60, // Adjust width to match the title width
          color: Colors.white.withOpacity(0.4), // Light line color
        ),
        const SizedBox(height: 5), // Space between title and line
        SizedBox(
          height: 150,
          width: 70,
          child: ListWheelScrollView.useDelegate(
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: selectedIndex),
            itemExtent: 40,
            onSelectedItemChanged: onItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final bool isSelected = index == selectedIndex;
                return Center(
                  child: Text(
                    title == 'Period'
                        ? periods[index]
                        : '${(title == 'Hour' ? hours[index] : minutes[index]).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: isSelected ? Color(0xFFF1A7C4) : Colors.white70,
                      fontSize: isSelected ? 20 : 16,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
              childCount: itemCount,
            ),
          ),
        ),
      ],
    );
  }
}
