FROM bitriseio/docker-bitrise-base:latest

# Set environment variables for image
ENV SWIFT_SNAPSHOT swift-3.0.1-RELEASE
ENV SWIFT_SNAPSHOT_LOWERCASE swift-3.0.1-release
ENV UBUNTU_VERSION ubuntu14.04
ENV UBUNTU_VERSION_NO_DOTS ubuntu1404
ENV WORK_DIR /usr/local

# Set WORKDIR
WORKDIR ${WORK_DIR}

# Install required Ubuntu dependencies
RUN apt-get install -y clang libcurl4-openssl-dev libpython2.7 && apt-get clean
RUN wget http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu52_52.1-3ubuntu0.4_amd64.deb && dpkg -i libicu52_52.1-3ubuntu0.4_amd64.deb && rm libicu52_52.1-3ubuntu0.4_amd64.deb

# Install Swift compiler
RUN wget --no-check-certificate https://swift.org/builds/$SWIFT_SNAPSHOT_LOWERCASE/$UBUNTU_VERSION_NO_DOTS/$SWIFT_SNAPSHOT/$SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz \
    && tar xzvf $SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz \
    && rm $SWIFT_SNAPSHOT-$UBUNTU_VERSION.tar.gz

ENV PATH $WORK_DIR/$SWIFT_SNAPSHOT-$UBUNTU_VERSION/usr/bin:$PATH

# Reset the WORKDIR back to the original one
WORKDIR /bitrise/src
