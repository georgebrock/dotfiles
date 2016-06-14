syntax on

set list  " Shows invisible characters
set listchars=tab:▸\ ,eol:¬
set expandtab  " Use spaces, not tabs
set tabstop=2 softtabstop=2 shiftwidth=2  " Default tab size
set showcmd  " Show the current command in the footer
set ruler  " Show line and col numbers in footer
set modeline  " Read modelines from files
set laststatus=2  " Show status line (filename, etc.) always in all windows
set number
set relativenumber  " Show line numbers
set hlsearch  " Highlight the current search term
set incsearch  " Incremental searching
set colorcolumn=80
set cursorline " Highlight the line the cursor is on
set wildmode=longest,list
set complete+=kspell " Autocomplete with dictionary words when spell check is on
set splitright
set splitbelow
set nojoinspaces

set wildignore+=*.pyc

filetype plugin on
filetype indent on

augroup georgebrock
  autocmd!

  autocmd BufNewFile,BufRead *.ru setfiletype ruby
  autocmd BufNewFile,BufRead *.css.erb,*.spriter setfiletype css
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.json setfiletype javascript
  autocmd BufNewFile,BufRead *.ejs,*.hbs setfiletype html
  autocmd BufNewFile,BufRead *.go setfiletype go
  autocmd BufNewFile,BufRead *.slim setfiletype slim
  autocmd BufNewFile,BufRead *.ex,*.exs set filetype=elixir

  autocmd Filetype python setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd Filetype make,automake setlocal noexpandtab
  autocmd Filetype go setlocal noexpandtab

  autocmd Filetype markdown setlocal spell textwidth=80
  autocmd Filetype gitcommit,mail setlocal spell textwidth=76 colorcolumn=77
augroup END

map! 3 #
nmap r3 r#
map! - –

noremap 1 :tabnext 1<CR>
noremap 2 :tabnext 2<CR>
noremap 3 :tabnext 3<CR>
noremap 4 :tabnext 4<CR>
noremap 5 :tabnext 5<CR>
noremap 6 :tabnext 6<CR>
noremap 7 :tabnext 7<CR>
noremap 8 :tabnext 8<CR>
noremap 9 :tablast<CR>

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-rails'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-endwise'
Plugin 'edsono/vim-matchit'
Plugin 'git@github.com:thoughtbot/vim-magictags.git'
Plugin 'jnwhiteh/vim-golang'
Plugin 'nono/vim-handlebars'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'slim-template/vim-slim'
Plugin 'elixir-lang/vim-elixir'
call vundle#end()

set background=dark
colorscheme solarized

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers=['flake8']

map <leader>g :silent !gitsh<CR>:redraw!<CR>
map <leader>t :call ExecuteInShell("clear; ".TestCmd())<CR>
map <leader>T :call ExecuteInShell("clear; ".TestCmd().":".line("."))<CR>
map <leader>d :call ExecuteInShell("clear; ".DjangoTestCmd())<CR>
map <leader>r :call ExecuteInShell("clear; ".AllTestsCmd())<CR>
map <leader>M :call ExecuteInShell("clear; make")<CR>
map <leader><leader> :call RepeatInShell()<CR>
map <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
map <leader>/ :nohlsearch<CR>
map <leader>m :silent !open -a Marked %<CR>:redraw!<CR>
map <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
map <leader>b :call ToggleBackground()<CR>
map <leader>2 :setlocal tabstop=2 softtabstop=2 shiftwidth=2<CR>
map <leader>4 :setlocal tabstop=4 softtabstop=4 shiftwidth=4<CR>

xnoremap . :normal .<CR> " . command in visual mode
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

command! -nargs=+ Shell :call ExecuteInShell(<q-args>)
command! -nargs=+ Rake :call ExecuteInShell("rake ".<q-args>)

function! ExecuteInShell(cmd)
    let t:last_shell_cmd = a:cmd
    if (system("tmux list-panes | wc -l | grep -Eo '(\\d+)'") > 1)
        execute(":silent !tmuxsend '".a:cmd."'")
    else
        execute(":!".a:cmd)
    endif
    redraw!
endfunction

function! RepeatInShell()
    if (exists("t:last_shell_cmd"))
        call ExecuteInShell(t:last_shell_cmd)
    else
        echo "ExecuteInShell hasn't been called yet, can't repeat it"
    endif
endfunction

function! TestCmd()
    let l:file = expand("%:.")
    if (match(l:file, ".feature$") != -1)
        return "cucumber ".l:file
    elseif (match(l:file, "_spec.rb$") != -1)
        return "rspec ".l:file
    elseif (match(l:file, ".rb$") != -1)
        return SpringCmd("testunit", "ruby -Itest")." ".l:file
    elseif (match(l:file, ".py$") != -1)
        return "nosetests ".l:file
    elseif (match(l:file, "_spec.js.coffee$") != -1)
        return "teaspoon ".l:file
    elseif (match(l:file, ".test.coffee$") != -1)
        return "PATH=\"$(npm bin):$PATH\" mocha ".l:file
    elseif (match(l:file, ".exs") != -1)
        return "mix test ".l:file
    endif
endfunction

function! DjangoTestCmd()
  let l:file = expand("%:.")
  let l:module = substitute(substitute(l:file, "/", ".", "g"), "\.py$", "", "")
  return "python manage.py test ".l:module
endfunction

function! AllTestsCmd()
    return SpringCmd("spring rake", "rake")
endfunction

function! SpringCmd(spring_version, default_version)
    return "$(if [[ -z `which spring` ]]; then echo \"".a:default_version."\"; else echo \"".a:spring_version."\"; fi)"
endfunction

function! ToggleBackground()
    if &background == "light"
        set background=dark
    else
        set background=light
    endif
endfunction
