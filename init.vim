
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
  \| endif

set tabstop=4 softtabstop=4
set smartindent
set exrc
set guicursor=
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set completeopt=menuone,noinsert,noselect
set signcolumn=yes

"Give more space for displaying messages"
set cmdheight=2

set updatetime=50

set shortmess+=c

call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'gruvbox-community/gruvbox'

"vsnip"
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'hrsh7th/cmp-vsnip'
Plug 'dcampos/cmp-snippy'

"nvim-cmp"
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

call plug#end()



set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
    local cmp = require'cmp'

      cmp.setup({
          snippet = {
           -- REQUIRED - you must specify a snippet engine
           expand = function(args)
             vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
           end,
           },
           window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                   },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
                { name = 'cmp_tabnine' },
              }, {
                { name = 'buffer' },
              })
            })

EOF

highlight Normal guibg=none

let mapleader = " "
nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<C>


let g:gruvbox_transparent = 1
let g:gruvbox_improved_warnings = 1
colorscheme gruvbox

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun



augroup Brock
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

