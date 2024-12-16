
def get_role(nakshatra):
    role_map = {
        'Ashwini': 'Leadership & Protection',
    'Bharani': 'Leadership & Protection',
    'Krittika': 'Prosperity & Resourcefulness',
    'Rohini': 'Prosperity & Resourcefulness',
    'Mrigashira': 'Service & Humility',
    'Ardra': 'Service & Humility',
    'Punarvasu': 'Service & Humility',
    'Pushya': 'Wisdom & Spirituality',
    'Ashlesha': 'Wisdom & Spirituality',
    'Magha': 'Leadership & Protection',
    'Purva Phalguni': 'Prosperity & Resourcefulness',
    'Uttara Phalguni': 'Prosperity & Resourcefulness',
    'Hasta': 'Prosperity & Resourcefulness',
    'Chitra': 'Service & Humility',
    'Swati': 'Service & Humility',
    'Vishakha': 'Service & Humility',
    'Anuradha': 'Wisdom & Spirituality',
    'Jyeshtha': 'Wisdom & Spirituality',
    'Mula': 'Leadership & Protection',
    'Purva Ashadha': 'Leadership & Protection',
    'Uttara Ashadha': 'Prosperity & Resourcefulness',
    'Shravana': 'Prosperity & Resourcefulness',
    'Dhanishta': 'Service & Humility',
    'Shatabhisha': 'Service & Humility',
    'Purva Bhadrapada': 'Service & Humility',
    'Uttara Bhadrapada': 'Wisdom & Spirituality',
    'Revati': 'Wisdom & Spirituality'
    }
    return role_map.get(nakshatra, None)

def get_role_description(role):
    descriptions = {
        'Service & Humility': (
            "Your approach to relationships is grounded and supportive. You excel at creating a stable, ",
            "nurturing environment where both of you can grow together. Showing consistent care and appreciation ",
            "can enhance your bond even further."
        ),
        'Prosperity & Resourcefulness': (
            "You bring practical skills and a focus on building a secure future. You value stability and ",
            "resourcefulness, which helps you create a life full of comfort and opportunities. Sharing your plans and ",
            "dreams openly can deepen trust and connection."
        ),
        'Leadership & Protection': (
            "Your strength lies in providing guidance and a sense of security. You thrive when you take the lead and ",
            "support your partner through life’s challenges. Balancing leadership with listening to your partner’s needs ",
            "will create harmony in the relationship."
        ),
        'Wisdom & Spirituality': (
            "You prioritize intellectual and emotional depth in your connection. Your ability to reflect and bring ",
            "meaningful insights adds value to the relationship. Sharing your thoughts and creating moments for mutual ",
            "growth can make your bond even more fulfilling."
        )
    }
    return descriptions.get(role, "")

def calculate_role_compatibility(nakshatra1, nakshatra2):
    role1 = get_role(nakshatra1)
    role2 = get_role(nakshatra2)

    
    if not role1 or not role2:
            raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not role1 else nakshatra2}")

    score = 1 if role1 == role2 else 0  # Simple logic; refine as needed.
    compatibility_msg = (
        f"Roles are {role1} and {role2}. Complementary match!" if score == 1
        else "Different approaches; requires effort."
    )
    
    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1}'s role: {role1} - {get_role_description(role1)}\n"
        f"- {nakshatra2}'s role: {role2} - {get_role_description(role2)}"
    )
    return score, detailed_description

def get_dominance(nakshatra):
    dominance_map = {
       'Ashwini': 'Dominant',
    'Bharani': 'Dominant',
    'Krittika': 'Dominant',
    'Rohini': 'Submissive',
    'Mrigashira': 'Submissive',
    'Ardra': 'Dominant',
    'Punarvasu': 'Submissive',
    'Pushya': 'Submissive',
    'Ashlesha': 'Dominant',
    'Magha': 'Dominant',
    'Purva Phalguni': 'Submissive',
    'Uttara-phalguni': 'Dominant',
    'Hasta': 'Submissive',
    'Chitra': 'Dominant',
    'Swati': 'Submissive',
    'Vishakha': 'Dominant',
    'Anuradha': 'Submissive',
    'Jyeshtha': 'Dominant',
    'Mula': 'Submissive',
    'Purvashadha': 'Dominant',
    'Uttara-shadha': 'Submissive',
    'Shravana': 'Dominant',
    'Dhanishta': 'Submissive',
    'Shatabhisha': 'Dominant',
    'Purvabhadrapada': 'Submissive',
    'Uttara-bhadrapada': 'Dominant',
    'Revati': 'Submissive'
    }
    return dominance_map.get(nakshatra, None)
def calculate_dominance_score(nakshatra1, nakshatra2):
    dominance1 = get_dominance(nakshatra1)
    dominance2 = get_dominance(nakshatra2)

    if not dominance1 or not dominance2:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not dominance1 else nakshatra2}")

    # Define compatibility based on dominance:
    if dominance1 == dominance2:
        if dominance1 == 'Dominant':
            score = 0  # Both dominant may lead to conflict
            dominance_msg = f"Both partners are Dominant, which may lead to power struggles."
        else:
            score = 1  # Both submissive, peaceful but lacks leadership
            dominance_msg = f"Both partners are Submissive, creating a harmonious, but passive relationship."
    else:
        score = 1  # One dominant, one submissive forms a balanced relationship
        dominance_msg = f"One partner is Dominant, and the other is Submissive, forming a balanced and harmonious dynamic."

    detailed_description = (
        f"{dominance_msg}\n\n"
        f"Details:\n- {nakshatra1}'s dominance: {dominance1}.\n"
        f"- {nakshatra2}'s dominance: {dominance2}."
    )
    return score, detailed_description

def get_tara_distance(nakshatra1, nakshatra2):
    # Mapping of Nakshatras to their positions (in degrees, rough estimation)
    nakshatra_positions = {
    'Ashwini': 0,
    'Bharani': 13.33,
    'Krittika': 26.66,
    'Rohini': 40,
    'Mrigashira': 53.33,
    'Ardra': 66.66,
    'Punarvasu': 80,
    'Pushya': 93.33,
    'Ashlesha': 106.66,
    'Magha': 120,
    'Purva Phalguni': 133.33,
    'Uttara-phalguni': 146.66,
    'Hasta': 160,
    'Chitra': 173.33,
    'Swati': 186.66,
    'Vishakha': 200,
    'Anuradha': 213.33,
    'Jyeshtha': 226.66,
    'Mula': 240,
    'Purvashadha': 253.33,
    'Uttara-shadha': 266.66,
    'Shravana': 280,
    'Dhanishta': 293.33,
    'Shatabhisha': 306.66,
    'Purvabhadrapada': 320,
    'Uttara-bhadrapada': 333.33,
    'Revati': 346.66
    }

    # Calculate the difference between two Nakshatras
    position1 = nakshatra_positions.get(nakshatra1)
    position2 = nakshatra_positions.get(nakshatra2)

    if position1 is None or position2 is None:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if position1 is None else nakshatra2}")
    
    # Calculate the absolute difference in positions and map to Tara distance
    distance = abs(position1 - position2)
    if distance > 180:  # Adjust for circular nature of Nakshatra wheel
        distance = 360 - distance

    # Determine Tara score based on the distance
    if distance <= 20:
        tara_score = 3 # Good compatibility (1, 2, 3, 5 Taras)
    elif 20 < distance <= 40:
        tara_score = 1.5  # Average compatibility (4, 6, 8 Taras)
    else:
        tara_score = 0  # Challenging compatibility (7, 9, 12 Taras)

    return tara_score, distance

def calculate_tara_score(nakshatra1, nakshatra2):
    nakshatra_positions = {
    "Ashwini": 0,
    "Bharani": 13.33,
    "Krittika": 26.66,
    "Rohini": 40,
    "Mrigashira": 53.33,
    "Ardra": 66.66,
    "Punarvasu": 80,
    "Pushya": 93.33,
    "Ashlesha": 106.66,
    "Magha": 120,
    "Purva Phalguni": 133.33,
    "Uttara Phalguni": 146.66,
    "Hasta": 160,
    "Chitra": 173.33,
    "Swati": 186.66,
    "Vishakha": 200,
    "Anuradha": 213.33,
    "Jyeshtha": 226.66,
    "Mula": 240,
    "Purva Ashadha": 253.33,
    "Uttara Ashadha": 266.66,
    "Shravana": 280,
    "Dhanishta": 293.33,
    "Shatabhisha": 306.66,
    "Purva Bhadrapada": 320,
    "Uttara Bhadrapada": 333.33,
    "Revati": 346.66
}

    tara_score, distance = get_tara_distance(nakshatra1, nakshatra2)

    if tara_score == 3:
        tara_msg = (
            f"Your Tara compatibility is excellent, indicating a strong, favorable bond. "
            f"This distance (around {distance} degrees) aligns you with the energies of destiny, "
            f"promising a prosperous and harmonious relationship. "
            "You both share a good fortune that complements each other's strengths."
        )
    elif tara_score == 1.5:
        tara_msg = (
            f"The Tara compatibility between you two shows a moderate level of harmony. "
            f"With a distance of {distance} degrees, while the relationship has potential, "
            f"there may be challenges along the way that require effort and understanding. "
            "Patience and mutual respect will help you navigate these hurdles successfully."
        )
    else:
        tara_msg = (
            f"The Tara score indicates some challenges with a distance of {distance} degrees. "
            "This suggests that the relationship might face significant hurdles, especially when it comes to alignment of life goals. "
            "While you may feel drawn to each other, it's important to be aware of the potential difficulties in the long run."
        )
    
    detailed_description = (
        f"{tara_msg}\n\n"
        f"Details:\n- {nakshatra1}'s position: {nakshatra_positions.get(nakshatra1)} degrees.\n"
        f"- {nakshatra2}'s position: {nakshatra_positions.get(nakshatra2)} degrees.\n"
    )
    return tara_score, detailed_description
def get_yoni(nakshatra):
    # Mapping of Nakshatras to their corresponding Yoni (animal symbol)
    yoni_map = {
        'Ashwini': 'Horse',
    'Bharani': 'Elephant',
    'Krittika': 'Tiger',
    'Rohini': 'Serpent',
    'Mrigashira': 'Deer',
    'Ardra': 'Dog',
    'Punarvasu': 'Cat',
    'Pushya': 'Cow',
    'Ashlesha': 'Naga',
    'Magha': 'Lion',
    'Purva Phalguni': 'Rat',  # Corrected spelling of 'Purvaphalguni'
    'Uttara Phalguni': 'Cow',  # Corrected spelling of 'Uttara-phalguni'
    'Hasta': 'Elephant',
    'Chitra': 'Rat',
    'Swati': 'Horse',
    'Vishakha': 'Serpent',
    'Anuradha': 'Deer',
    'Jyeshtha': 'Tiger',
    'Mula': 'Dog',
    'Purva Ashadha': 'Cat',  # Corrected spelling of 'Purvashadha'
    'Uttara Ashadha': 'Elephant',  # Corrected spelling of 'Uttara-shadha'
    'Shravana': 'Cow',
    'Dhanishta': 'Naga',
    'Shatabhisha': 'Horse',
    'Purva Bhadrapada': 'Rat',  # Corrected spelling of 'Purvabhadrapada'
    'Uttara Bhadrapada': 'Serpent',  # Corrected spelling of 'Uttara-bhadrapada'
    'Revati': 'Deer'
    }
    
    return yoni_map.get(nakshatra, None)

def calculate_yoni_score(nakshatra1, nakshatra2):
    yoni1 = get_yoni(nakshatra1)
    yoni2 = get_yoni(nakshatra2)

    if not yoni1 or not yoni2:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not yoni1 else nakshatra2}")

    # Determine Yoni compatibility based on matching or differing animals
    if yoni1 == yoni2:
        score = 4  # High mental compatibility
        compatibility_msg = f"Your Yoni compatibility is excellent! Both of you share the same animal symbol ({yoni1}), which indicates a deep understanding of each other's mental and emotional state."
    else:
        score = 0  # Lower mental compatibility
        compatibility_msg = f"Your Yoni compatibility might face some challenges. The mental and emotional alignment between your animal symbols ({yoni1} and {yoni2}) may require effort and understanding."

    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1}'s Yoni: {yoni1} - {get_yoni_description(yoni1)}\n"
        f"- {nakshatra2}'s Yoni: {yoni2} - {get_yoni_description(yoni2)}"
    )
    return score, detailed_description

def get_yoni_description(yoni):
    descriptions = {
        'Horse': "Symbolizes freedom, energy, and vitality. You both may have an independent streak, but that can sometimes lead to misunderstandings if not handled with care.",
        'Elephant': "Represents wisdom, strength, and stability. You two are likely to approach situations thoughtfully and carefully, but may sometimes clash in terms of handling change.",
        'Tiger': "Symbolizes courage, leadership, and passion. Your mental and emotional energy can be intense, and while you both may lead, you might also challenge each other’s decisions.",
        'Serpent': "Represents transformation and deep understanding. Your relationship may be intense and transformative, but emotional expression could sometimes be difficult.",
        'Deer': "Represents gentleness, sensitivity, and empathy. Both of you are likely to be emotionally attuned to each other, but might also be prone to overthinking and emotional vulnerabilities.",
        'Dog': "Symbolizes loyalty, protection, and trust. Your relationship may have a strong emotional bond, but it can also be marked by possessiveness or expectations.",
        'Cat': "Represents independence and curiosity. You might value personal space and freedom, and may need to find common ground in balancing individuality with togetherness.",
        'Cow': "Represents nurturing, kindness, and stability. You two are likely to have a calm and supportive relationship, but may also need to work on maintaining emotional excitement and energy.",
        'Naga': "Symbolizes wisdom and healing. Your relationship can be profound, with deep emotional connections, but both of you may need to overcome issues of emotional distance or guardedness.",
        'Lion': "Represents leadership and authority. While both of you may have dominant personalities, you need to find a balance to avoid power struggles in the relationship.",
        'Rat': "Symbolizes adaptability and resourcefulness. You two might adapt well together, but you may also need to be mindful of emotional manipulations or a lack of deeper connection.",
    }
    return descriptions.get(yoni, "No description available for this Yoni.")
def get_ruling_planet(nakshatra):
    # Mapping of Nakshatras to their ruling planets
    ruling_planet_map = {
         'Ashwini': 'Ketu',
    'Bharani': 'Venus',
    'Krittika': 'Sun',
    'Rohini': 'Moon',
    'Mrigashira': 'Mars',
    'Ardra': 'Rahu',
    'Punarvasu': 'Jupiter',
    'Pushya': 'Saturn',
    'Ashlesha': 'Mercury',
    'Magha': 'Ketu',
    'Purva Phalguni': 'Venus',
    'Uttara Phalguni': 'Sun',  # Corrected spelling of 'Uttara-phalguni'
    'Hasta': 'Moon',
    'Chitra': 'Mars',
    'Swati': 'Rahu',
    'Vishakha': 'Jupiter',
    'Anuradha': 'Saturn',
    'Jyeshtha': 'Mercury',
    'Mula': 'Ketu',
    'Purva Ashadha': 'Venus',  # Corrected spelling of 'Purvashadha'
    'Uttara Ashadha': 'Sun',  # Corrected spelling of 'Uttara-shadha'
    'Shravana': 'Moon',
    'Dhanishta': 'Mars',
    'Shatabhisha': 'Rahu',
    'Purva Bhadrapada': 'Jupiter',  # Corrected spelling of 'Purvabhadrapada'
    'Uttara Bhadrapada': 'Saturn',  # Corrected spelling of 'Uttara-bhadrapada'
    'Revati': 'Mercury'
    }
    return ruling_planet_map.get(nakshatra, None)

def calculate_graha_maitri_score(nakshatra1, nakshatra2):
    planet1 = get_ruling_planet(nakshatra1)
    planet2 = get_ruling_planet(nakshatra2)

    if not planet1 or not planet2:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not planet1 else nakshatra2}")

    # Calculate the relationship between the planets of both Nakshatras
    friendship_map = {
        ('Ketu', 'Ketu'): 5, ('Ketu', 'Venus'): 0, ('Ketu', 'Sun'): 0, ('Ketu', 'Moon'): 0, ('Ketu', 'Mars'): 0, ('Ketu', 'Rahu'): 5, 
        ('Ketu', 'Jupiter'): 5, ('Ketu', 'Saturn'): 0, ('Venus', 'Ketu'): 0, ('Venus', 'Venus'): 5, ('Venus', 'Sun'): 0, ('Venus', 'Moon'): 5,
        ('Venus', 'Mars'): 0, ('Venus', 'Rahu'): 0, ('Venus', 'Jupiter'): 5, ('Venus', 'Saturn'): 0,
        ('Sun', 'Ketu'): 0, ('Sun', 'Venus'): 0, ('Sun', 'Sun'): 5, ('Sun', 'Moon'): 5, ('Sun', 'Mars'): 0, ('Sun', 'Rahu'): 0, 
        ('Sun', 'Jupiter'): 5, ('Sun', 'Saturn'): 0,
        ('Moon', 'Ketu'): 0, ('Moon', 'Venus'): 5, ('Moon', 'Sun'): 5, ('Moon', 'Moon'): 5, ('Moon', 'Mars'): 0, ('Moon', 'Rahu'): 0,
        ('Moon', 'Jupiter'): 5, ('Moon', 'Saturn'): 0,
        ('Mars', 'Ketu'): 0, ('Mars', 'Venus'): 0, ('Mars', 'Sun'): 0, ('Mars', 'Moon'): 0, ('Mars', 'Mars'): 5, ('Mars', 'Rahu'): 0,
        ('Mars', 'Jupiter'): 5, ('Mars', 'Saturn'): 5,
        ('Rahu', 'Ketu'): 5, ('Rahu', 'Venus'): 0, ('Rahu', 'Sun'): 0, ('Rahu', 'Moon'): 0, ('Rahu', 'Mars'): 0, ('Rahu', 'Rahu'): 5, 
        ('Rahu', 'Jupiter'): 0, ('Rahu', 'Saturn'): 0,
        ('Jupiter', 'Ketu'): 5, ('Jupiter', 'Venus'): 5, ('Jupiter', 'Sun'): 5, ('Jupiter', 'Moon'): 5, ('Jupiter', 'Mars'): 5, 
        ('Jupiter', 'Rahu'): 0, ('Jupiter', 'Jupiter'): 5, ('Jupiter', 'Saturn'): 0,
        ('Saturn', 'Ketu'): 0, ('Saturn', 'Venus'): 0, ('Saturn', 'Sun'): 0, ('Saturn', 'Moon'): 0, ('Saturn', 'Mars'): 5, 
        ('Saturn', 'Rahu'): 0, ('Saturn', 'Jupiter'): 0, ('Saturn', 'Saturn'): 5
    }

    score = friendship_map.get((planet1, planet2)) or friendship_map.get((planet2, planet1), 0)

    # Interpret the score
    if score == 5:
        compatibility_msg = "The planets are aligned positively, indicating a strong friendship and emotional understanding between you two."
    else:
        compatibility_msg = "There may be some friction or challenges due to differing planetary energies, but with effort, the bond can grow."

    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1}'s ruling planet: {planet1}\n- {nakshatra2}'s ruling planet: {planet2}"
    )
    
    return score, detailed_description

def get_gana(nakshatra):
    # Mapping Nakshatras to their respective Gana
    gana_map = {
       'Ashwini': 'Deva',
    'Bharani': 'Deva',
    'Krittika': 'Manushya',
    'Rohini': 'Manushya',
    'Mrigashira': 'Rakshasa',
    'Ardra': 'Rakshasa',
    'Punarvasu': 'Deva',
    'Pushya': 'Deva',
    'Ashlesha': 'Manushya',
    'Magha': 'Rakshasa',
    'Purva Phalguni': 'Manushya',
    'Uttara Phalguni': 'Deva',  # Corrected spelling of 'Uttara-phalguni'
    'Hasta': 'Deva',
    'Chitra': 'Manushya',
    'Swati': 'Rakshasa',
    'Vishakha': 'Deva',
    'Anuradha': 'Manushya',
    'Jyeshtha': 'Rakshasa',
    'Mula': 'Deva',
    'Purva Ashadha': 'Manushya',  # Corrected spelling of 'Purvashadha'
    'Uttara Ashadha': 'Deva',  # Corrected spelling of 'Uttara-shadha'
    'Shravana': 'Rakshasa',
    'Dhanishta': 'Deva',
    'Shatabhisha': 'Manushya',
    'Purva Bhadrapada': 'Rakshasa',  # Corrected spelling of 'Purvabhadrapada'
    'Uttara Bhadrapada': 'Deva',  # Corrected spelling of 'Uttara-bhadrapada'
    'Revati': 'Manushya'
    }
    return gana_map.get(nakshatra, None)

def calculate_gana_score(nakshatra1, nakshatra2):
    gana1 = get_gana(nakshatra1)
    gana2 = get_gana(nakshatra2)

    if not gana1 or not gana2:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not gana1 else nakshatra2}")

    # Gana compatibility based on Vedic principles
    if gana1 == 'Deva' and gana2 == 'Deva':
        score = 6
        compatibility_msg = "A divine and peaceful connection. Both share similar spiritual and emotional inclinations."
    elif gana1 == 'Manushya' and gana2 == 'Manushya':
        score = 6
        compatibility_msg = "Both have a balanced temperament, creating a harmonious and grounded relationship."
    elif (gana1 == 'Deva' and gana2 == 'Manushya') or (gana1 == 'Manushya' and gana2 == 'Deva'):
        score = 5
        compatibility_msg = "A moderate connection. There’s a balance, though one may feel more spiritual than the other."
    elif (gana1 == 'Deva' and gana2 == 'Rakshasa') or (gana1 == 'Rakshasa' and gana2 == 'Deva'):
        score = 0
        compatibility_msg = "Challenging. The divine temperament may not resonate well with the fiery nature of the Rakshasa."
    elif (gana1 == 'Manushya' and gana2 == 'Rakshasa') or (gana1 == 'Rakshasa' and gana2 == 'Manushya'):
        score = 0.5
        compatibility_msg = "Moderate compatibility. The practical nature of Manushya may clash with the intense nature of Rakshasa."
    elif gana1 == 'Rakshasa' and gana2 == 'Rakshasa':
        score = 0
        compatibility_msg = "A challenging connection. Both have an intense nature, which may lead to conflict."

    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1} is of {gana1} nature.\n- {nakshatra2} is of {gana2} nature."
    )

    return score, detailed_description
def get_bhakoot(nakshatra1, nakshatra2):
    # Mapping Nakshatras to their corresponding Bhakoot compatibility scores
    bhakoot_map = {
          'Ashwini': '7',
    'Bharani': '7',
    'Krittika': '0.5',
    'Rohini': '0.5',
    'Mrigashira': '7',
    'Ardra': '0.5',
    'Punarvasu': '7',
    'Pushya': '7',
    'Ashlesha': '0',
    'Magha': '3.5',
    'Purva Phalguni': '7',
    'Uttara Phalguni': '7',  # Corrected spelling of 'Uttara-phalguni'
    'Hasta': '7',
    'Chitra': '3.5',
    'Swati': '7',
    'Vishakha': '7',
    'Anuradha': '3.5',
    'Jyeshtha': '0',
    'Mula': '7',
    'Purva Ashadha': '7',  # Corrected spelling of 'Purvashadha'
    'Uttara Ashadha': '7',  # Corrected spelling of 'Uttara-shadha'
    'Shravana': '7',
    'Dhanishta': '3.5',
    'Shatabhisha': '0',
    'Purva Bhadrapada': '0',  # Corrected spelling of 'Purvabhadrapada'
    'Uttara Bhadrapada': '7',  # Corrected spelling of 'Uttara-bhadrapada'
    'Revati': '3.5'
    }
    return bhakoot_map.get(nakshatra1, None), bhakoot_map.get(nakshatra2, None)

def calculate_bhakoot_score(nakshatra1, nakshatra2):
    bhakoot1, bhakoot2 = get_bhakoot(nakshatra1, nakshatra2)

    if bhakoot1 is None or bhakoot2 is None:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not bhakoot1 else nakshatra2}")

    # Bhakoot compatibility score based on Nakshatra position
    if bhakoot1 == bhakoot2:
        score = float(bhakoot1)  # If both Nakshatras have the same Bhakoot score
        if score == 7:
            compatibility_msg = "Strong emotional and affectionate connection. You share a deep emotional bond."
        elif score == 3.5:
            compatibility_msg = "Moderate emotional connection. Some emotional challenges may need addressing."
        else:
            compatibility_msg = "Low emotional connection. There may be emotional disconnect or misunderstandings."
    else:
        score = 0
        compatibility_msg = "Low Bhakoot score. Emotional compatibility may be weak, requiring effort to connect on a deeper level."

    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1} has Bhakoot score of {bhakoot1}.\n- {nakshatra2} has Bhakoot score of {bhakoot2}."
    )

    return score, detailed_description

def get_nadi(nakshatra1, nakshatra2):
    # Mapping Nakshatras to their corresponding Nadi categories
    nadi_map = {
          'Ashwini': 'Adi',
    'Bharani': 'Madhya',
    'Krittika': 'Antya',
    'Rohini': 'Adi',
    'Mrigashira': 'Madhya',
    'Ardra': 'Antya',
    'Punarvasu': 'Adi',
    'Pushya': 'Madhya',
    'Ashlesha': 'Antya',
    'Magha': 'Adi',
    'Purva Phalguni': 'Madhya',  # Corrected spelling of 'Purvaphalguni'
    'Uttara Phalguni': 'Antya',  # Corrected spelling of 'Uttara-phalguni'
    'Hasta': 'Adi',
    'Chitra': 'Madhya',
    'Swati': 'Antya',
    'Vishakha': 'Adi',
    'Anuradha': 'Madhya',
    'Jyeshtha': 'Antya',
    'Mula': 'Adi',
    'Purva Ashadha': 'Madhya',  # Corrected spelling of 'Purvashadha'
    'Uttara Ashadha': 'Antya',  # Corrected spelling of 'Uttara-shadha'
    'Shravana': 'Adi',
    'Dhanishta': 'Madhya',
    'Shatabhisha': 'Antya',
    'Purva Bhadrapada': 'Adi',  # Corrected spelling of 'Purvabhadrapada'
    'Uttara Bhadrapada': 'Madhya',  # Corrected spelling of 'Uttara-bhadrapada'
    'Revati': 'Antya'
    }
    return nadi_map.get(nakshatra1, None), nadi_map.get(nakshatra2, None)

def calculate_nadi_score(nakshatra1, nakshatra2):
    nadi1, nadi2 = get_nadi(nakshatra1, nakshatra2)

    if nadi1 is None or nadi2 is None:
        raise ValueError(f"Invalid Nakshatra: {nakshatra1 if not nadi1 else nakshatra2}")

    # Nadi compatibility score based on Nakshatra position
    if nadi1 == nadi2:
        score = 8
        compatibility_msg = "Perfect Nadi match! Your energies are complementary, ensuring longevity and harmony in the relationship."
    else:
        score = 0
        compatibility_msg = "No Nadi match. There might be potential issues in health, longevity, or emotional stability."

    detailed_description = (
        f"{compatibility_msg}\n\n"
        f"Details:\n- {nakshatra1} has Nadi category {nadi1}.\n- {nakshatra2} has Nadi category {nadi2}."
    )

    return score, detailed_description
