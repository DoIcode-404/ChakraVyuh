import 'package:flutter/material.dart';

class FullCompatibilityReportPage extends StatefulWidget {
  const FullCompatibilityReportPage({super.key});

  @override
  _FullCompatibilityReportPageState createState() =>
      _FullCompatibilityReportPageState();
}

class _FullCompatibilityReportPageState
    extends State<FullCompatibilityReportPage> {
  final List<Map<String, dynamic>> compatibilityData = [
    {
      'name': 'Spirituality',
      'question': 'How aligned are your spiritual and societal values?',
      'description':
          'Your spiritual and societal values show a strong alignment, which helps build mutual understanding and respect.',
      'score': 8,
    },
    {
      'name': 'Control',
      'question': 'Who holds control or influence in the relationship?',
      'description':
          'There is a moderate balance of control between you and your partner, indicating mutual respect.',
      'score': 6,
    },
    {
      'name': 'Destiny',
      'question': 'Are your destinies aligned for a prosperous future?',
      'description':
          'Your destinies align well, which could mean a harmonious journey together.',
      'score': 7,
    },
    {
      'name': 'Intimacy',
      'question': 'How well do you connect on a physical and emotional level?',
      'description':
          'You share a deep emotional and physical connection, enhancing intimacy.',
      'score': 9,
    },
    {
      'name': 'Harmony',
      'question': 'Do you share mental and emotional harmony?',
      'description':
          'Your mental and emotional harmony is excellent, creating a peaceful relationship.',
      'score': 8.5,
    },
    {
      'name': 'Temperament',
      'question': 'How adaptable are your behaviors and attitudes?',
      'description':
          'You and your partner show good adaptability, but there is room for understanding each other’s temperaments.',
      'score': 6.5,
    },
    {
      'name': 'Prosperity',
      'question': 'Will your relationship foster financial well-being?',
      'description':
          'Your compatibility suggests a stable foundation for financial and familial well-being.',
      'score': 7.5,
    },
    {
      'name': 'Health',
      'question': 'How does health and progeny factor into your relationship?',
      'description':
          'Your compatibility in health and progeny is moderate, indicating some areas to be mindful of.',
      'score': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Compatibility Report",
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
              colors: [
                Color(0xFF071223),
                Color(0xFF071223),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                const Center(
                  child: Column(
                    children: [
                      Text(
                        "Full Compatibility Report",
                        style: TextStyle(
                          color: Color(0xFFBCC4FF),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "A detailed breakdown of your compatibility with your partner.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                          Icons.add,
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
                const Text(
                  'Dive Deeper',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBCC4FF),
                  ),
                ),
                // SizedBox(height: 10),
                // Compatibility Cards
                ListView.builder(
                  itemCount: compatibilityData.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = compatibilityData[index];
                    return Card(
                      color: const Color(0xFF0A1A32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Color(0xFFBCC4FF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1C2A4A),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  child: Text(
                                    "${item['score']} / 10",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item['question'],
                              style: const TextStyle(
                                color: Color(0xFFBCC4FF),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['description'],
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add save/share functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 25, 57, 82),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Save & Share Your Compatibility Report",
                      style: TextStyle(fontSize: 18),
                    ),
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
