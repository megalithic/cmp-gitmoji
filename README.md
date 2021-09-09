# cmp-gitmoji

[nvim-cmp](https://github.com/hrsh7th/nvim-cmp) source for [gitmoji](https://gitmoji.dev)s.

# Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'gitmoji' }
  }
}
```

### Additional Setup

You might want to trigger this nvim-cmp source _only_ for `gitcommit` FileType:

__vim__:
```viml
autocmd FileType gitcommit lua require'cmp'.setup.buffer {
\   sources = {
\     { name = 'gitmoji' }
\   }
\ }
```

__lua__:
```lua
vim.cmd([[
  autocmd FileType gitcommit lua require'cmp'.setup.buffer {
  \   sources = {
  \     { name = 'gitmoji' }
  \   }
  \ }
]])
```
