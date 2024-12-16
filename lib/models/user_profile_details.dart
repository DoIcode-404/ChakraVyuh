class KundaliData {
  final Ascendant ascendant;
  final Map<String, Planet> planets;
  final Map<int, House> houses;
  final String zodiac_sign;
  final String ruling_planet;
  final String zodiac_quality;
  final String zodiac_weakness;
  final String analysis;
  final String horoscope;
  final String name; // Add username
  final String birthDate; // Add date of birth

  KundaliData({
    required this.horoscope,
    required this.ascendant,
    required this.planets,
    required this.houses,
    required this.zodiac_sign,
    required this.ruling_planet,
    required this.zodiac_quality,
    required this.zodiac_weakness,
    required this.name, // Include username in constructor
    required this.birthDate,
    required this.analysis, // Include birthDate in constructor
  });

  factory KundaliData.fromJson(Map<String, dynamic> json) {
    return KundaliData(
      ascendant: Ascendant.fromJson(json['ascendant']),
      planets: (json['planets'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, Planet.fromJson(value)),
      ),
      houses: (json['houses'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          int.tryParse(key) ?? 0, // Default to 0 if parsing fails
          House.fromJson(value),
        ),
      ),
      zodiac_sign: json['zodiac_sign']?.toString() ?? 'Unknown',
      ruling_planet: json['ruling_planet']?.toString() ?? 'Unknown',
      zodiac_quality:
          _determineZodiacQuality(json['zodiac_sign']?.toString() ?? '')
              .strength,
      zodiac_weakness:
          _determineZodiacQuality(json['zodiac_sign']?.toString() ?? '')
              .weakness,
      name: json['name']?.toString() ?? 'Unknown User',
      birthDate: json['birthDate']?.toString() ?? 'Unknown DOB',
      analysis: json['analysis']?.toString() ?? 'null',
      horoscope: json['horoscope']?.toString() ?? 'null',
    );
  }

  static _ZodiacAttributes _determineZodiacQuality(String zodiac_sign) {
    switch (zodiac_sign.toLowerCase()) {
      case 'aries':
        return _ZodiacAttributes('Leadership', 'Impatience');
      case 'taurus':
        return _ZodiacAttributes('Stability', 'Stubbornness');
      case 'gemini':
        return _ZodiacAttributes('Communication', 'Indecisiveness');
      case 'cancer':
        return _ZodiacAttributes('Nurturing', 'Moodiness');
      case 'leo':
        return _ZodiacAttributes('Creativity', 'Arrogance');
      case 'virgo':
        return _ZodiacAttributes('Organization', 'Overthinking');
      case 'libra':
        return _ZodiacAttributes('Diplomacy', 'Avoid Conflict');
      case 'scorpio':
        return _ZodiacAttributes('Resilience', 'Jealousy');
      case 'sagittarius':
        return _ZodiacAttributes('Exploration', 'Impatience');
      case 'capricorn':
        return _ZodiacAttributes('Ambition', 'Pessimism');
      case 'aquarius':
        return _ZodiacAttributes('Innovation', 'Detachment');
      case 'pisces':
        return _ZodiacAttributes('Empathy', 'Escapism');
      default:
        return _ZodiacAttributes('Unknown', 'Unknown');
    }
  }
}

class _ZodiacAttributes {
  final String strength;
  final String weakness;

  _ZodiacAttributes(this.strength, this.weakness);
}

class Ascendant {
  final int index;
  final double longitude;
  final String sign;
  final String nakshatra;
  final int pada;

  Ascendant({
    required this.index,
    required this.longitude,
    required this.sign,
    required this.nakshatra,
    required this.pada,
  });

  factory Ascendant.fromJson(Map<String, dynamic> json) {
    return Ascendant(
      index: json['index'],
      longitude: json['longitude'],
      sign: json['sign'],
      nakshatra: json['nakshatra'],
      pada: json['pada'],
    );
  }
}

class Planet {
  final double longitude;
  final String sign;
  final String nakshatra;
  final int pada;
  final int house;
  // final int analysis;

  Planet({
    required this.longitude,
    required this.sign,
    required this.nakshatra,
    required this.pada,
    required this.house,
    // required this.analysis,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      longitude: json['longitude'],
      sign: json['sign'],
      nakshatra: json['nakshatra'],
      pada: json['pada'],
      house: json['house'],
      // analysis: json['analysis'],
    );
  }
}

class House {
  final int sign;
  final List<String> planets;

  House({required this.sign, required this.planets});

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      sign: json['sign'],
      planets: List<String>.from(json['planets']),
    );
  }
}
