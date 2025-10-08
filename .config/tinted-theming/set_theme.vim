function! ColorschemeExists(theme)
    try
        execute 'colorscheme ' . a:theme
        return 1
    catch
        return 0
    endtry
endfunction

if strlen('tomorrow-night') > 0 && (!exists('g:colors_name') || g:colors_name != 'base16-tomorrow-night') && ColorschemeExists('base16-tomorrow-night')
  colorscheme base16-tomorrow-night
endif
