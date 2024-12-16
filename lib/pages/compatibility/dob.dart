// import 'package:chakravyuh/models/partner_details.dart';
// import 'package:flutter/material.dart';

// import '../../models/birth_details.dart';
// import 'tob.dart';

// class BirthDateCompatibility extends StatefulWidget {
//   const BirthDateCompatibility({super.key, required this.partnerDetails});
//   final PartnerDetails partnerDetails;

//   @override
//   _BirthDateCompatibilityState createState() => _BirthDateCompatibilityState();
// }

// class _BirthDateCompatibilityState extends State<BirthDateCompatibility> {
//   late PartnerDetails partnerDetails;

//   @override
//   void initState() {
//     super.initState();
//     // Copying the received PartnerDetails to update later
//     partnerDetails = widget.partnerDetails;
//   }

//   int selectedDay = 1;
//   int selectedMonth = 1;
//   int selectedYear = 2000;

//   final List<String> monthNames = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec'
//   ];

//   int _getDaysInMonth(int month, int year) {
//     if (month == 2) {
//       return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
//     }
//     return [4, 6, 9, 11].contains(month) ? 30 : 31;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int maxDaysInMonth = _getDaysInMonth(selectedMonth, selectedYear);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Select Partner's Birth Date"),
//         backgroundColor: Color(0xFF071223),
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: RadialGradient(
//               colors: [Color(0xFF1A2C5B), Color(0xFF071223)],
//               center: Alignment.center,
//               radius: 0.5,
//             ),
//           ),
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/images/date.png', height: 200),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Set your partners birth date.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 31,
//                       color: Color.fromARGB(255, 126, 172, 196),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Your journey through the stars with your partner begins now with the right date.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _buildPicker(
//                               title: 'Day',
//                               itemCount: maxDaysInMonth,
//                               selectedIndex: selectedDay - 1,
//                               onItemChanged: (index) =>
//                                   setState(() => selectedDay = index + 1),
//                             ),
//                             const SizedBox(width: 36),
//                             _buildPicker(
//                               title: 'Month',
//                               itemCount: 12,
//                               selectedIndex: selectedMonth - 1,
//                               onItemChanged: (index) =>
//                                   setState(() => selectedMonth = index + 1),
//                             ),
//                             const SizedBox(width: 36),
//                             _buildPicker(
//                               title: 'Year',
//                               itemCount: 200,
//                               selectedIndex: selectedYear - 1900,
//                               onItemChanged: (index) =>
//                                   setState(() => selectedYear = 1900 + index),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 36),
//                         Text(
//                           'Selected Date: $selectedDay/${selectedMonth.toString().padLeft(2, '0')}/$selectedYear',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 23,
//                           ),
//                         ),
//                         const SizedBox(height: 26),
//                         ElevatedButton(
//                           onPressed: () {
//                             final updatedDetails = partnerDetails.copyWith(
//                               birthDate: DateTime(
//                                   selectedYear, selectedMonth, selectedDay),
//                             );
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => BirthTimeCompatibility(
//                                   // PartnerDetails: widget.PartnerDetails,
//                                   partnerDetails: updatedDetails,
//                                 ),
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color.fromARGB(
//                                 255, 25, 57, 82), // Button color
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 10),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             minimumSize: const Size(double.infinity, 30),
//                           ),
//                           child: const Text(
//                             'Next',
//                             style: TextStyle(
//                               fontFamily: 'ShantellSans',
//                               fontSize: 23,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
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
//           style: const TextStyle(
//               color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         Container(
//           height: 4,
//           width: 60,
//           color: Colors.white.withOpacity(0.4), // Light line color
//         ),
//         const SizedBox(height: 5),
//         SizedBox(
//           height: 150,
//           width: 70,
//           child: ListWheelScrollView.useDelegate(
//             physics: const FixedExtentScrollPhysics(),
//             controller: FixedExtentScrollController(initialItem: selectedIndex),
//             itemExtent: 40,
//             onSelectedItemChanged: onItemChanged,
//             childDelegate: ListWheelChildBuilderDelegate(
//               builder: (context, index) {
//                 // Distinct styles for selected and non-selected items
//                 final bool isSelected = index == selectedIndex;
//                 return Center(
//                   child: Text(
//                     title == 'Month'
//                         ? monthNames[index]
//                         : '${index + (title == 'Year' ? 1900 : 1)}',
//                     style: TextStyle(
//                       color: isSelected ? Color(0xFFF1A7C4) : Colors.white70,
//                       fontSize: isSelected ? 20 : 16,
//                       fontWeight:
//                           isSelected ? FontWeight.bold : FontWeight.normal,
//                     ),
//                   ),
//                 );
//               },
//               childCount: itemCount,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:chakravyuh/models/partner_details.dart';
import 'package:flutter/material.dart';

import '../../models/birth_details.dart';
import 'tob.dart';

class BirthDateCompatibility extends StatefulWidget {
  const BirthDateCompatibility({super.key, required this.partnerDetails});
  final PartnerDetails partnerDetails;

  @override
  _BirthDateCompatibilityState createState() => _BirthDateCompatibilityState();
}

class _BirthDateCompatibilityState extends State<BirthDateCompatibility> {
  late PartnerDetails partnerDetails;

  @override
  void initState() {
    super.initState();
    // Initialize partnerDetails with the data passed from the parent widget
    partnerDetails = widget.partnerDetails;
  }

  int selectedDay = 1;
  int selectedMonth = 1;
  int selectedYear = 2000;

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
      // Check for leap year
      return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
    }
    return [4, 6, 9, 11].contains(month) ? 30 : 31;
  }

  @override
  Widget build(BuildContext context) {
    final int maxDaysInMonth = _getDaysInMonth(selectedMonth, selectedYear);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Partner's Birth Date"),
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
                  Image.asset('assets/images/date.png', height: 200),
                  const SizedBox(height: 10),
                  const Text(
                    'Set your partner\'s birth date.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 31,
                      color: Color.fromARGB(255, 126, 172, 196),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Your journey through the stars with your partner begins now with the right date.',
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        ElevatedButton(
                          onPressed: () {
                            // Update partnerDetails with the selected birthDate
                            final updatedDetails = partnerDetails.copyWith(
                              birthDate: DateTime(
                                  selectedYear, selectedMonth, selectedDay),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BirthTimeCompatibility(
                                  partnerDetails:
                                      updatedDetails, // Pass updated partnerDetails
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 25, 57, 82),
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
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Container(
          height: 4,
          width: 60,
          color: Colors.white.withOpacity(0.4), // Light line color
        ),
        const SizedBox(height: 5),
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
                    title == 'Month'
                        ? monthNames[index]
                        : '${index + (title == 'Year' ? 1900 : 1)}',
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
