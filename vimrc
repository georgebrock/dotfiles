syntax on

set background=dark
colorscheme solarized

set list  " Shows invisible characters
set listchars=tab:▸\ ,eol:¬
set expandtab  " Use spaces, not tabs
set tabstop=4 softtabstop=4 shiftwidth=4  " Default tab size
set showcmd  " Show the current command in the footer
set ruler  " Show line and col numbers in footer
set modeline
set ls=2
set ai  " Auto-indent!
set number  " Show line numbers
set hlsearch  " Highlight the current search term
set incsearch  " Incremental searching
set colorcolumn=80
set wildmode=longest,list

set wildignore+=*.pyc

if has("autocmd")
  autocmd BufNewFile,BufRead *.ru setfiletype ruby
  autocmd BufNewFile,BufRead *.css.erb,*.spriter setfiletype css
  autocmd BufNewFile,BufRead *.mkd,*.md,*.markdown setfiletype markdown
  autocmd BufNewFile,BufRead *.json setfiletype javascript
  autocmd BufNewFile,BufRead *.ejs setfiletype html

  autocmd Filetype html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype htmldjango setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype eruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype haml setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype cucumber setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd Filetype make setlocal noexpandtab

  autocmd Filetype markdown setlocal spell textwidth=80
  autocmd Filetype gitcommit setlocal spell textwidth=80
  autocmd Filetype mail setlocal spell textwidth=80
endif

map! 3 #

nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

noremap 1 :tabnext 1<CR>
noremap 2 :tabnext 2<CR>
noremap 3 :tabnext 3<CR>
noremap 4 :tabnext 4<CR>
noremap 5 :tabnext 5<CR>
noremap 6 :tabnext 6<CR>
noremap 7 :tabnext 7<CR>
noremap 8 :tabnext 8<CR>
noremap 9 :tablast<CR>

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-endwise'
Bundle 'edsono/vim-matchit'
Bundle 'scrooloose/syntastic'

map <leader>t :call ExecuteInITerm("clear; ".TestCmd())<CR>
map <leader>T :call ExecuteInITerm("clear; ".TestCmd().":".line("."))<CR>
map <leader>r :call ExecuteInITerm("clear; ".AllTestsCmd())<CR>
map <leader><leader> :call RepeatInITerm()<CR>
map <leader>ct :silent !ctags -R .<CR>:redraw!<CR>
map <leader>/ :nohlsearch<CR>
map <leader>m :silent !open -a Marked %<CR>:redraw!<CR>

command! -nargs=+ ITerm :call ExecuteInITerm(<q-args>)
command! -nargs=+ Rake :call ExecuteInITerm("rake ".<q-args>)

function! ExecuteInITerm(cmd)
    let t:last_iterm_cmd = a:cmd
    execute(":silent !iterm '".a:cmd."'")
    redraw!
endfunction

function! RepeatInITerm()
    if (exists("t:last_iterm_cmd"))
        call ExecuteInITerm(t:last_iterm_cmd)
    else
        echo "ExecuteInITerm hasn't been called yet, can't repeat it"
    endif
endfunction

function! TestCmd()
    let l:file = expand("%")
    if (match(l:file, ".feature$") != -1)
        return SpringCmd("spring cucumber", "cucumber")." ".l:file
    elseif (match(l:file, "_spec.rb$") != -1)
        return SpringCmd("spring rspec", "rspec")." ".l:file
    elseif (match(l:file, ".rb$") != -1)
        return SpringCmd("spring test", "ruby -Itest")." ".l:file
    elseif (match(l:file, ".py$") != -1)
        return "nosetests ".l:file
    endif
endfunction

function! AllTestsCmd()
    return SpringCmd("spring rake", "rake")
endfunction

function! SpringCmd(spring_version, default_version)
    return "$(if [[ -z `which spring` ]]; then echo \"".a:default_version."\"; else echo \"".a:spring_version."\"; fi)"
endfunction
