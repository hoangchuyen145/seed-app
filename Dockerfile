FROM node:18-alpine as angular

WORKDIR /app

COPY package*.json ./

RUN npm install --force
# RUN npm install -g @angular/cli

COPY . .
RUN npm run build --configuration=production

FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# COPY ./entrypoint.sh /usr/bin/entrypoint.sh
# RUN chmod +x /usr/bin/entrypoint.sh

# WORKDIR /usr/bin

COPY --from=angular /app/dist/seed-app /usr/share/nginx/html

EXPOSE 80

# CMD ["nginx", "-g", "daemon off;"]
# "build": "ng build --base-href=/seed-app/ --deploy-url=/seed-app/ --configuration production",
