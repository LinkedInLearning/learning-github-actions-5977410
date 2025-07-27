# use a python image
FROM python:3.13.5-slim-bookworm

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
EXPOSE 10000

# execute the Flask app
HEALTHCHECK CMD curl --fail http://localhost:10000/ || exit 1
CMD ["/usr/local/bin/main.py"]
