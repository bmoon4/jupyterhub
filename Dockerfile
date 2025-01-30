# Base image with Python 3.12 on Debian Bookworm
FROM python:3.12-bookworm

# Set environment variables
ENV NB_USER=jovyan \
    NB_UID=1000 \
    NB_GID=100 \
    HOME=/opt/app-root/src

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
    jupyterlab \
    notebook \
    && npm install -g configurable-http-proxy

# Ensure OpenShift/Kubernetes can run the container with a random UID
RUN mkdir -p ${HOME} && \
    chown -R 1000:0 ${HOME} && \
    chmod -R 777 ${HOME}

# Set working directory
WORKDIR ${HOME}

# Generate a default JupyterHub config
# RUN jupyterhub --generate-config -f ${HOME}/jupyterhub_config.py
COPY jupyterhub_config.py /opt/app-root/src/jupyterhub_config.py
RUN chown 1000:0 /opt/app-root/src/jupyterhub_config.py && chmod 644 /opt/app-root/src/jupyterhub_config.py
# Expose JupyterHub port
EXPOSE 8000

# Switch to a non-root user (for Kubernetes security)
USER 1000

# Start JupyterHub
CMD ["jupyterhub", "--config", "/opt/app-root/src/jupyterhub_config.py"]
