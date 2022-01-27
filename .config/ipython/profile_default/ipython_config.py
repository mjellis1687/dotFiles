# Configuration file for ipython.

#------------------------------------------------------------------------------
# InteractiveShellApp(Configurable) configuration
#------------------------------------------------------------------------------

## A Mixin for applications that start InteractiveShell instances.
#
#  Provides configurables for loading extensions and executing files as part of
#  configuring a Shell environment.
#
#  The following methods should be called by the :meth:`initialize` method of
#  the subclass:
#
#    - :meth:`init_path`
#    - :meth:`init_shell` (to be implemented by the subclass)
#    - :meth:`init_gui_pylab`
#    - :meth:`init_extensions`
#    - :meth:`init_code`

## lines of code to run at IPython startup.
c.InteractiveShellApp.exec_lines = ['%load_ext autoreload', '%autoreload 2']

#------------------------------------------------------------------------------
# InteractiveShell(SingletonConfigurable) configuration
#------------------------------------------------------------------------------

## Set the color scheme (NoColor, Neutral, Linux, or LightBG).
c.InteractiveShell.colors = 'LightBG'

#------------------------------------------------------------------------------
# TerminalInteractiveShell(InteractiveShell) configuration
#------------------------------------------------------------------------------

## Set the editor used by IPython (default to $EDITOR/vi/notepad).
c.TerminalInteractiveShell.editor = 'vim'

#------------------------------------------------------------------------------
