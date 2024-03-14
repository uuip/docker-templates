c = get_config()

c.ServerApp.allow_remote_access = True
c.ServerApp.allow_root = True
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.password = ""
c.ServerApp.password_required = True
c.ServerApp.port = 7000
c.ServerApp.terminado_settings = {
        "shell_command": ['bash', '-c',
                          "sed -i -r s'/(PS1=.*?)\\\\h(.*)/\\1jupyterlab\\2/g' ~/.bashrc;export PROMPT_DIRTRIM=2;bash"]
        }
