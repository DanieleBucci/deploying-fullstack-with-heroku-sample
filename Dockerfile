# FROM node:12-alpine as build
# WORKDIR /usr/src/build
# COPY . .
# RUN npm install
# CMD ["node", "app.js"]

FROM node:12
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
CMD [ "node", "app.js" ]