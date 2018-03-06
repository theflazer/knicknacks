FROM phusion/baseimage

RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
UN git clone git@github.com:altitudelabs/champsys.gitupm git curl yarn

RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN npm cache clean -f
RUN npm install -g n

WORKDIR /root
RUN touch .ssh/known_hosts
ADD deploy_key .ssh/id_rsa
RUN chmod 400 .ssh/id_rsa
RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> .ssh/config
RUN git clone git@github.com:altitudelabs/champsys.git

WORKDIR ./champsys
RUN git fetch --all
RUN git checkout fix-docker-run
RUN n $(cat .nvmrc)
RUN yarn install --ignore-scripts
RUN mkdir client/dist
RUN touch client/dist/favicon.ico

ENTRYPOINT ["/sbin/my_init", "npm"]
CMD ["run", "start-prod"]

