# use a python image
FROM python:3.13.5-slim-bookworm

RUN apt update && apt install curl -y

# copy requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --root-user-action=ignore \
        --upgrade pip && \
    pip install --root-user-action=ignore \
        --quiet --requirement requirements.txt

# set the working directory in the container
WORKDIR /usr/local/bin

# add the current directory to the container
COPY . .

RUN chmod +x /usr/local/bin/main.py

# expose the port the application will listen on
EXPOSE 8080

# execute the Flask app
HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1
CMD ["/usr/local/bin/main.py"]
