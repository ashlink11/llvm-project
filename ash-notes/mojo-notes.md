# https://docs.modular.com/mojo/

 systems programming and metaprogramming

 Instead of downloading the Mojo SDK, you can also experiment with Mojo in our hosted Jupyter notebook environment called Mojo Playground. This is a hosted version of JupyterLab that’s running our latest Mojo kernel.

 The number of vCPU cores available in your cloud instance may vary,

 If you want to keep any edits to the included notebooks, rename the notebook files. These files will reset upon any server refresh or update, sorry. So if you rename the files, your changes will be safe.

You can use %%python at the top of a notebook cell and write normal Python code. Variables, functions, and imports defined in a Python cell are available for access in subsequent Mojo cells.

The Mojo environment does not have network access, so you cannot install other tools or Python packages. However, we’ve included a variety of popular Python packages, such as numpy, pandas, and matplotlib (see how to import Python modules).

Redefining implicit variables is not supported (variables without a let or var in front). If you’d like to redefine a variable across notebook cells, you must introduce the variable with var (let variables are immutable).

You can’t use global variables inside functions—they’re only visible to other global variables.

For a longer list of things that don’t work yet or have pain-points, see the Mojo roadmap and sharp edges.

You must set the MODULAR_HOME and PATH environment variables, as described in the output when you ran modular install mojo. For example, if you’re using bash or zsh, add the following lines to your configuration file (.bash_profile, .bashrc, or .zshrc):

```bash
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"
```

Then source the file you just updated, for example:

`source ~/.bash_profile`

`PATH`: Specifies directories where executable programs are located.
`HOME`: Specifies the user's home directory.
`TEMP` or `TMP`: Specifies the directory for temporary files.
`USERNAME`: Specifies the currently logged-in user's username.
`LANG`: Specifies the language and localization settings.