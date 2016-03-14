Vim Cheat Sheet
===============

Navigation
----------

| Key     | Description                                         |
|---------|-----------------------------------------------------|
| `^e`    | scroll line down                                    |
| `^y`    | scroll line up                                      |
| `^f`    | scroll page forward                                 |
| `^b`    | scroll page upwards                                 |
| `^d`    | scroll (half) page downwards                        |
| `^u`    | scroll (half) page upwards                          |
| `H`     | move cursor to top of screen                        |
| `M`     | move cursor to middle of screen                     |
| `L`     | move cursor to bottom of screen                     |
| `zz`    | show current line in middle of screen               |
| `zt`    | show current line on top of screen                  |
| `zb`    | show current line on bottom of screen               |
| `gg`    | go top of file                                      |
| `G`     | go to bottom of file                                |
| `#G`    | go to line #                                        |
| `gf`    | go to file under cursor                             |
| `%`     | jump between matching bracket/brace/parentheses/tag |
| `<C-i>` | jump to previous file/cursor location               |
| `<C-o>` | jump to next file/cursor location                   |

Manipulation
------------

| Key   | Description                                                |
|-------|------------------------------------------------------------|
| `I/A` | move to beginning/end of line and enter insert  mode       |
| `o/O` | insert new line below/above and enter insert mode          |
| `x/X` | delete char under/before cursor                            |
| `s/S` | delete char/line under cursor and end enter insert mode    |
| `D`   | delete from cursor until end of line                       |
| `C`   | delete from cursor until end of line and enter insert mode |
| `p/P` | paste (before/below)/(after/above) cursor                  |
| `r`   | replace one character with the following character         |
| `R`   | enter replace mode                                         |
| `dd`  | delete/cut line                                            |
| `yy`  | copy line                                                  |

Commands
--------

| Key  | Description                |
|------|----------------------------|
| `d`  | delete                     |
| `c`  | delete and enable insert   |
| `y`  | copy (yank)                |
| `v`  | visual select              |
| `V`  | visual line select         |
| `^v` | visual column/block select |
| `gu` | lower case                 |
| `gU` | upper case                 |
| `g~` | toggle case                |
| `g?` | rot13                      |

Word, Object and left right Motion
----------------------------------

:help word-motions

:help object-motions

:help left-right-motion

| Key  | Description                                                       |
|------|-------------------------------------------------------------------|
| `w`  | beginning of next word                                            |
| `b`  | beginning of word                                                 |
| `e`  | end of word                                                       |
| `ge` | end of previous word                                              |
| `s`  | sentences                                                         |
| `p`  | paragraphs                                                        |
| `t`  | tags                                                              |
| `]]` | next section (depending on current file type) (php next function) |
| `[[` | previous section                                                  |
| `}`  | next paragraph (blank line)                                       |
| `{`  | previous paragraph                                                |
| `0`  | front of line                                                     |
| `^`  | first non-blank character of line                                 |
| `$`  | to end of line                                                    |
| `l`  | line (plugin)                                                     |
| `i`  | indent (plugin)                                                   |
| `e`  | entire document (plugin)                                          |

Text Objects
------------

:help text-objects

| Key | Description        |
|-----|--------------------|
| `a` | all                |
| `i` | in                 |
| `t` | 'un**t**il         |
| `f` | find forward       |
| `F` | find backward      |
| `/` | find next sequence |



Combination (Examples)
----------------------

| Key   | Description                                       |
|-------|---------------------------------------------------|
| `diw` | delete inside word (deletes current under cursor) |
| `caw` | same like above + enter insert mode               |
| `aw`  | copy in word                                      |
| `yi)` | copy all text inside parentheses (brackets)       |
| `da[` | delete all text inclusive brackets                |
| `dt_` | delete un**t**il `_`                              |
| `va"` | selects all in " and double quotes itself         |
| `vi"` | selects all in "                                  |


Dot command
-----------

The `.` command repeats the last change made in normal mode.

| Key | Description        |
|-----|--------------------|
| `.` | repeat last motion |

Macro
-----

Record macro:

    q{register}
    do something
    q

`@{register}` "execute macro

Completion
----------

The completion mode works only in insert mode.

| Key      | Description                                                  |
|----------|--------------------------------------------------------------|
| `^p`     | previous completion (tag)                                    |
| `^n`     | next completion                                              |
| `^x^f`   | complete file path                                           |
| `^x^o`   | complete programming language specific tag (omni-completion) |
| `^x^l`   | line completion                                              |
| `^x^p`   | previous in context                                          |
| `^x^n`   | next in context                                              |
| `^x^k^p` | previous dictionary entry                                    |
| `^x^k^n` | next dictionary entry                                        |


Buffer & Split
--------------

| Key                | Description                             |
|--------------------|-----------------------------------------|
| `:bd`              | buffer delete close all files           |
| `:bp,^^,^6`        | buffer previous                         |
| `:ls`              | list all buffers                        |
| `:b[0-9]+`         | change to buffer \d                     |
| :split [filename]  | split window horizontally and open file |
| :vsplit [filename] | split window vertically and open file   |
| `^w`               | set current split in full screen        |
| `^w=`              | set all splits in equal size            |
| `^wo`              | set current buffer to full screen       |

Register
--------

| Key    | Description                |
|--------|----------------------------|
| `:reg` | list all registers         |
| `"<#>` | change to register #       |
| `"ayy` | yank line to register a    |
| `"bp`  | paste register `b` content |

Tabs
----

| Key                      | Description                         |
|--------------------------|-------------------------------------|
| `:tabnew <filename>`     | open tab and create new file        |
| `:tabe[dit] <filename>`  | open tab and edit file              |
| `:tabm[ove] #`           | move tab to index # (zero-index)    |
| `:tabo[nly]`             | close all other tabs except current |
| `:tabc[lose]`            | close current tab                   |
| `gt` or `:tabn[ext]`     | next tab                            |
| `gT` or `:tabp[revious]` | previous tab                        |
| `#gt`                    | go to specific tab                  |

Spell Checking
--------------

`:setlocal spell! spelllang=en_us`

| Key   | Description                                                                     |
|-------|---------------------------------------------------------------------------------|
| `]s`  | go to next misspelling                                                          |
| `[s`  | go to previous misspelling                                                      |
| `zg`  | add the current misspelling to the dictionary in spell file variable            |
| `zG`  | add current word to internal word list (all changes are lost after closing vim) |
| `zw`  | add current word as misspelled to the dictionary in spell file variable         |
| `zW`  | add current word as misspelled to internal word list                            |
| `z=`  | show a list of possible meant words                                             |
| `zug` | `zuw zuG zuW` deletes the word under cursor and from spell list                 |

Marks
-----

| Key         | Description                                                      |
|-------------|------------------------------------------------------------------|
| `m<letter>` | create mark with <letter> as key                                 |
| `ma`        | create mark a (lower case letter can only accessed in file)      |
| `mA`        | create mark A (upper case letter can be accessed from elsewhere) |
| `'a`        | jump to line where mark a was set                                |
| ``a`        | jump to cursor position of mark a                                |
| `d'a`       | delete all from cursor to (including) marked line                |

Miscellaneous
-------------

| Key  | Description            |
|------|------------------------|
| `u`  | undo                   |
| `U`  | undo last changed line |
| `^r` | redo                   |
| `^a` | increments next int    |
| `^x` | decrease next int      |

Plugins
-------

### Vim Surrounding

| Key        | Description                             |
|------------|-----------------------------------------|
| `ysiw"`    | set current word in " quotes            |
| `ys$"`     | set from cursor to line end in " quotes |
| `VS<html>` | set the <html> tag around current line  |
| `cs"'`     | change " quotes to ' quotes             |
| `dst`      | delete surrounding tags                 |

