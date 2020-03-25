set-option global tabstop 2
set-option global indentwidth 0

# Yes, this weird slash is really necessary, don't touch it
add-highlighter global/ number-lines -relative
colorscheme gruvbox

# Config stuff
map global normal <c-k> ":edit ~/.config/kak/kakrc <ret>"
map global normal <c-p> ":edit ~/.config/kak-lsp/kak-lsp.toml <ret>"

map global normal <c-l> :bn<ret>
map global normal <c-h> :bp<ret>
map global normal <c-w> :db<ret>


# In case we're using LSPs
eval %sh{kak-lsp --kakoune -s $kak_session}

# If shit goes bad
eval %sh{ (kak-lsp -vvv) > /tmp/kak-lsp.log 2>&1 < /dev/null & }

set-option global lsp_insert_spaces true
