# Pull the Base Image for python
FROM python:3.14.6-slim

# Select the Working Directory in the container
WORKDIR /Fake_Store_API_ETL

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Command to run the application
CMD [ "python" , "./main.py" ]