# building phase (stage)
FROM node:alpine AS builder

WORKDIR '/app'

COPY ./package.json ./
RUN yarn install
COPY ./ ./

RUN yarn run build



# serving static (previously built) files phase (stage)
FROM nginx
# `--copy` for copy stuff from the stage called =...
# `build` is folder with built static project assets
COPY --from=builder /app/build /usr/share/nginx/html
# default behaviour of nginx is to start it. No need for us to issue a command to start nginx
