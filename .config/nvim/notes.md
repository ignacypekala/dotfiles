## Motions
### Normal mode
* gx - open url under cursor

#### Clipboard
On windows there doesn't seem to be any difference between the two, but normal yank saves the text to an unnamed register, so it isn't available across the system. 
* "+y - yank to system clipboard
* "*y - yank to primary clipboard 

### insert mode 
* ctrl+t/ctrl+d add/removim.keymap.set('n', '<leader>yy', '"+yy', {})ve indentation to the current line
* ctrl+w remove previous word (similiar to Ctrl+Backspace)

