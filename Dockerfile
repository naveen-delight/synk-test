FROM python:3.12.0a5-slim

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Create a new user and set a password
RUN useradd -m -s /bin/bash myuser && echo "myuser:mypassword" | chpasswd

# Optionally, add the user to the sudo group (if needed)
RUN usermod -aG sudo myuser

# copy project
COPY . /app/

EXPOSE 8000

CMD ["python3", "pygoat/manage.py" ,"runserver", "127.0.0.1:8000"]
