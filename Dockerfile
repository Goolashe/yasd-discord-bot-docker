FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
    python3.10 \
    python3-pip \
    git-all

RUN pip install --upgrade pip
RUN pip install virtualenv

WORKDIR /app

ENV BOT_TOKEN=YOUR_DISCORD_BOT_TOKEN
ENV GUILD=YOUR_GUILD_ID

RUN echo "Cloning Project" && git clone https://github.com/Goolashe/yasd-discord-bot-docker

RUN cd /app/yasd-discord-bot-docker \
    python3.10 -m virtualenv env \
    source env/bin/activate

RUN cd /app/yasd-discord-bot-docker && pip install -r requirements_nsfw_filter.txt

# symlink to mount output images and such to host
RUN mkdir -p /images/ && ln -s /images/ /app/images
RUN mkdir -p /image_docarrays/ && ln -s /image_docarrays/ /app/image_docarrays
RUN mkdir -p /temp_json/ && ln -s /temp_json/ /app/temp_json

COPY entrypoint.sh /app/
RUN chmod 0775 /app/entrypoint.sh

RUN cd /usr/bin && ln -s python3.10 /usr/bin/python

CMD /bin/bash -C entrypoint.sh