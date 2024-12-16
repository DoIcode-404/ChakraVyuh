from fastapi import FastAPI, HTTPException
from description import calculate_dominance_score, calculate_role_compatibility
from models import CompatibilityRequest
from utils import get_julian_day, get_moon_position, get_moon_sign, get_nakshatra
# from compatibility import calculate_varna_score
# from compatibility import calculate_vashya_score
from description import calculate_tara_score
from description import calculate_yoni_score
from description import calculate_graha_maitri_score
from description import calculate_gana_score
from description import calculate_bhakoot_score
from description import calculate_nadi_score
from logging_config import logger

app = FastAPI()

@app.post("/guna_milan")
async def guna_milan(request: CompatibilityRequest):
    try:
        logger.info("Calculating Guna Milan")

        # Person 1 details
        jd1 = get_julian_day(request.person1.birthDate, request.person1.birthTime,
                             request.person1.timezone)
        moon_pos1 = get_moon_position(jd1)
        nakshatra1, pada1 = get_nakshatra(moon_pos1)
        moon_sign1 = get_moon_sign(nakshatra1)

        if nakshatra1 is None:
            raise ValueError(f"Invalid Nakshatra for person 1: {request.person1}")

        # Person 2 details
        jd2 = get_julian_day(request.person2.birthDate, request.person2.birthTime,
                             request.person2.timezone)
        moon_pos2 = get_moon_position(jd2)
        nakshatra2, pada2 = get_nakshatra(moon_pos2)
        moon_sign2 = get_moon_sign(nakshatra2)

        if nakshatra2 is None:
            raise ValueError(f"Invalid Nakshatra for person 2: {request.person2}")

        # Compatibility score
        # score1= calculate_varna_score(nakshatra1,nakshatra2)
        # score2=calculate_vashya_score(nakshatra1, nakshatra2)
        # score3=calculate_tara_score(nakshatra1, nakshatra2)
        # score4=calculate_yoni_score(nakshatra1, nakshatra2)
        # score5=calculate_graha_maitri_score(moon_sign1, moon_sign2)
        # score6=calculate_gana_score(nakshatra1, nakshatra2)
        # score7=calculate_bhakoot_score(moon_sign1, moon_sign2)
        # score8=calculate_nadi_score(nakshatra1, nakshatra2)

        # Total compatibility score
        # score = score1+score2+score3+score4+score5+score6+score7+score8

        role_score, role_description = calculate_role_compatibility(nakshatra1, nakshatra2)
        dominance_score, dominance_description = calculate_dominance_score(nakshatra1, nakshatra2)
        tara_score, tara_description = calculate_tara_score(nakshatra1, nakshatra2)
        yoni_score, yoni_description = calculate_yoni_score(nakshatra1, nakshatra2)
        
        graha_maitri_score, graha_maitri_details = calculate_graha_maitri_score(nakshatra1, nakshatra2)

        gana_score, gana_details = calculate_gana_score(nakshatra1, nakshatra2)

        bhakoot_score, bhakoot_details = calculate_bhakoot_score(nakshatra1, nakshatra2)

        nadi_score, nadi_details = calculate_nadi_score(nakshatra1, nakshatra2)
        
        response = {
            "person1": {
                "nakshatra": nakshatra1,
                "pada": pada1,
                "Moon sign": moon_sign1
            },
            "person2": {
                "nakshatra": nakshatra2,
                "pada": pada2,
                "Moon sign": moon_sign2
            },
            "scores":{
                "role":role_score,
                "dominance":dominance_score,
                "tara":tara_score,
                "yoni":yoni_score,
                "graha_maitri": graha_maitri_score,
                "gana": gana_score,
                "bhakoot":bhakoot_score,
                "nadi": nadi_score,
                "Compatibility Score":(role_score+dominance_score+tara_score+yoni_score+graha_maitri_score+gana_score+bhakoot_score+nadi_score),
            },
            "descriptions":{
                "role": role_description,
                "dominance": dominance_description,
                "tara": tara_description,
                "yoni": yoni_description,
                "graha_maitri": graha_maitri_details,
                "gana": gana_details,
                "bhakoot":bhakoot_details,
                "nadi": nadi_details,
            },
            # "varna_score": score1,
            # "vashya_score": score2,
            # "tara_score": score3,
            # "yoni_score": score4,
            # "graha_maitri_score": score4,
            # "gana_score": score6,
            # "bhakoot_score": score7,
            # "nadi_score": score8,
            # "compatibility_score": score,
            # "description": varna
        }

        logger.info("Guna Milan calculation complete")
        return response

    except Exception as e:
        logger.error(f"Error in Guna Milan calculation: {str(e)}")
        raise HTTPException(status_code=500, detail="Error in Guna Milan calculation")

# from fastapi import FastAPI, HTTPException
# from models import CompatibilityRequest
# from utils import get_julian_day, get_moon_position, get_moon_sign, get_nakshatra
# from compatibility import (
#     calculate_varna_score,
#     calculate_vashya_score,
#     calculate_tara_score,
#     calculate_yoni_score,
#     calculate_graha_maitri_score,
#     calculate_gana_score,
#     calculate_bhakoot_score,
#     calculate_nadi_score,
# )
# from logging_config import logger

# app = FastAPI()

# @app.post("/guna_milan")
# async def guna_milan(request: CompatibilityRequest):
#     try:
#         logger.info("Starting Guna Milan calculation")

#         # Person 1 details
#         jd1 = get_julian_day(request.person1.date, request.person1.time, request.person1.timezone)
#         moon_pos1 = get_moon_position(jd1)
#         nakshatra1, pada1 = get_nakshatra(moon_pos1)
#         moon_sign1 = get_moon_sign(nakshatra1)

#         # Person 2 details
#         jd2 = get_julian_day(request.person2.date, request.person2.time, request.person2.timezone)
#         moon_pos2 = get_moon_position(jd2)
#         nakshatra2, pada2 = get_nakshatra(moon_pos2)
#         moon_sign2 = get_moon_sign(nakshatra2)

#         # Compatibility scores
#         varna_score = calculate_varna_score(nakshatra1, nakshatra2)
#         vashya_score = calculate_vashya_score(nakshatra1, nakshatra2)
#         tara_score = calculate_tara_score(nakshatra1, nakshatra2)
#         yoni_score = calculate_yoni_score(nakshatra1, nakshatra2)
#         graha_maitri_score = calculate_graha_maitri_score(moon_sign1, moon_sign2)
#         gana_score = calculate_gana_score(nakshatra1, nakshatra2)
#         bhakoot_score = calculate_bhakoot_score(moon_sign1, moon_sign2)
#         nadi_score = calculate_nadi_score(nakshatra1, nakshatra2)

#         # Total compatibility score
#         total_score = (
#             varna_score
#             + vashya_score
#             + tara_score
#             + yoni_score
#             + graha_maitri_score
#             + gana_score
#             + bhakoot_score
#             + nadi_score
#         )

#         # Prepare the response
#         response = {
#             "person1": {
#                 "nakshatra": nakshatra1,
#                 "pada": pada1,
#                 "moon_sign": moon_sign1,
#             },
#             "person2": {
#                 "nakshatra": nakshatra2,
#                 "pada": pada2,
#                 "moon_sign": moon_sign2,
#             },
#             "varna_score": varna_score,
#             "vashya_score": vashya_score,
#             "tara_score": tara_score,
#             "yoni_score": yoni_score,
#             "graha_maitri_score": graha_maitri_score,
#             "gana_score": gana_score,
#             "bhakoot_score": bhakoot_score,
#             "nadi_score": nadi_score,
#             "total_compatibility_score": total_score,
#         }

#         logger.info("Guna Milan calculation completed successfully")
#         return response

#     except Exception as e:
#         logger.error(f"Error during Guna Milan calculation: {str(e)}")
#         raise HTTPException(
#             status_code=500, detail=f"Internal Server Error: {str(e)}"
#         )
