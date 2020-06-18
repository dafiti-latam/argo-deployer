FROM alpine:3.8

RUN addgroup -S deployer && adduser -S deployer -G deployer

RUN apk add --no-cache git curl bash jq \
  && wget -q -O /usr/bin/yq $(wget -q -O - https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets[] | select(.name == "yq_linux_amd64") | .browser_download_url') \
  && curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v1.6.0/argocd-linux-amd64 \
  && chmod +x /usr/bin/yq /usr/local/bin/argocd

USER deployer