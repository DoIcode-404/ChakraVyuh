import logging

def configure_logging():
    logging.basicConfig(level=logging.DEBUG)
    logger = logging.getLogger("guna_milan")
    return logger

logger = configure_logging()
