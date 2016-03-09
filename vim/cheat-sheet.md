# Vim Cheat Sheet
> Fiete Börner

## navigation
	* `^e`	- down
	* `^y`	- up

	* `^f`	- page down (forward)
	* `^b`	- page up (backward)

	* `^d`	- page down (forward)
	* `^u`	- page up (backward)

	* `H`	- move cursor to top
	* `M`	- move cursor to middle
	* `L`	- move cursor to bottom

	* `zz`	- show current line in middle of screen

	* `^/0`	- move to beginning of line
	* `$`	- move to end of line

	* `gg`	- go top of file
	* `G`	- go to bottom of file
	* #G	- go to line #
	* gf	- go to file under cursor
	* ]]	- next section (depending on current file type) (php next function)
	* [[	- previous section
	* }		- next paragraph (blank line)
	* {		- previous paragraph
	* }}	- next block
	* {{	- previous block

	* 0		- front of line
	* ^		- first non-blank character of line
	* $		- end of line
	* %		- matching brackets/parent/tag
	* 

	* <C-i>	- jump to previous file/cursor location
	* <C-o>	- jump to nwxt file/cursor location
## text objects
	* w - beginning of next word
	* b - beginning of word
	* e - end of word
	* ge - end of previous word
	* s - sentences
	* p - paragraphs
	* t - tags
	* l - line (plugin)
	* i - indent (plugin)
	* e - entire document (plugin)
	* :help word-motions

## motions
	* a - all
	* i - in
	* t - 'til
	* f - find forward
	* F - find backward
	* / - find next sequence

## commands
	* I/A		- move to beginning/end of line and insert
	* o/O		- insert new line below/above and insert
	* x/X		- delete char under/before cursor
	* s/S		- delete char/line under cursor and end enter insert mode
	* D		- delete until end of line
	* C		- delete until end of line and enter insert mode
	* p/P 	- paste below/above
	* r		- replace one character
	* R		- enter replace mode

	* d		- delete
	* c		- delete and enable insert
	* y		- copy (yank)
	* v		- visually select
	* V		- visually line select
	* ^v	- visually column select
	* gu	- lower case movement
	* gU	- upper case movement
	* g~	- toggle case of movement
	* g?	- rot13 of movement

	* dd  - delete/cut line
	* yy  - copy line

## combination
	* diw - delete inside word (deletes current under cursor)
	* caw - same like above + enter insert mode
	* yaw - copy in word
	* yi) - copy all text inside parentheses (brackets)
	* da[ - delete all text inclusive brackets
	* dt_ - detele til "_"
	* va" - selects all in " and double quotes itself
	* vi" - selects all in "


## dot command
	* . - repeats last motion

## macro
	* q{register}
	* commands ... do things
	* q

	* @{register} - execute macro


## stuff
	* m{register} - create a mark in file
	* `{register} - jump to mark {register}

	* ^a - increments next int
	* ^x - decrease next int


## :commands
	* :split [filename] - split window horizontally and open file
	* :vsplit [filename] - split window vertically and open file
	* :ls - show current buffers

## tabs
	* tabedit [filename] 	- open file in new tab
	* tabclose 		    - close current tab
	* gt                  - go to next tab
	* gT                  - go to previous tab
	* [0-9]+gt            - go to specific tab

## completion
	* ^p		- previous completion (tag) (disabled if ctrlp is installed)
	* ^n		- next completion
	* ^x^f		- complete filepath
	* ^x^o		- complete prgramming lanuguage specific tag (omni-completion)
	* ^x^l		- line completion
	* ^x^p		- previous in context
	* ^x^n		- next in context
	* ^x^k^p	- previous dictionary entry
	* ^x^k^n	- next dictionary entry


## buffer & split
	* bd 			- buffer delete close all files
	* bp, ^^, ^6	- buffer previous
	* ls			- list all buffers
	* b[0-9]+		- change to buffer \d
	* ^w|			- set current split in fullscreen
	* ^w=			- set all splits in equal size
	* ^wo			- set current buffer to fullscreen

## register
	* :reg	- list all registers
	* "<#>	- change to register #
	* "ayy	- yank line to register a
	* "bp	- paste register b content

## tabs
	* tabnew <filename>		- open tab and create new file
	* tabe[dit] <filename>	- open tab and edit file
	* gt or :tabn[ext]		- next tab
	* gT or :tabp[revious]	- previous tab
	* tabm[ove] #			- move tab to position (zero-index)
	* tabo[nly]				- close all other tabs except current
	* tabc[lose]			- close current tab

## spell checking
	* :setlocal spell! spelllang=en_us
	* ]s	- go to next misspelling
	* [s	- go to previous misspelling
	* zg	- add the current misspelling to the dictonary in spellfile variable
	* zG	- add current word to internal word list (all changes are lost after closing vim)
	* zw	- add current word as misspelled to the dictonary in spellfile variable
	* zW	- add current word as misspelled to internal word list
	* z=	- show a list of possible ment words
	* zug	- zuw zuG zuW	Löscht das Wort unter dem Cursor aus der entsprechenden Liste


## marks
	* m<letter>	- create mark with <letter> as key
	* ma		- create mark a (lower case letter can only accessed in file)
	* mA		- create mark A (upper case letter can be accessed from elsewhere)
	* 'a		- jump to line where mark a was set
	* `a		- jump to cursor position of mark a
	* d'a		- delete all from cursor to (including) marked line

## plug ins
	*	**vim surrounding**
	*	ysiw"	- set current word in " quotes
	*	ys$"	- set from cursor to line end in " quotes
	*	VS<html>- set the <html> tag around current line
	*	cs"'	- change " quotes to ' quotes
	*	dst		- delete surrounding tags

