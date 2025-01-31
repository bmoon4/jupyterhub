import os

# Use DummyAuthenticator for testing (any username can log in)
c.JupyterHub.authenticator_class = 'dummy'
c.DummyAuthenticator.password = "password"  # All users use this password

# Use LocalProcessSpawner (each user gets their own process)
c.JupyterHub.spawner_class = 'simple'

# Allow admin access
c.Authenticator.admin_users = {"admin"}
c.Authenticator.allowed_users = set()

# Ensure the required JUPYTERHUB_SERVICE_URL is set
c.Spawner.env_keep = ['JUPYTERHUB_SERVICE_URL']

# Manually set JUPYTERHUB_SERVICE_URL if missing
if "JUPYTERHUB_SERVICE_URL" not in os.environ:
    os.environ["JUPYTERHUB_SERVICE_URL"] = "http://localhost:8081/hub/"

# Notebook directory for users
c.Spawner.notebook_dir = '~/notebooks'
c.Spawner.args = ['--NotebookApp.default_url=/tree']

# Set the log level for debugging
c.JupyterHub.log_level = 'DEBUG'
c.Spawner.cmd = ['/usr/local/bin/jupyterhub-singleuser']
