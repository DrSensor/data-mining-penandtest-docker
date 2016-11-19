FROM ubuntu:latest
MAINTAINER Fahmi Akbar Wildana <fahmi.akbar.w@mail.ugm.ac.id>

RUN apt-get update \
    && apt-get install -y curl openssh-server \
    build-essential git

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get install -y nodejs node \
    pylint virtualenv \
    python3-dev python3-pip \
    python-pip python-dev

RUN npm install npm -g
RUN pip install -U pip && pip3 install -U pip

# RUN rm -rf /usr/local/lib/node_modules \
#     && rm -rf ~/.npm \

RUN npm install -g pm2 \
    ddos-stress images-scraper \
    phantomjs nightmare
RUN pip install ImageScraper GoogleScraper

RUN git clone https://github.com/scrapinghub/portia /app/portia && \
    cd /app/portia && \
    provision.sh install_deps install_splash \
    install_python_deps configure_nginx cleanup \

ENV PYTHONPATH /app/portia/slybot:/app/portia/slyd
EXPOSE 9001

WORKDIR /app/portia
CMD service nginx start; bin/slyd -p 9002 -r /app/portia/slyd/dist
