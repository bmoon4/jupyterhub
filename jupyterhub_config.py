# Configuration file for JupyterHub
import os

# Use a simple authenticator (No authentication, for local testing)
c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'

# Allow users to access JupyterHub without needing to create system users
c.PAMAuthenticator.create_system_users = True

# Set the default notebook directory (change this if using persistent storage)
c.Spawner.notebook_dir = '/opt/app-root/src/notebooks'

# Run JupyterHub on port 8000 (default)
c.JupyterHub.port = 8000

# Allow any user to log in (good for testing, change in production)
c.Authenticator.admin_users = {'admin'}
c.Authenticator.allowed_users = set()

# Set the log level to DEBUG for troubleshooting
c.JupyterHub.log_level = 'DEBUG'

# Enable admin access
c.JupyterHub.admin_access = True

# Configure spawner (SingleUserNotebookApp for each user)
c.Spawner.default_url = '/lab'  # Open JupyterLab instead of classic notebook

# Use LocalProcessSpawner (runs single-user servers locally)
c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'

# Where to store user notebooks (mount a persistent volume here if needed)
c.Spawner.args = ['--NotebookApp.default_url=/lab']
