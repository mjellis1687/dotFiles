# Command Cheat Sheet

## Git Commands

### Diffs and Checkouts
- Uncommitted file to HEAD
```bash
$ git diff <path>
```
- Uncommitted file to before last commit
```bash
$ git diff HEAD^ -- <filename>
```
- Diff between current and last commit
```bash
$ git diff HEAD^ HEAD -- <filename>
```
- Difference between HEAD and n-th grandparent
```
$ git diff HEAD~n HEAD -- <filename>
```
- Another cool feature is `whatchanged` command
```bash
$ git whatchanged -- <filename>
```
- Checkout file from different branch
```bash
$ git checkout <branch_name> file
```

### Branches
- Delete local branch
```bash
$ git branch -d <branch_name>
```
- Delete local branch if the branch contains unmerged contains
```bash
$ git branch -D <branch_name>
```
- Delete remote branch
```bash
$ git push origin --delete <branch_name>
```
- Create a new branch
```bash
$ git checkout -b <branch_name>
```
- Merge changes to a single file from another branch
```bash
$ git checkout --patch <branch_name> file
```

### Commits
- Undo a commit and redo
```bash
$ git commit -m "Something terribly misguided"
$ git reset HEAD~
$ git add ...
$ git commit -c ORIG_HEAD
```

## Vim commands

### Movements

- Move viewpoint down - `Ctrl+Y`
- Move viewpoint up - `Ctrl+E`
- Move to the end of the line - `$`
- Move to the last non-block character of the line - `g`
- Move to the first non-block character of the line - `^`
- Move to tag under cursor - `^]`
- Use `g^]` for ambiguous tags
- Use `^t` to jump back up the tag stack
- `gi` switches to insertion mode placing the cursor at the same location it was previously
- `g;` puts the cursor at the place an edit was made
- `ge` go to the end of the previous word

### Files and Searching

- Search down into subfolders. Provide tab-completion for all file-related tasks
```bash
set path+=**
```
- With above, we can: hit tab to :find by partial match and use * to make it fuzzy
- :b lets you autocomplete any open buffer (without tab)
- Display all matching files when we tab complete
```bash
set wildmenu
```
- Create the tages file (may need to install ctags first)
```bash
command! MakeTags !ctags -R .
```
- Find the next/previous occurrence of variable under cursor: `*`/`#`

### Editing

- Lowercase line: `guu`
- Uppercase line: `gUU`
- Invert case: `~`
- Swap next two characters around: `xp`
- Increment, decrement next number on same line as the cursor: `Ctrl+A,Ctrl+X`
- (Re)indent the text on the current line or on the area selected: `=`
- (Re)indent the current braces { ... }: `=%`
- Auto (re)indent entire document: `G=gg`

## Bash Commands

### Compressed files
- Create a `.tar.gz` file
```bash
$ tar -cvzf file file.tar.gz
```
- Extract `.tar.gz` file
```bash
$ tar -xvzf example.tar.gz
```

### Find and Grep

- Find word in files - returns line numbers
```bash
$ find . -type f -exec grep -n "word" {} \;
```
- Find word in files - returns line numbers and filename
```bash
$ find . -type f -exec grep -Hn "word" {} \;
```
- Recursively find files with extension
```bash
$ find . -type f -name ".<file_type>"
```

## tmux
- Create a new tab: Ctrl + B, C
- Move to next/previous tab: Ctrl + B, N/P
- Move window: 
	- Let window number 3 and window number 1 swap positions: 
	```swap-window -s 3 -t 1```
	- Swap the current window with the top window, do:
	```swap-window -t 0```
	- Move current window back three:
	```swap-window -t -3```
