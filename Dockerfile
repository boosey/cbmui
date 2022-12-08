#Stage 1 - Install dependencies and build the app
FROM debian:latest AS build-env

# Install flutter dependencies
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
# RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v
# Enable flutter web
RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter --version

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN flutter pub get 
RUN flutter build web \
  --dart-define=PROJECTS_BASE_URL=https://cebrowserapi.dal1a.ciocloud.nonprod.intranet.ibm.com/ \
  --dart-define=ASSIGNMENTS_BASE_URL=https://cebrowserapi.dal1a.ciocloud.nonprod.intranet.ibm.com/

# # Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build-env /app/build/web /usr/share/nginx/html
RUN chgrp -R 0 /usr && \
  chmod -R g=u /usr && \
  chown -R 1001:0 /usr && \
  chgrp -R 0 /var && \
  chmod -R g=u /var && \
  chown -R 1001:0 /var && \  
  chgrp -R 0 /var/run && \
  chmod -R g=u /var/run && \
  chown -R 1001:0 /var/run && \
  chgrp -R 0 /etc/nginx && \
  chmod -R g=u /etc/nginx && \
  chown -R 1001:0 /etc/nginx  

USER 1001