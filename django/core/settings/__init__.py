import os

from split_settings.tools import include, optional  # noqa

if os.getenv("DJANGO_ENV") == "development":
    environment = "development.py"
    # include("development.py")
else:
    include("production.py")
    environment = "production.py"

include("base.py", environment, "logging.py")
