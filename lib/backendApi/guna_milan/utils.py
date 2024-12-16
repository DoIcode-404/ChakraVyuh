from datetime import datetime
import pytz
import swisseph as swe

swe.set_ephe_path(r'kundali_generation\ephemeris_file')

def get_julian_day(birthDate, birthTime, timezone):
    """
    Converts date and time into Julian Day using Swiss Ephemeris.
    """
    dt = datetime.strptime(f"{birthDate} {birthTime}", "%Y-%m-%d %H:%M")
    tz = pytz.timezone(timezone)
    dt = tz.localize(dt)
    utc_time = dt.astimezone(pytz.UTC)
    jd = swe.julday(utc_time.year, utc_time.month, utc_time.day,
                    utc_time.hour + utc_time.minute / 60.0 + utc_time.second / 3600.0)
    return jd

def get_moon_position(jd):
    """
    Calculate the sidereal position of the Moon.
    """
    ayanamsa = swe.get_ayanamsa(jd)
    result = swe.calc_ut(jd, swe.MOON, swe.FLG_SWIEPH)
    tropical_longitude = result[0][0]
    sidereal_longitude = (tropical_longitude - ayanamsa) % 360
    return sidereal_longitude

def get_nakshatra(longitude):
    """
    Get the Nakshatra and Pada for a given sidereal longitude.
    """
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
    return nakshatra_name, pada

def get_moon_sign(nakshatra):
    nakshatra_to_moon_sign = {
    "Ashwini": "Aries", "Bharani": "Aries", "Krittika": "Aries",
    "Rohini": "Taurus", "Mrigashira": "Taurus", "Ardra": "Gemini",
    "Punarvasu": "Gemini", "Pushya": "Cancer", "Ashlesha": "Cancer",
    "Magha": "Leo", "Purva Phalguni": "Leo", "Uttara Phalguni": "Leo",
    "Hasta": "Virgo", "Chitra": "Virgo", "Swati": "Libra",
    "Vishakha": "Libra", "Anuradha": "Scorpio", "Jyeshtha": "Scorpio",
    "Mula": "Sagittarius", "Purva Ashadha": "Sagittarius", "Uttara Ashadha": "Capricorn",
    "Shravana": "Capricorn", "Dhanishta": "Capricorn", "Shatabhisha": "Aquarius",
    "Purva Bhadrapada": "Aquarius", "Uttara Bhadrapada": "Pisces", "Revati": "Pisces"

}
    return nakshatra_to_moon_sign.get(nakshatra,"unkknown")
    