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

# Ensure /opt/app-root/src and /home are writable
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
RUN useradd -m -s /bin/bash admin && echo "admin:adminpassword" | chpasswd

# Create necessary directories for the admin user
RUN mkdir -p /home/admin/notebooks && chown -R admin:admin /home/admin/notebooks

# Switch to non-root user
USER admin

# Start JupyterHub
CMD ["jupyterhub", "--config", "/opt/app-root/src/jupyterhub_config.py"]
