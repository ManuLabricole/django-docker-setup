# pull official base image
FROM python:3.11.4-slim-buster

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

################################################
# Install system dependencies
RUN apt-get update && apt-get install -y netcat

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

################################################ 
################################################
# copy project
COPY . .

# Copy the entrypoint script from the local 'scripts' directory to the container's working directory.
# COPY ./scripts/entrypoint-dev.sh ./scripts
# Remove any carriage return characters from the entrypoint script.
# This is useful if the script was created or edited on a Windows machine, as it uses different line endings (CRLF) compared to Linux (LF).
RUN sed -i 's/\r$//g' /usr/src/app/scripts/entrypoint.dev.sh
# Make the entrypoint script executable.
# This is necessary to ensure the script can be run by the container.
RUN chmod +x /usr/src/app/scripts/entrypoint.dev.sh



# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/scripts/entrypoint-dev.sh"]