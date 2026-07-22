# Pull the Base Image for python
FROM python:3.12-slim

# Install prerequisites (from microsoft official documents)
RUN apt-get update &&\
apt-get install -y curl &&\
# Download the package to configure the Microsoft repo
curl -sSL -O https://packages.microsoft.com/config/debian/$(grep VERSION_ID /etc/os-release | cut -d '"' -f 2 | cut -d '.' -f 1)/packages-microsoft-prod.deb &&\
# Install the package
dpkg -i packages-microsoft-prod.deb &&\
# Delete the file
rm packages-microsoft-prod.deb &&\
apt-get update &&\
ACCEPT_EULA=Y apt-get install -y msodbcsql18 &&\
apt-get install -y libgssapi-krb5-2 &&\
apt-get clean &&\
rm -rf /var/lib/apt/lists/*
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