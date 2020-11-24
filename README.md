# Dot Files

## Automatic Makefile Recipe Generation

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

