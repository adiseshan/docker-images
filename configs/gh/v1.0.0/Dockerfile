# version v2.37.0
FROM amazonlinux:2 as buildtool

# # Install GH
RUN yum install yum-utils -y
RUN yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
RUN yum install gh-2.37.0-1 -y

FROM amazonlinux:2
COPY --from=buildtool / /
