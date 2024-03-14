c = get_config()
c.Authenticator.admin_users = {"root", "ubuntu"}
c.PAMAuthenticator.open_sessions = False
c.Spawner.args = ["--ContentsManager.root_dir=/app"]
