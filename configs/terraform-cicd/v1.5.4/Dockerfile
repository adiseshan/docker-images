# 
FROM docker-remote.artifactory-ha.tmc-stargate.com/amazonlinux:2 as buildtool

# Install aws cli
RUN yum install aws-cli -y

# Install JQ
RUN curl -L https://github.com/jqlang/jq/releases/download/jq-1.6/jq-linux64 > /usr/bin/jq && \
    chmod +x /usr/bin/jq

# # Install YQ
RUN curl -L https://github.com/mikefarah/yq/releases/download/v4.34.2/yq_linux_amd64 > /usr/bin/yq && \
    chmod +x /usr/bin/yq

# # Install GH
RUN yum install yum-utils -y
RUN yum-config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
RUN yum install gh -y

# # Install Terraform
RUN yum install -y zip unzip tar
ENV TER_VER=1.5.4
RUN curl -sSL https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip >> terraform_${TER_VER}_linux_amd64.zip \
&& unzip terraform_${TER_VER}_linux_amd64.zip \
&& mv terraform /usr/bin/terraform \
&& chmod +x /usr/bin/terraform

# # Install tfcmt
RUN curl -sSL https://github.com/suzuki-shunsuke/tfcmt/releases/download/v4.4.3/tfcmt_linux_amd64.tar.gz >> tfcmt.tar.gz \
&& tar -xf tfcmt.tar.gz \
&& mv tfcmt /usr/bin/tfcmt \
&& chmod +x /usr/bin/tfcmt

# # Install Python and Pip
RUN yum update -y
RUN yum install python3-pip -y
RUN yum install python3 -y
RUN yum install openssl -y

FROM docker-remote.artifactory-ha.tmc-stargate.com/amazonlinux:2
COPY --from=buildtool / /
