# Base image with Python 3.12 on Debian Bookworm
FROM python:3.12-bookworm

# Install system dependencies
USER root
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install JupyterHub and necessary dependencies
RUN pip install --no-cache-dir \
    jupyterhub \
    notebook

# Install configurable-http-proxy
RUN npm install -g configurable-http-proxy

# Ensure /opt/app-root/src and /home are writable (fix permission issue)
RUN mkdir -p /opt/app-root/src && chmod -R 777 /opt/app-root/src
RUN chmod 777 /home

# Set working directory
WORKDIR /opt/app-root/src

# Copy JupyterHub config file
COPY jupyterhub_config.py /opt/app-root/src/jupyterhub_config.py
RUN chmod 644 /opt/app-root/src/jupyterhub_config.py

# Expose JupyterHub port
EXPOSE 8000

# Ensure system users exist
RUN useradd -m -s /bin/bash testuser && echo "testuser:testpassword" | chpasswd
RUN useradd -m -s /bin/bash admin && echo "admin:adminpassword" | chpasswd

RUN mkdir -p /home/admin && chown 1000:0 /home/admin && chmod 777 /home/admin

# Switch to non-root (for security)
USER 1000

# Start JupyterHub
CMD ["jupyterhub", "--config", "/opt/app-root/src/jupyterhub_config.py"]
