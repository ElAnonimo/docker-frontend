# this Dockefile is for production deployment

# building phase (stage)
FROM node:alpine AS builder

WORKDIR '/app'

COPY ./package.json ./
RUN yarn install
COPY ./ ./

RUN yarn run build



# serving static (previously built) files phase (stage)
FROM nginx
# AWS Elastic Beanstalk maps port 80 for outer incoming traffic to our container's port to receive it
EXPOSE 80
# `COPY --from=builder` to copy stuff from the stage called builder
# `build` is folder inside project with (built) static project assets. The 2nd path is nginx's default for serving files
COPY --from=builder /app/build /usr/share/nginx/html
# default behaviour of nginx is to start it. No need for us to issue a command to start nginx
