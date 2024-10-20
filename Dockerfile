# Build a container image to emulate a freshly installed Ubuntu Desktop
# for testing the Ansible playbooks.

ARG UBUNTU_VERSION="24.04"
FROM ubuntu:${UBUNTU_VERSION}

# We use ARG instead of ENV to avoid this showing up when the container is running.
ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update \
  && apt-get install -yyq \
    ubuntu-desktop-minimal \
    ubuntu-minimal \
    ubuntu-standard

# Create the main user, as if the installer had done it.
RUN useradd \
  --create-home \
  blah

# Allow passwordless sudo. Makes testing easier.
RUN echo 'blah ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/no-passwd-blah

# Everything runs as the main user
USER blah:blah
