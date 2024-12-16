// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chakravyuh/pages/compatibility/full_report_page.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CompatibilityResultPage extends StatefulWidget {
  final Map<String, dynamic> result;
  const CompatibilityResultPage({
    super.key,
    required this.result,
    // required this.result,
  });

  @override
  State<CompatibilityResultPage> createState() =>
      _CompatibilityResultPageState();
}

class _CompatibilityResultPageState extends State<CompatibilityResultPage> {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the future with the function that fetches the data
//     _compatibilityData = fetchCompatibilityData();
//   }

  int selectedGunaIndex = 0;
  final List<Map<String, dynamic>> gunaData = [
    {
      'name': 'Spirituality',
      'description': 'Spiritual alignment and societal balance.',
      'score': 0.8,
    },
    {
      'name': 'Control',
      'description': 'Mutual attraction and influence.',
      'score': 0.6,
    },
    {
      'name': 'Destiny',
      'description': 'Destiny and health bond.',
      'score': 0.7,
    },
    {
      'name': 'Intimacy',
      'description': 'Physical connection and closeness.',
      'score': 0.9,
    },
    {
      'name': 'Harmony',
      'description': 'Mental harmony and camaraderie.',
      'score': 0.85,
    },
    {
      'name': 'Temperament',
      'description': 'Behavioral sync and emotional balance.',
      'score': 0.65,
    },
    {
      'name': 'Prosperity',
      'description': 'Family prosperity and wealth.',
      'score': 0.75,
    },
    {
      'name': 'Health',
      'description': 'Health and progeny connection.',
      'score': 0.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // final compatibilityScore = result['compatibilityScore'] ?? 0.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Compatibility Results",
          style: TextStyle(
            color: Color(0xFFBCC4FF),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0A1A32),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF071223), Color(0xFF071223)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Section: User and Partner Profiles
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "You",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Color(0xFFBCC4FF),
                          size: 40,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/leo.jpg'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Partner",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Compatibility Summary Card
                Card(
                  color: const Color(0xFF0A1A32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(widget.result['details'] ??
                            'No details available.'),
                        const Text(
                          "Compatibility Overview",
                          style: TextStyle(
                            color: Color(0xFFBCC4FF),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Based on combined zodiac and planetary alignment this is the overall compatibility with you partner",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 10),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 3000,
                          radius: 80,
                          lineWidth: 10.0,
                          percent: 0.8, // Replace with dynamic value
                          center: const Text(
                            "80%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                              color: Color(0xFFBCC4FF),
                            ),
                          ),
                          progressColor: const Color.fromARGB(255, 25, 57, 82),
                          backgroundColor: Colors.grey.shade500,
                        ),
                        // SizedBox(height: 10),
                        const Text(
                          "Overall Compatibility",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBCC4FF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Compatibility Score By Areas
                Card(
                  color: const Color(0xFF0A1A32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Compatibility Index",
                            style: TextStyle(
                              color: Color(0xFFBCC4FF),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //   const SizedBox(height: 10),
                          const Text(
                            "This is how compatible you are with your partner in different aspects",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFBCC4FF),
                              fontSize: 10,
                              //   fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: gunaData.length,
                            itemBuilder: (context, index) {
                              final guna = gunaData[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        guna['name'],
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          LinearPercentIndicator(
                                            animation: true,
                                            animationDuration: 1000,
                                            lineHeight: 14.0,
                                            percent: guna['score'],
                                            center: Text(
                                              "${(guna['score'] * 100).toInt()}%",
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            linearStrokeCap:
                                                LinearStrokeCap.roundAll,
                                            progressColor: const Color.fromARGB(
                                                255, 25, 57, 82),
                                            backgroundColor:
                                                Colors.grey.shade500,
                                          ),
                                          Text(
                                            guna['description'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFFBCC4FF),
                                              //   fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const FullCompatibilityReportPage()));
                  },
                  child: const Text(
                    "Get Full Report",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A1A32),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
