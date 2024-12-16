import logging
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from datetime import datetime
import swisseph as swe
import pytz

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

app = FastAPI()

class BirthDetails(BaseModel):
    birthDate: str  # Format: YYYY-MM-DD
    birthTime: str  # Format: HH:MM
    latitude: float
    longitude: float
    timezone: str

def get_zodiac_sign(longitude):
    """
    Determine the zodiac sign based on the sidereal longitude.
    """
    # zodiac_signs = [
    #     "Aries (Mesha)", "Taurus (Vrishabha)", "Gemini (Mithuna)", "Cancer (Karka)",
    #     "Leo (Simha)", "Virgo (Kanya)", "Libra (Tula)", "Scorpio (Vrishchika)",
    #     "Sagittarius (Dhanu)", "Capricorn (Makara)", "Aquarius (Kumbha)", "Pisces (Meena)"
    # ]
    zodiac_signs = [
        "Aries", "Taurus", "Gemini ", "Cancer ","Leo", "Virgo", "Libra", "Scorpio",
        "Sagittarius", "Capricorn", "Aquarius", "Pisces"
    ]
    sign_index = int(longitude / 30)
    return zodiac_signs[sign_index]


def calculate_planet_positions(jd):
    """
    Calculate accurate sidereal positions for all planets, including Rahu and Ketu.
    """
    ayanamsa = swe.get_ayanamsa(jd)  # Use Lahiri ayanamsa
    planets = {
        "Sun": swe.SUN,
        "Moon": swe.MOON,
        "Mars": swe.MARS,
        "Mercury": swe.MERCURY,
        "Jupiter": swe.JUPITER,
        "Venus": swe.VENUS,
        "Saturn": swe.SATURN,
        "Rahu": swe.MEAN_NODE,  # Mean node for Rahu
    }
    positions = {}

    for planet_name, planet_id in planets.items():
        flag = swe.FLG_SWIEPH | swe.FLG_SPEED  # Use Swiss Ephemeris with speed flag
        result = swe.calc_ut(jd, planet_id, flag)
        tropical_longitude = result[0][0]  # Get the tropical position
        sidereal_longitude = (tropical_longitude - ayanamsa) % 360  # Convert to sidereal
        positions[planet_name] = sidereal_longitude

    # Ketu is 180° opposite to Rahu
    positions["Ketu"] = (positions["Rahu"] + 180) % 360
    return positions


def calculate_ascendant(jd, lat, lon):
    """
    Calculate the sidereal ascendant based on the Julian Day, latitude, and longitude.
    """
    houses = swe.houses(jd, lat, lon)[0]  # Tropical ascendant
    ayanamsa = swe.get_ayanamsa(jd)
    ascendant = (houses[0] - ayanamsa) % 360  # Sidereal ascendant
    return ascendant


def assign_planets_to_houses(planet_positions, ascendant):
    """
    Assign planets to houses based on the Whole Sign House System.
    """
    houses = {i: [] for i in range(1, 13)}  # Create empty house mapping
    asc_sign = int(ascendant / 30) + 1  # Ascendant sign (1-12)

    for planet, position in planet_positions.items():
        planet_sign = int(position / 30) + 1  # Planet's sidereal sign (1-12)
        house = ((planet_sign - asc_sign) % 12) + 1  # House calculation
        houses[house].append(planet)  # Assign planet to the house

    return houses


def get_nakshatra(longitude):
    nakshatra_names = [
        'Ashwini', 'Bharani', 'Krittika', 'Rohini', 'Mrigashira', 
        'Ardra', 'Punarvasu', 'Pushya', 'Ashlesha', 'Magha', 
        'Purva Phalguni', 'Uttara Phalguni', 'Hasta', 'Chitra', 
        'Swati', 'Vishakha', 'Anuradha', 'Jyeshtha', 'Mula', 
        'Purva Ashadha', 'Uttara Ashadha', 'Shravana', 
        'Dhanishta', 'Shatabhisha', 'Purva Bhadrapada', 
        'Uttara Bhadrapada', 'Revati'
    ]
    degrees_per_nakshatra = 360 / 27
    degrees_per_pada = degrees_per_nakshatra / 4

    nakshatra_index = int(longitude / degrees_per_nakshatra)
    pada = int((longitude % degrees_per_nakshatra) / degrees_per_pada) + 1

    nakshatra_name = nakshatra_names[nakshatra_index]
    logger.debug(f"Longitude: {longitude}, Nakshatra: {nakshatra_name}, Pada: {pada}")
    return nakshatra_name, pada

def get_ruling_planet(moon_sign):
    """
    Determine the ruling planet based on the Moon sign according to Vedic astrology.
    """
    ruling_planets = {
        "Aries": "Mars",
        "Taurus": "Venus",
        "Gemini": "Mercury",
        "Cancer": "Moon",
        "Leo": "Sun",
        "Virgo": "Mercury",
        "Libra": "Venus",
        "Scorpio": "Mars",
        "Sagittarius": "Jupiter",
        "Capricorn": "Saturn",
        "Aquarius": "Saturn",
        "Pisces": "Jupiter"
    }
    return ruling_planets.get(moon_sign, "Unknown")

def get_house_description(house, planet):
    """
    Get personalized descriptions for the houses based on the planet and house placements.
    """
    house_descriptions = {
        1: "The 1st House represents self, personality, physical appearance, and overall approach to life.",
        2: "The 2nd House concerns possessions, wealth, values, and personal resources.",
        3: "The 3rd House is related to communication, siblings, and early education.",
        4: "The 4th House is connected to home, family, roots, and emotional foundation.",
        5: "The 5th House represents creativity, children, romance, and self-expression.",
        6: "The 6th House is about health, work environment, and daily routines.",
        7: "The 7th House is related to partnerships, marriage, and close relationships.",
        8: "The 8th House governs transformation, death, shared resources, and hidden matters.",
        9: "The 9th House signifies higher learning, philosophy, travel, and spirituality.",
        10: "The 10th House represents career, social status, reputation, and public life.",
        11: "The 11th House is associated with friendships, groups, and long-term goals.",
        12: "The 12th House deals with hidden strengths, subconscious mind, and spirituality."
    }

    planet_descriptions = {
        "Sun": "The Sun represents ego, vitality, and the core of your identity.",
        "Moon": "The Moon governs emotions, instincts, and subconscious patterns.",
        "Mars": "Mars represents action, energy, and desire for achievement.",
        "Mercury": "Mercury governs communication, intellect, and logical thinking.",
        "Jupiter": "Jupiter represents expansion, optimism, and growth.",
        "Venus": "Venus is associated with love, beauty, and harmony.",
        "Saturn": "Saturn signifies discipline, structure, and karmic lessons.",
        "Rahu": "Rahu represents obsession, materialism, and worldly desires.",
        "Ketu": "Ketu represents spirituality, detachment, and liberation."
    }

    house_desc = house_descriptions.get(house, "No description available for this house.")
    planet_desc = planet_descriptions.get(planet, "No description available for this planet.")

    return f"Planet: {planet} in the {house} House: {house_desc} {planet_desc}"

def generate_planetary_analysis(planet_positions, planet_house_assignments):
    """
    Generate dynamic and personalized descriptions based on the planetary positions in houses.
    """
    analysis = {}

    for planet, position in planet_positions.items():
        # Get the house the planet is in
        for house, planets in planet_house_assignments.items():
            if planet in planets:
                # Get personalized description for each planet in its respective house
                analysis[planet] = get_house_description(house, planet)

    return analysis
def calculate_aspects(planet_positions):
    aspects = []
    planets = list(planet_positions.keys())

    for i in range(len(planets)):
        for j in range(i + 1, len(planets)):
            planet1 = planets[i]
            planet2 = planets[j]

            angle = abs(planet_positions[planet1] - planet_positions[planet2]) % 360
            if angle < 5 or abs(angle - 180) < 5 or abs(angle - 90) < 5 or abs(angle - 120) < 5 or abs(angle - 60) < 5:
                aspects.append((planet1, planet2, angle))

    return aspects

def get_planet_interpretation(planet, position, nakshatra, house):
    interpretations = {
        "Sun": "The Sun represents vitality and your core identity. When well-placed, it boosts confidence.",
        "Moon": "The Moon governs emotions and instincts. A strong Moon enhances intuition and emotional strength.",
        "Mars": "Mars is your drive and determination. When active, it can give you energy for challenges.",
        "Mercury": "Mercury rules communication and intellect. A favorable Mercury supports quick thinking and eloquent speech.",
        "Jupiter": "Jupiter represents wisdom and expansion. Strong Jupiter brings opportunities for growth and luck.",
        "Venus": "Venus symbolizes love and beauty. Its placement influences relationships and your sense of harmony.",
        "Saturn": "Saturn represents discipline and challenges. Saturn's lessons often come with hard work but lead to growth.",
        "Rahu": "Rahu is associated with materialism and desires. It brings an obsession with worldly gains.",
        "Ketu": "Ketu represents spirituality and detachment. It is the planet of enlightenment and release from attachment.",
    }

    return interpretations.get(planet, "No interpretation available.") + f" Nakshatra: {nakshatra}, House: {house}"

def generate_personalized_horoscope(planet_positions, planet_house_assignments, planet_aspects):
    horoscope = {}

    for planet, position in planet_positions.items():
        # Get the house the planet is in
        for house, planets in planet_house_assignments.items():
            if planet in planets:
                # Get Nakshatra
                nakshatra, pada = get_nakshatra(position)
                # Get interpretation
                interpretation = get_planet_interpretation(planet, position, nakshatra, house)

                # Add the interpretation to the horoscope
                horoscope[planet] = interpretation

    # Analyze aspects and provide additional guidance
    for aspect in planet_aspects:
        planet1, planet2, angle = aspect
        horoscope[f"Aspect between {planet1} and {planet2}"] = f"These two planets are in a special aspect of {angle}° which indicates interaction and influence in your chart."

    return horoscope

def generate_planetary_analysis(planet_positions, planet_house_assignments):
    """
    Generate dynamic and personalized descriptions based on the planetary positions in houses.
    """
    analysis = {}

    # Iterate through each planet and its position
    for planet, position in planet_positions.items():
        # Get the house the planet is in
        for house, planets in planet_house_assignments.items():
            if planet in planets:
                # Generate analysis for each planet in its respective house
                house_desc = get_house_description(house, planet)
                # Example: If the planet is in the 10th house, it's related to career
                analysis[planet] = house_desc

    return analysis

def generate_horoscope(birth_details:BirthDetails, planet_positions):
    """
    Generate a detailed horoscope covering various aspects of life based on astrological data.
    
    Args:
        dob (str): Date of birth in 'YYYY-MM-DD' format.
        time_of_birth (str): Time of birth in 'HH:MM' format.
        place_of_birth (str): Place of birth.
        planetary_positions (dict): Dictionary of planetary positions.
    
    Returns:
        dict: Detailed horoscope for different life aspects.
    """
    horoscope = {}

    # Health Predictions
    if "Saturn" in planet_positions:
        horoscope["Health"] = (
            "The position of Saturn indicates the importance of maintaining discipline in health routines. "
            "Periods of fatigue or stress might be experienced, particularly during Saturn's retrograde phases. "
            "Engaging in yoga, meditation, or consistent exercise will bring stability and vitality."
        )
    else:
        horoscope["Health"] = (
            "The planetary alignment shows good health overall, with resilience against most challenges. "
            "Staying hydrated, eating balanced meals, and ensuring regular checkups will enhance well-being."
        )

    # Wealth Predictions
    if "Jupiter" in planet_positions:
        horoscope["Wealth"] = (
            "Jupiter's presence suggests opportunities for financial growth, especially through long-term investments. "
            "Care should be taken to avoid impulsive spending during unfavorable planetary transits. "
            "A consistent approach toward financial planning will yield positive results."
        )
    else:
        horoscope["Wealth"] = (
            "Steady financial growth is indicated. Wealth accumulation may be slow but sustainable. "
            "Diligent saving and wise decision-making will ensure long-term financial security."
        )

    # Career Predictions
    if "Mars" in planet_positions:
        horoscope["Career"] = (
            "Mars's influence indicates ambition and drive in professional life. Leadership roles, projects requiring innovation, "
            "or dynamic environments are highly favorable. However, periods of impulsiveness should be avoided to maintain steady progress."
        )
    else:
        horoscope["Career"] = (
            "Career paths that emphasize precision, analysis, or creativity are strongly supported. "
            "Patience and persistence will bring recognition and success over time."
        )

    # Relationships Predictions
    if "Venus" in planet_positions:
        horoscope["Relationships"] = (
            "Venus enhances harmony and affection in personal relationships. A period of growth in connections is likely, "
            "with opportunities to deepen bonds. However, over-idealizing situations should be avoided."
        )
    else:
        horoscope["Relationships"] = (
            "Relationships may progress steadily, with a focus on loyalty and mutual understanding. "
            "Patience and communication will play a key role in building strong connections."
        )

    # Spiritual Growth
    if "Moon" in planet_positions:
        horoscope["Spiritual Growth"] = (
            "The Moon's position highlights heightened intuition and emotional insight. This is a favorable time for spiritual practices "
            "like meditation or exploring personal belief systems to gain inner clarity."
        )
    else:
        horoscope["Spiritual Growth"] = (
            "A practical approach to life is indicated, but moments of introspection will provide deeper meaning and balance. "
            "Exploring new philosophies or practices can be enriching."
        )

    # Education and Learning
    if "Mercury" in planet_positions:
        horoscope["Education"] = (
            "Mercury's influence fosters a sharp intellect and a thirst for knowledge. This is a great period for pursuing academic goals, "
            "learning new skills, or delving into areas requiring analytical thinking."
        )
    else:
        horoscope["Education"] = (
            "Consistent effort will yield results in education and personal development. Focusing on one area at a time will bring success."
        )

    # Challenges and Opportunities
    if "Rahu" in planet_positions:
        horoscope["Challenges"] = (
            "Rahu's influence may create periods of confusion or unexpected challenges. Trusting intuition and seeking clarity before "
            "major decisions will help navigate these phases successfully."
        )
    else:
        horoscope["Challenges"] = (
            "The path ahead seems clear of major obstacles. Staying grounded and avoiding overconfidence will ensure steady progress."
        )

    return horoscope


@app.post("/generate_kundali")
async def generate_kundali(birth_details: BirthDetails):
    try:
        logger.info(f"Generating Kundali for: {birth_details}")

        # # Convert to UTC and calculate Julian Day
        dt = datetime.strptime(f"{birth_details.birthDate} {birth_details.birthTime}", "%Y-%m-%d %H:%M")
        tz = pytz.timezone(birth_details.timezone)
        dt = tz.localize(dt)
        utc_time = dt.astimezone(pytz.UTC)
        jd = swe.julday(utc_time.year, utc_time.month, utc_time.day,
                        utc_time.hour + utc_time.minute / 60.0 + utc_time.second / 3600.0)

        # Ascendant calculation
        ascendant = calculate_ascendant(jd, birth_details.latitude, birth_details.longitude)
        asc_nakshatra, asc_pada = get_nakshatra(ascendant)

        # Planet positions
        planet_positions = calculate_planet_positions(jd)

        # Assign planets to houses
        planet_house_assignments = assign_planets_to_houses(planet_positions, ascendant)

        # Nakshatras
        planet_nakshatras = {planet: get_nakshatra(pos) for planet, pos in planet_positions.items()}

        # Calculate Moon sign and determine ruling planet
        moon_sign = get_zodiac_sign(planet_positions["Moon"])
        ruling_planet = get_ruling_planet(moon_sign)

        # Get aspects
        planet_aspects = calculate_aspects(planet_positions)

        # Get personalized horoscope
        personalized_horoscope = generate_personalized_horoscope(planet_positions, planet_house_assignments, planet_aspects)
        planetary_analysis = generate_planetary_analysis(planet_positions, planet_house_assignments)
        horoscope = generate_horoscope(birth_details, planet_positions)

        kundali = {
            "ascendant": {
                "index": int(ascendant / 30) + 1,
                "longitude": ascendant,
                "sign": get_zodiac_sign(ascendant),  # Get zodiac sign for ascendant
                "nakshatra": asc_nakshatra,
                "pada": asc_pada,
            },
            "planets": {
                planet: {
                    "longitude": pos,
                    "sign": get_zodiac_sign(pos),  # Get zodiac sign for each planet
                    "nakshatra": planet_nakshatras[planet][0],
                    "pada": planet_nakshatras[planet][1],
                    "house": next(house for house, planets in planet_house_assignments.items() if planet in planets),
                    "analysis": planetary_analysis.get(planet, "No analysis available.")
                } for planet, pos in planet_positions.items()
            },
            "houses": {
                house: {
                    "sign": (int(ascendant / 30) + house - 1) % 12 + 1,
                    "planets": planets
                } for house, planets in planet_house_assignments.items()
            },
            "zodiac_sign": moon_sign,
            "ruling_planet": ruling_planet,
            "horoscope": personalized_horoscope,
            "field_horoscope": generate_horoscope
        }

        logger.info("Kundali and Horoscope generated successfully")
        return {"status": "success", "kundaliData": kundali}

    except pytz.exceptions.UnknownTimeZoneError as e:
        logger.error(f"Unknown timezone: {str(e)}")
        raise HTTPException(status_code=400, detail=f"Unknown timezone: {birth_details.timezone}")
    except Exception as e:
        logger.error(f"Error generating Kundali: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))