# Based on https://github.com/microsoft/playwright/blob/master/docs/docker/Dockerfile.bionic
FROM ubuntu:bionic

# 1. Install node12
RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -y nodejs

# 2. Install WebKit dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libwoff1 \
    libopus0 \
    libwebp6 \
    libwebpdemux2 \
    libenchant1c2a \
    libgudev-1.0-0 \
    libsecret-1-0 \
    libhyphen0 \
    libgdk-pixbuf2.0-0 \
    libegl1 \
    libnotify4 \
    libxslt1.1 \
    libevent-2.1-6 \
    libgles2 \
    libvpx5 \
    libxcomposite1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libepoxy0 \
    libgtk-3-0 \
    libharfbuzz-icu0

# 3. Install gstreamer and plugins to support video playback in WebKit.
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgstreamer-gl1.0-0 \
    libgstreamer-plugins-bad1.0-0 \
    gstreamer1.0-plugins-good

# 4. Install Chromium dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libnss3 \
    libxss1 \
    libasound2 \
    fonts-noto-color-emoji \
    libxtst6

# 5. Install Firefox dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libdbus-glib-1-2 \
    libxt6

# 6. Install ffmpeg to bring in audio and video codecs necessary for playing videos in Firefox.
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg

# 7. Add user so we don't need --no-sandbox in Chromium
RUN groupadd -r pwuser && useradd -r -g pwuser -G audio,video pwuser \
    && mkdir -p /home/pwuser/Downloads \
    && chown -R pwuser:pwuser /home/pwuser

# 8. (Optional) Install XVFB if there's a need to run browsers in headful mode
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    curl \
    dumb-init

# 9. Run everything after as non-privileged user.
USER pwuser

# 10. Install Playwright
WORKDIR /home/pwuser

# Based on https://topaxi.codes/use-npm-without-root-or-sudo-rights/
RUN mkdir ~/.node && \
    touch ~/.npmrc && \
    echo "prefix = ~/.node" >> ~/.npmrc


# See https://github.com/microsoft/playwright/issues/812
RUN echo "Brace yourself this takes time" && \
    npm i -D --loglevel verbose playwright-chromium

# 11. Run it
RUN mkdir app 
RUN touch ~/.profile && \
    echo "NODE_PATH=\"$HOME/.node/lib/node_modules:$NODE_PATH\"" >> ~/.profile && \
    echo "PATH=\"$HOME/.node/bin:$PATH\""  >> ~/.profile && \
    echo "MANPATH=\"$HOME/.node/share/man:$MANPATH\""  >> ~/.profile && \
    cat ~/.npmrc && \
    cat ~/.profile

COPY . /home/pwuser/app/
WORKDIR /home/pwuser/app
CMD ["./start.sh"]
