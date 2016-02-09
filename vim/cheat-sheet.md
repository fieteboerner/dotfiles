navigation
	^e - down
	^y - up

	^f - page down (forward)
	^b - page up (backward)
	
	H - move cursor to top
	M - move cursor to middle
	L - move cursor to bottom

	^/0 - move to beginning of line
	$   - move to end of line
	I/A - move to beginning/end of line and insert
	o/O - insert new line below/above and insert

	gg - go top of file
	G - go to bottom of file

text objects
	w - beginning of next word
	e - end of word
	s - sentences
	p - paragraphs
	t - tags

motions
	a - all
	i - in
	t - 'til
	f - find forward
	F - find backward

commands
	d   - delete
	c   - delete and enable insert
	y   - copy (yank)
	v   - visually select
	V   - visually line select
	^v  - visually column select
	dd  - delete/cut line
	yy  - copy line
	zz  - show current line in middle of screen
	D   - delete until end of line
	C   - delete until end of line and enter insert mode
	p/P - paste below/above

combination
	diw - delete inside word (deletes current wird under cursor)
	caw - same like above + enter insert mode
	yaw - copy in word
	yi) - copy all text inside parantheses (brackets)
	da[ - delete all text inclusive brackets
	dt_ - detele til _
	va" - selects all in " and double quotes itself
	vi" - selects all in "


dot command
	. - repeats last motion

macro
	q{register}
	commands ... do things
	q

	@{register} - execute macro


stuff
	m{register} - create a mark in file
	`{register} - jump to mark {register}

	^a - increments next int


:commands
	:split [filename] - split window horizontally and open file
	:vsplit [filename] - split window vertically and open file
	:ls - show current buffers

tabs
	tabedit [filename] 	- open file in new tab
	tabclose 		    - close current tab
    gt                  - go to next tab
    gT                  - go to previous tab
    [0-9]+gt            - go to specific tab
buffer & split
	bd 			- buffer delete close all files
	bp, ^^, ^6	- buffer previous 
	ls			- list all buffers
	b[0-9]+			- change to buffer \d
	^w|			- set current split in fullscreen
	^w=			- set all splits in equal size
    ^wo         - set current buffer to fullscreen
