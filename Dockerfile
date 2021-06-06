FROM node:alpine

WORKDIR /usr/app

COPY package.json .

# To Fix Permissions for Packages
RUN npm config set unsafe-perm true

RUN npm install

COPY . .

RUN chown -R node:node /usr/app/node_modules

RUN npm run build
 
FROM nginx
COPY --from=0 /usr/app/build /usr/share/nginx/html