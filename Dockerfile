FROM ubuntu:latest
MAINTAINER Fahmi Akbar Wildana <fahmi.akbar.w@mail.ugm.ac.id>

RUN apt-get update \
    && apt-get install -y curl openssh-server \
    build-essential git

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash -

RUN apt-get install -y nodejs \
    pylint virtualenv \
    python3-dev python3-pip \
    python-pip python-dev

# RUN npm install npm -g
RUN pip install -U pip && pip3 install -U pip

# RUN rm -rf /usr/local/lib/node_modules \
#     && rm -rf ~/.npm \
#     && apt-get purge -y nodejs \
#     && apt-get install -y nodejs

RUN npm install -g pm2 pm2-web \
    ddos-stress images-scraper \
    nightmare phantomjs
RUN pip3 install ImageScraper GoogleScraper

EXPOSE 9000

CMD ['pm2-web']
