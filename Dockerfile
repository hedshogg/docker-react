# step 1 of 2 - known as builder
FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build

# step 2 of 2, install the output from builder into nginx
FROM nginx

# Use the output from the previous step (/app/build) and copy it to the nginx container's default content directory (as found in the docker hub notes for nginx)
COPY --from=builder /app/build /usr/share/nginx/html

# Note, there's no CMD here as we're re-using the nginx default
