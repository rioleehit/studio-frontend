FROM node:16

USER root
RUN apt-get update
RUN apt-get install -y vim
RUN npm i -g npm@8.x.x

WORKDIR /prebuilt
COPY config/ config/
COPY src/ src/
COPY package.json .
COPY package-lock.json .
COPY edx-edx-bootstrap-1.0.4.tgz edx-edx-bootstrap-1.0.4.tgz
RUN npm install ./edx-edx-bootstrap-1.0.4.tgz --save
COPY edx-paragon-20.18.1.tgz edx-paragon-20.18.1.tgz
RUN npm install ./edx-paragon-20.18.1.tgz --save
RUN npm install

WORKDIR /studio-frontend
ENTRYPOINT cp -r /prebuilt/node_modules /studio-frontend/ && \
    npm install && \
    npm run start

EXPOSE 18011
