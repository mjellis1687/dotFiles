# Dot Files

## Installation and Basis

This approach for storing dotfiles was inspired by [https://www.atlassian.com/git/tutorials/dotfiles](https://www.atlassian.com/git/tutorials/dotfiles).

## Automatic Make Recipe Generation

### Make Alias

I added an alias for `make` to potential automatically run it with my generic Makefile. Below is a summary of the various situations that can occur:

| Makefile exists | Template Makefile exists |             Run             |
|:---------------:|:------------------------:|:---------------------------:|
|       yes       |            yes           |        Regular `make`       |
|       yes       |            no            |        Regular `make`       |
|        no       |            yes           | Make with Template Makefile |
|        no       |            no            |        Regular `make`       |

### Matlab

For automatic recipe of Matlab scripts, include a comment block starting with `% !build` and ending with `% !end-build`. For example, the following:
```matlab
% !build
% depends: src/script1.m
% to: figure.eps table.md
% !end-build
```
where:

- `depends: src/script1.m` means that the artifacts produced by the script depend on the `script1.m`. In other words, `make` will automatically reproduce the artifacts if there is a change in `script1.m` even if no changes were made to the original script. To determine the dependencies of a script, Matlab has a built-in command:
```matlab
fList = matlab.codetools.requiredFilesAndProducts('myScript.m');
for ind = 1:numel(fList)-1
	disp(fList{ind});
end
```
which produces a list of user-generated dependencies (does not include built-in or toolbox commands). The list of dependencies can be generated at the command line via:
```bash
DEPS=`matlab -batch "fList = matlab.codetools.requiredFilesAndProducts('script.m'); \
	for ind = 1:numel(fList)-1; disp(fList{ind}); end; exit;"
	| sed 's/MATLAB is selecting SOFTWARE OPENGL rendering.//'
```
This command takes some time to open Matlab and so is not included in the automatic recipe generation process. In the future, perhaps, this could be modified to find all Matlab source files and then, call Matlab once.
- `to: figure.eps table.md` means that the artifacts produced by the script are `figure.eps` and `table.md`.


### Pandoc Markdown

#### Dependencies

The recipe generation currently supports automatically adding dependencies by reading the file.

1. Figure via Pandoc Markdown
	```markdown
	![This is a figure.](fig.png)
	```
	This will add the dependency `fig.png` to the recipe
1. Figure/file via Latex command:
	```latex
	\include{file.tex}
	\includegraphics[width=0.5\columnwidth]{fig/fig.eps}
	```
1. File via `!include`:
	```markdown
	!include("file.txt")
	```
1. Input Latex command:
	```latex
	\input{file.tex}
	```

### Problems with Files with CRLF Line Terminators

- If the source file has CRLF line terminators, the recipe generation may give unexpected results.
- To check for CRLF Line Terminators, run:
```bash
file test.m
```
- If the command returns `test.m: ASCII text, with CRLF line terminators`, the file has CRLF line terminators.
- Currently, `getmakerecipe` does not automatically get rid of CRLF line terminators. There many ways to get rid of them. Here are two examples:
	1. Open source file in `vim` and run the command: `:set fileformat=unix` and save the file.
	1. Overwrite all CRLF line terminators:
	```bash
	tr '^M' '\n' <test.m >test.m
	```
	or
	```bash
	tr '\r' '\n' <test.m >test.m
	```

## Powerline Install on Arch

```bash
# pacman -S powerline powerline-fonts
# pip3 install powerline-status
```
The fonts might not work, so use the git repo.

