FROM ubuntu:bionic
LABEL author="nam nguyen"
LABEL author_email="thanhnam.it@gmail.com"

# Prvent dpkg error
ENV TERM=xterm-256color

# Set mirrors to AU
RUN sed -i "s/http:\/\/archive./http:\/\/au.archive./g" /etc/apt/sources.list

# ADD PPA repo and Install python runtime 
RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python3 virtualenv python3-virtualenv python3-pip default-libmysqlclient-dev
  
# Create virtual environment
RUN virtualenv -p python3 /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade


# Add entrypoint script
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh 
ENTRYPOINT [ "entrypoint.sh" ]