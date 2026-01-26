# Development container for Jekyll blog
# Based on Debian Bookworm with Ruby 3.3

FROM ruby:3.3-bookworm

# Build arguments
ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Environment for bundler
ENV BUNDLE_PATH=/bundle/vendor \
    BUNDLE_BIN=/bundle/vendor/bin \
    GEM_HOME=/bundle/vendor \
    LANG=en_US.UTF-8

# Install essential tools
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    vim \
    less \
    sudo \
    locales \
    && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# Create non-root user with sudo access
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME \
    && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /bundle /workspace \
    && chown -R $USERNAME:$USERNAME /bundle /workspace

# Install bundler (2.x is stable, 4.x has bugs)
RUN gem install bundler:2.5.23

# Switch to dev user
USER $USERNAME
WORKDIR /home/$USERNAME

# Add bundle bin to PATH
RUN echo 'export PATH="/bundle/vendor/bin:$PATH"' >> ~/.bashrc

# Set working directory
WORKDIR /workspace

# Default command keeps container running
CMD ["sleep", "infinity"]
