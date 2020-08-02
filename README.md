# browserless


## Usage

```
docker build --tag browserless . && \
docker run --rm -e "TERM=xterm-256color" -p 9229:9229 -p 5900:5900 --cap-add=SYS_ADMIN browserless
# Try VNC 127.0.0.1:5900

# Copy sources to the current directory
rsync -rv --exclude=.git /home/arkady/browserless/. .


```

## Links
* http://www.smartjava.org/content/using-puppeteer-in-docker/
* https://blog.logrocket.com/how-to-set-up-a-headless-chrome-node-js-server-in-docker/
* https://paul.kinlan.me/hosting-puppeteer-in-a-docker-container/
* https://vsupalov.com/headless-chrome-puppeteer-docker/
* https://github.com/puppeteer/puppeteer
* https://github.com/buildkite/docker-puppeteer
* https://developers.google.com/web/updates/2017/04/headless-chrome
* https://chromium.googlesource.com/chromium/src/+/lkgr/headless/README.md
* https://github.com/Zenika/alpine-chrome#image-disk-size
* https://playwright.dev/#
* https://blog.logrocket.com/playwright-vs-puppeteer/
* https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#setting-up-chrome-linux-sandbox
* https://github.com/mafredri/cdp