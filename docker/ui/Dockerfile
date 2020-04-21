# Yarn setup
FROM node

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV

WORKDIR /beergarden/ui
COPY . /usr/src/app
CMD EXEC rm -rf build

CMD ["$HOME/.yarn/bin/yarn","install","--pure-lockfile","--ignore-optional"]
ENTRYPOINT ["yarn","run","build"]
