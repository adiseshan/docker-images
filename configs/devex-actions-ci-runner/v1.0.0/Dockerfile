FROM docker-remote.artifactory-ha.tmc-stargate.com/amazonlinux:2023 as buildtool

# install yamllint
RUN yum install python311 tar gzip findutils -y
RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN pip3 install yamllint==1.32.0

# install git: reviewdog's dependency
RUN dnf install git-2.40.1 -y

# install reviewdog to post comments in the PR
RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin

# remove layers and reduce the size of image.
FROM docker-remote.artifactory-ha.tmc-stargate.com/amazonlinux:2023
COPY --from=buildtool / /
