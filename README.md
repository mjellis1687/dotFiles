# Dot Files

## Automatic Make Recipe Generation

### Matlab

For automatic recipe of Matlab scripts, include a comment block starting with `% !build` and ending with `% !end-build`. For example, the following:
```matlab
% !build
% DEPENDS: src/script1.m
% !end-build
```
where:

- `DEPENDS: src/script1.m` means that the artifacts produced by the script depend on the `script1.m`. Make will automatically reproduce the artifacts if there is a change in `script1.m` even if no changes were made to the original script. Matlab has a built-in command to determine the dependencies of a script:
```matlab
fList = matlab.codetools.requiredFilesAndProducts('myScript.m');
for ind = 1:numel(fList)-1
	disp(fList{ind});
end
```
which produces a list of user-generated dependencies (does not include built-in or toolbox commands). The list of dependencies can be generated at the command line via:
```bash
DEPS=`matlab -batch "fList = matlab.codetools.requiredFilesAndProducts('script.m');
	for ind = 1:numel(fList)-1; disp(fList{ind}); end; exit;"
	| sed 's/MATLAB is selecting SOFTWARE OPENGL rendering.//'
```
This command takes some time to open Matlab and so is not included in the automatic recipe generation process. In the future, perhaps, this could be modified to find all Matlab source files and then, call Matlab once.


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

## Powerline Install on Arch

```bash
# pacman -S powerline powerline-fonts
# pip3 install powerline-status
```
The fonts might not work, so use the git repo.

