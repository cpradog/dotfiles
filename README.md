# cpradog dotfiles project

Over the years I had countless versions of my dotfiles. It wasn't until a few years
ago that I tried to organize them and setup some kind of "install" script and use
VCS to store them.

This is the first time I treat my dotfiles like a project, with some tests and
deployment and decommission scripts.

## File organization

| File/folder | Description                                       |
|-------------|---------------------------------------------------|
| /dotfiles   | entry-point; allow install or uninstall packages  |
| /run-tests  | run all available tests                           |
| /tools      | utilities used by other parts of the project      |
| /test       | testing framework and project tests               |
| /lib/base   | some core functions to make everything work       |
| /lib/output | helper functions to log during execution          |
| /lib/files  | file management functions like link/unlink files  |
| /lib/xdg    | helper functions to calculate XDG compliant paths |
| /lib/zsh    | helper functions to configure zsh                 |
| /packages   | repository of configuration packages              |

## Zsh configuration

The biggest part of this project is zsh configuration. I'm a heavy user of
the terminal and most of my configuration is focus on integrate each
application in my workflow, a part of application specific stuff.

### zshrc / zshenv

/lib/zsh contains the functions to add or remove customization from
zsh files.

For each zsh configuration file there is a .d directory in zsh local data
directory:

- $HOME/.local/share/zsh/rc.d; zshrc customizations
- $HOME/.local/share/zsh/env.d; zshenv customizations

*zsh_add_rc* link the specified file into rc.d directory and regenerate
zshrc file.
*zsh_del_rc* unlink the specified file from rc.d directory and regenerate
zshrc file.
*zsh_add_env* link the specified file into env.d directory and regenerate
zshenv file.
*zsh_del_env* unlink the specified file from env.d directory and regenerate
zshenv file.

### antidote

Zsh plugins are managed with antidote. As with configuration files, there
are similar functions (*zsh_add_plugin*, *zsh_del_plugin*) to
register/unregister a plugin and update scripts.
