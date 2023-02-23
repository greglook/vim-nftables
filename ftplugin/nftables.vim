if exists('b:did_ftplugin')
    finish
endif

setlocal smartindent nocindent
setlocal commentstring=#%s
setlocal comments=b:#

setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
setlocal textwidth=99

let b:did_ftplugin = 1
