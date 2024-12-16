# import logging

# logger = logging.getLogger(__name__)

# def calculate_varna_score(nakshatra1, nakshatra2): 
#     """
#     Returns the Varna based on the Nakshatra of the Moon.
#     :param nakshatra: Nakshatra (string)
#     :return: Varna (string)
#     """
#     varna_map = {
#         'Ashwini': 'Kshatriya', 'Bharani': 'Kshatriya', 'Krittika': 'Vaishya', 'Rohini': 'Vaishya', 'Mrigashira': 'Shudra',
#         'Ardra': 'Shudra', 'Punarvasu': 'Shudra', 'Pushya': 'Brahmin', 'Ashlesha': 'Brahmin', 'Magha': 'Kshatriya',
#         'Purva Phalguni': 'Vaishya', 'Uttara Phalguni': 'Vishya', 'Hasta': 'Vaishya', 'Chitra': 'Shudra', 'Swati': 'Shudra',
#         'Vishakha': 'Shudra', 'Anuradha': 'Brahmin', 'Jyeshtha': 'Brahmin', 'Mula': 'Kshatriya', 'Purva Ashadha': 'Kshatriya',
#         'Uttara Ashadha': 'Vaishya', 'Shravana': 'Vaishya', 'Dhanishta': 'Shudra', 'Shatabhisha': 'Shudra',
#         'Purva Bhadrapada': 'Shudra', 'Uttara Bhadrapada': 'Brahmin', 'Revati': 'Brahmin'
#     }
#     varna_hierarchy = ['Shudra', 'Vaishya', 'Kshatriya', 'Brahmin']

#     varna1= varna_map.get(nakshatra1)
#     varna2= varna_map.get(nakshatra2)

#     if varna1 == "Unknown" or varna2 == "Unknown":
#         raise ValueError("Invalid Nakshatra provided.")
    
#     if varna_hierarchy.index(varna1)>= varna_hierarchy.index(varna2):
#         return 1  # Same Varna
#     else:
#         return 0  # Different Varna
    
# def calculate_vashya_score(nakshatra1, nakshatra2):
#     """
#     Returns the Vashya of a Nakshatra based on its Rashi (Zodiac Sign).
#     :param nakshatra: Nakshatra (string)
#     :return: Vashya (string)
#     """
#     vashya_map = {
#         'Ashwini': 'Chatushpad', 'Bharani': 'Chatushpad', 'Krittika': 'Chatushpad', 
#         'Rohini': 'Chatushpad', 'Mrigashira': 'Chatushpad', 'Ardra': 'Dipad', 
#         'Punarvasu': 'Dipad', 'Pushya': 'Jalachar', 'Ashlesha': 'Jalachar', 
#         'Magha': 'Chatuspad', 'Purva Phalguni': 'Chatuspad', 'Uttara Phalguni': 'Dipad', 
#         'Hasta': 'Dipad', 'Chitra': 'Dipad', 'Swati': 'Dipad', 'Vishakha': 'Keet', 
#         'Anuradha': 'Keet', 'Jyeshtha': 'Keet', 'Mula': 'Manav', 'Purva Ashadha': 'Chatuspad', 
#         'Uttara Ashadha': 'Chatushpad', 'Shravana': 'Dipad', 'Dhanishta': 'Chatuspad', 
#         'Shatabhisha': 'Dipad', 'Purva Bhadrapada': 'Dipad', 'Uttara Bhadrapada': 'Jalachar', 
#         'Revati': 'Jalachar'
#     }
#     vashya1 = vashya_map.get(nakshatra1)
#     vashya2 = vashya_map.get(nakshatra2)

#     compatibility_scores = {
#         ('Chatushpada', 'Chatushpada'): 2,
#         ('Chatushpada', 'Manava'): 1,
#         ('Chatushpada', 'Dipad'): 1,
#         ('Chatushpada', 'Jalchar'): 0,
#         ('Chatushpada', 'Keeta'): 0.5,
#         ('Manava', 'Manava'): 2,
#         ('Manava', 'Chatushpada'): 2,
#         ('Manava', 'Jalchar'): 1,
#         ('Manava', 'Keet'): 0.5,
#         ('Dipad', 'Dipad'): 2,
#         ('Dipad', 'Chatushpada'): 1,
#         ('Dipad', 'Keet'): 0,
#         ('Dipad', 'Jalchar'): 1,
#         ('Jalchar', 'Jalchar'): 2,
#         ('Jalchar', 'Manava'): 1.5,
#         ('Jalchar', 'Vanachara'): 1,
#         ('Jalchar', 'Chatushpada'): 0.5,
#         ('Jalchar', 'Keeta'): 0.5,
#         ('Keeta', 'Keeta'): 1.5,
#         ('Keeta', 'Vanachara'): 1,
#         ('Keeta', 'Chatushpada'): 0.5,
#     }

#    # Check for reversed order
#     if (vashya1, vashya2) in compatibility_scores:
#         return compatibility_scores[(vashya1, vashya2)]
#     elif (vashya2, vashya1) in compatibility_scores:
#         return compatibility_scores[(vashya2, vashya1)]
#     else:
#         return 0  # No compatibility found    
    
#     # score = calculate_vashya_score(nakshatra1,nakshatra2)
#     # return score
    
# def calculate_tara_score(nakshatra1, nakshatra2):
#     """
#     Calculates Tara compatibility score based on Nakshatras.
#     :param nakshatra1: Nakshatra of the groom
#     :param nakshatra2: Nakshatra of the bride
#     :return: Tara compatibility score
#     """
#     # List of Nakshatras with their positions
#     nakshatras = [
#         'Ashwini', 'Bharani', 'Krittika', 'Rohini', 'Mrigashira', 'Ardra', 'Punarvasu',
#         'Pushya', 'Ashlesha', 'Magha', 'Purva Phalguni', 'Uttara Phalguni', 'Hasta', 
#         'Chitra', 'Swati', 'Vishakha', 'Anuradha', 'Jyeshtha', 'Mula', 'Purva Ashadha',
#         'Uttara Ashadha', 'Shravana', 'Dhanishta', 'Shatabhisha', 'Purva Bhadrapada',
#         'Uttara Bhadrapada', 'Revati'
#     ]
    
#     # Get Nakshatra positions
#     pos1 = nakshatras.index(nakshatra1) + 1
#     pos2 = nakshatras.index(nakshatra2) + 1

#     # Calculate distance
#     if pos1 >= pos2:
#         distance = pos1 - pos2
#     else:
#         distance = (pos1 + 27) - pos2

#     # Determine Tara category
#     tara_category = distance % 9

#     # Determine compatibility
#     if tara_category in [1, 3, 5, 7]:  # Auspicious Taras
#         return 3
#     elif tara_category == 9:  # Highly inauspicious (Naidhana)
#         return 0
#     else:  # Inauspicious Taras (2, 4, 6, 8)
#         return 1.5
#     # score = calculate_tara_score(nakshatra1,nakshatra2)
#     # return score

# def calculate_yoni_score(nakshatra1, nakshatra2):
#     """
#     Calculates Yoni compatibility score based on Nakshatras.
#     :param nakshatra1: Nakshatra of the groom
#     :param nakshatra2: Nakshatra of the bride
#     :return: Yoni compatibility score
#     """
#     # Yoni mappings
#     yoni_map = {
#         'Ashwini': 'Horse', 'Shatabhisha': 'Horse',
#         'Bharani': 'Elephant', 'Revati': 'Elephant',
#         'Krittika': 'Sheep', 'Pushya': 'Sheep',
#         'Rohini': 'Serpent', 'Mrigashira': 'Serpent',
#         'Ardra': 'Dog', 'Mula': 'Dog',
#         'Punarvasu': 'Cat', 'Ashlesha': 'Cat',
#         'Magha': 'Rat', 'Purva Phalguni': 'Rat',
#         'Uttara Phalguni': 'Cow', 'Uttara Bhadrapada': 'Cow',
#         'Hasta': 'Buffalo', 'Swati': 'Buffalo',
#         'Chitra': 'Tiger', 'Vishakha': 'Tiger',
#         'Anuradha': 'Deer', 'Jyeshtha': 'Deer',
#         'Purva Ashadha': 'Monkey', 'Shravana': 'Monkey',
#         'Purva Bhadrapada': 'Lion', 'Dhanishta': 'Lion',
#         'Uttara Ashada': 'Mongoose', 'Abhijeet': 'Mongoose'
#     }

#     # Retrieve Yonis
#     yoni1 = yoni_map.get(nakshatra1)
#     yoni2 = yoni_map.get(nakshatra2)

#     if not yoni1 or not yoni2:
#         raise ValueError("Invalid Nakshatra provided.")

#     if yoni1 == yoni2:
#         return 4  # Same Yoni

#     elif (yoni1, yoni2) in [
#         ('Horse', 'Elephant'), ('Elephant', 'Horse'),
#         ('Sheep', 'Cow'), ('Cow', 'Sheep'),
#         ('Lion', 'Tiger'), ('Tiger', 'Lion'),
#         ('Dog', 'Monkey'), ('Monkey', 'Dog'),
#         ('Cat', 'Rat'), ('Rat', 'Cat'),
#         ('Deer', 'Cow'), ('Cow', 'Deer'),
#         ('Mongoose', 'Cat'), ('Cat', 'Mongoose'),
#         ('Horse', 'Deer'), ('Deer', 'Horse'),
#         ('Elephant', 'Cow'), ('Cow', 'Elephant'),
#         ('Tiger', 'Sheep'), ('Sheep', 'Tiger'),
#         ('Monkey', 'Rat'), ('Rat', 'Monkey')
#     ]:
#         return 3  # Friendly Yonis

#     elif (yoni1, yoni2) in [
#         ('Horse', 'Cow'), ('Cow', 'Horse'),
#         ('Elephant', 'Sheep'), ('Sheep', 'Elephant'),
#         ('Lion', 'Deer'), ('Deer', 'Lion'),
#         ('Dog', 'Cat'), ('Cat', 'Dog'),
#         ('Mongoose', 'Rat'), ('Rat', 'Mongoose'),
#         ('Tiger', 'Monkey'), ('Monkey', 'Tiger')
#     ]:
#         return 2  # Neutral compatibility

#     else:
#         return 0  # Opposite or hostile Yoni


# def calculate_graha_maitri_score(moon_sign1, moon_sign2):
#     # Planetary lords of each Moon sign
#     moon_sign_lords = {
#         'Aries': 'Mars', 'Taurus': 'Venus', 'Gemini': 'Mercury', 'Cancer': 'Moon',
#         'Leo': 'Sun', 'Virgo': 'Mercury', 'Libra': 'Venus', 'Scorpio': 'Mars',
#         'Sagittarius': 'Jupiter', 'Capricorn': 'Saturn', 'Aquarius': 'Saturn', 'Pisces': 'Jupiter'
#     }

#     # Planetary friendships table
#     planetary_friends = {
#         'Sun': ['Moon', 'Mars', 'Jupiter'],
#         'Moon': ['Sun', 'Mercury'],
#         'Mars': ['Sun', 'Moon', 'Jupiter'],
#         'Mercury': ['Sun', 'Venus'],
#         'Jupiter': ['Sun', 'Moon', 'Mars'],
#         'Venus': ['Mercury', 'Saturn'],
#         'Saturn': ['Mercury', 'Venus'],
#         'Rahu': ['Venus', 'Saturn'],
#         'Ketu': ['Venus', 'Saturn']
#     }

#     planetary_neutrals = {
#         'Sun': ['Mercury'],
#         'Moon': ['Mars', 'Jupiter', 'Venus'],
#         'Mars': ['Venus', 'Saturn'],
#         'Mercury': ['Mars', 'Jupiter', 'Saturn'],
#         'Jupiter': ['Saturn'],
#         'Venus': ['Mars', 'Jupiter'],
#         'Saturn': ['Jupiter'],
#         'Rahu': ['Mercury'],
#         'Ketu': ['Mercury']
#     }

#     planetary_enemies = {
#         'Sun': ['Venus', 'Saturn'],
#         'Moon': ['Saturn', 'Rahu', 'Ketu'],
#         'Mars': ['Mercury', 'Rahu', 'Ketu'],
#         'Mercury': ['Moon'],
#         'Jupiter': ['Mercury', 'Venus', 'Rahu'],
#         'Venus': ['Sun', 'Moon'],
#         'Saturn': ['Sun', 'Moon', 'Mars'],
#         'Rahu': ['Sun', 'Moon', 'Mars', 'Jupiter'],
#         'Ketu': ['Sun', 'Moon', 'Mars', 'Jupiter']
#     }

#     # Get the planetary lords
#     lord1 = moon_sign_lords[moon_sign1]
#     lord2 = moon_sign_lords[moon_sign2]

#     # Calculate the score
#     if lord2 in planetary_friends[lord1]:
#         return 5  # Friends
#     elif lord2 in planetary_neutrals[lord1]:
#         return 4  # Neutral
#     elif lord2 in planetary_enemies[lord1]:
#         return 0  # Enemies
#     else:
#         return 0  # Default to 0 for undefined relationships

#     # score = calculate_graha_maitri_score(moon_sign1, moon_sign2)
#     # return score

# def calculate_gana_score(nakshatra1, nakshatra2):
#     """
#     Calculates Gana compatibility score based on the Nakshatra Gana classification.
#     :param nakshatra1: Nakshatra of the first person (string)
#     :param nakshatra2: Nakshatra of the second person (string)
#     :return: Gana compatibility score (int)
#     """
    
#     # Gana type map based on Nakshatras
#     gana_map = {
#          'Ashwini': 'Deva', 'Bharani': 'Manushya', 'Krittika': 'Rakshasa', 'Rohini': 'Manushya', 'Mrigashira': 'Deva',
#         'Ardra': 'Rakshasa', 'Punarvasu': 'Deva', 'Pushya': 'Deva', 'Ashlesha': 'Rakshasa', 'Magha': 'Rakshasa',
#         'Purva Phalguni': 'Manushya', 'Uttara Phalguni': 'Manushya', 'Hasta': 'Deva', 'Chitra': 'Rakshasa', 'Swati': 'Deva',
#         'Vishakha': 'Rakshasa', 'Anuradha': 'Deva', 'Jyeshtha': 'Rakshasa', 'Mula': 'Rakshasa', 'Purva Ashadha': 'Manushya',
#         'Uttara Ashadha': 'Manushya', 'Shravana': 'Deva', 'Dhanishta': 'Rakshasa', 'Shatabhisha': 'Rakshasa',
#         'Purva Bhadrapada': 'Manushya', 'Uttara Bhadrapada': 'Manushya', 'Revati': 'Deva'
#     }
    
#     gana1 = gana_map.get(nakshatra1)
#     gana2 = gana_map.get(nakshatra2)
    
#     if not gana1 or not gana2:
#         raise ValueError("Invalid Nakshatra provided.")
    
#     # Determine compatibility based on Gana types
#     if gana1 == gana2:
#         return 6  # Highly compatible, ideal compatibility
#     elif (gana1 == 'Deva' and gana2 == 'Manushya') or (gana1 == 'Manushya' and gana2 == 'Deva'):
#         return 5  # Good compatibility
#     elif (gana1 == 'Manushya' and gana2 == 'Rakshasa') or (gana1 == 'Rakshasa' and gana2 == 'Manushya'):
#         return 1  # Potential for clashes, but workable
#     elif (gana1 == 'Deva' and gana2 == 'Rakshasa') or (gana1 == 'Rakshasa' and gana2 == 'Deva'):
#         return 0  # Some challenges, but workable
#     else:
#         return 0 # default case , no compatibility
    

#     # score = calculate_gana_score(nakshatra1, nakshatra2)  # Default score is 0
#     # logger.debug(f"Calculated Guna Milan score for {nakshatra1} and {nakshatra2}: {score}")
#     # return score

# def calculate_bhakoot_score(moon_sign1, moon_sign2):
#     zodiac_signs = [
#     "Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", 
#     "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"
#     ]
 
#     if moon_sign1 not in zodiac_signs or moon_sign2 not in zodiac_signs:
#         return 0  # Invalid Moon signs

#     # Find the positions of the Moon signs in the zodiac
#     position1 = zodiac_signs.index(moon_sign1)
#     position2 = zodiac_signs.index(moon_sign2)
    
#     # Calculate the relative distance
#     distance = abs(position1 - position2)
#     distance = min(distance, 12 - distance)  # Wrap around for circular zodiac
    
#     # Assign points based on distance
#     if distance in [1, 5, 9]:  # Trikon Bhakoot
#         return 7
#     elif distance in [6, 8]:  # Shad-ashtak Bhakoot
#         return 0
#     elif distance in [2, 12]:  # Inauspicious
#         return 0
#     else:  # Neutral Bhakoot
#         return 4
    
#     # score = calculate_bhakoot_score(moon_sign1,moon_sign2)
#     # return score

# def calculate_nadi_score(nakshatra1, nakshatra2):
#     """
#     Calculate Nadi score for Guna Milan based on Nakshatras.
#     Follows Vedic astrology rules.
#     """
#     aadi_nadi = {'Ashwini', 'Ardra', 'Punarvasu', 'Uttaraphalguni', 'Hasta', 'Jyeshtha', 'Mula', 'Shatabhisha'}
#     madhya_nadi = {'Bharani', 'Mrigashira', 'Pushya', 'Purvaphalguni', 'Chitra', 'Anuradha', 'Purvashada', 'Uttarabhadrapada'}
#     antya_nadi = {'Krittika', 'Rohini', 'Ashlesha', 'Magha', 'Swati', 'Vishakha', 'Uttarashada', 'Shravana', 
#                   'Dhanishta', 'Purvabhadrapada', 'Revati'}

#     # Check Nadi of each Nakshatra
#     if nakshatra1 in aadi_nadi and nakshatra2 in aadi_nadi:
#         return 0  # Same Nadi: No compatibility
#     elif nakshatra1 in madhya_nadi and nakshatra2 in madhya_nadi:
#         return 0  # Same Nadi: No compatibility
#     elif nakshatra1 in antya_nadi and nakshatra2 in antya_nadi:
#         return 0  # Same Nadi: No compatibility
#     else:
#         return 8  # Different Nadi: Full compatibility
    
#     # score = calculate_nadi_score(nakshatra1,nakshatra2)
#     # return score