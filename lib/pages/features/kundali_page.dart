import 'package:flutter/material.dart';
import '../../services/kundali_painter.dart';
import '../../services/api_call_service.dart';

class KundaliPage extends StatefulWidget {
  final String userId;

  KundaliPage({Key? key, required this.userId}) : super(key: key);

  @override
  _KundaliPageState createState() => _KundaliPageState();
}

class _KundaliPageState extends State<KundaliPage> {
  late Future<Map<String, dynamic>> kundaliFuture;

  @override
  void initState() {
    super.initState();
    kundaliFuture = KundaliService().fetchKundaliData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1A32),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xFFBCC4FF), // Light blue color
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0), // Adds spacing to the right
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/profile.png',
              ),
            ),
          ),
        ],
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
                children: [
                  const Text(
                    "Kundali Chart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBCC4FF),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<Map<String, dynamic>>(
                    future: kundaliFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color(0xFFBCC4FF),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error: ${snapshot.error}",
                          style: const TextStyle(color: Colors.red),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text(
                          "No data available.",
                          style: TextStyle(color: Colors.white),
                        );
                      }

                      final kundaliData = snapshot.data!;
                      final houses =
                          kundaliData['houses'] as Map<String, dynamic>;
                      final planets =
                          kundaliData['planets'] as Map<String, dynamic>;

                      return Column(
                        children: [
                          CustomPaint(
                            size: const Size(350, 350),
                            painter: KundaliPainter(
                                houses: houses, planets: planets),
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            "Kundali Description",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFBCC4FF),
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          // Display each planet in a card with dynamic analysis
                          for (var planet in planets.entries)
                            Card(
                              color: const Color(0xFF2A3D6C),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Placement of ${planet.key}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFBCC4FF),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    // Get dynamic analysis for each planet
                                    Text(
                                      "${planet.value['analysis'] ?? 'No analysis available'}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          // Display each house in a card
                          for (var house in houses.entries)
                            Card(
                              color: const Color(0xFF2A3D6C),
                              elevation: 5,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${house.key} House",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFBCC4FF),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      // Ensuring that house values are correctly handled
                                      house.value['planets'] is String
                                          ? " ${house.value['planets']}"
                                          : " ${house.value['planets'].toString()}",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
