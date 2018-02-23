# Docker container for all lint checks for the Nubis project
# docker run -it -v $(pwd):/nubis/files nubis-travis

FROM alpine:3.6
MAINTAINER Jason Crowe <jcrowe@mozilla.com>

# Install runtime dependencies
RUN apk add --no-cache \
    bash \
    findutils \
    file \
    ruby \
    ruby-rdoc \
    ruby-irb

# Install build dependencies
#+ Cleanup apk cache files
RUN apk add --no-cache --virtual .build-dependencies \
    build-base \
    curl \
    ruby-dev \
    && rm -f /var/cache/apk/APKINDEX.*

# puppet-lint requires ruby ruby-rdoc ruby-irb
# jsonlint requires ruby ruby-rdoc ruby-irb ruby-dev build-base
# mdl requires ruby ruby-rdoc ruby-irb
RUN gem install puppet-lint \
    && gem install jsonlint \
    && gem install mdl \
    && curl -o shellcheck-latest.linux.x86_64.tar.xz \
    https://storage.googleapis.com/shellcheck/shellcheck-latest.linux.x86_64.tar.xz \
    && tar -xvf shellcheck-latest.linux.x86_64.tar.xz \
    && mkdir -p /nubis/bin \
    && mv shellcheck-latest/shellcheck /nubis/bin/shellcheck \
    && rm -rf shellcheck-latest shellcheck-latest.linux.x86_64.tar.xz

# Remove build dependencies
RUN apk del .build-dependencies

COPY [ "run-checks", "/nubis/bin/" ]
COPY [ "style.rb", "/nubis/" ]
WORKDIR /nubis/files
ENV PATH /nubis/bin:$PATH
ENTRYPOINT [ "run-checks" ]
