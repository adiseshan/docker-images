# version v2.39.1
FROM amazonlinux:2023 as buildtool

# # Install GH
RUN dnf install 'dnf-command(config-manager)' -y
RUN dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
RUN dnf install gh-2.39.1 -y

FROM amazonlinux:2
COPY --from=buildtool / /
