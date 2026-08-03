FROM mcr.microsoft.com/devcontainers/base:2-debian12 AS toolchain
# hadolint
ARG HADOLINT_URL "https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64"
RUN wget -q -O /usr/local/bin/hadolint ${HADOLINT_URL} --no-check-certificate && chmod +x /usr/local/bin/hadolint
# diff-highlight
WORKDIR /usr/share/doc/git/contrib/diff-highlight
RUN make

# ==================================================

FROM mcr.microsoft.com/devcontainers/base:ubuntu

RUN apt-get update -qq \
    && apt-get install -qq -y --no-install-recommends \
    # bash
    shellcheck \
    shfmt \
    # utilities
    peco \
    silversearcher-ag \
    vim \
    && apt-get clean\
    &&  rm -rf /var/lib/apt/lists/*# hadolint for docker

COPY --from=toolchain /usr/local/bin/hadolint /usr/local/bin/hadolint
# diff-highlight
COPY --from=toolchain /usr/share/doc/git/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight

