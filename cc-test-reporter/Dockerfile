FROM alpine

LABEL maintainer="lc.adilson@gmail.com"

# I wish I didn't have to add git to this image
# because it jumps from ~33kb to ~47kb
RUN apk add curl git

RUN curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-linux-amd64 > /usr/local/bin/cc-test-reporter
RUN chmod +x /usr/local/bin/cc-test-reporter

COPY reporter.sh /usr/local/bin/reporter.sh
RUN chmod +x /usr/local/bin/reporter.sh

ENTRYPOINT [ "/usr/local/bin/reporter.sh" ]
