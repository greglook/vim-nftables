augroup nftables
    autocmd!
    autocmd BufRead,BufNewFile *.nft,nftables.conf setfiletype nftables
augroup END
