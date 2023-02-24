" Vim syntax file
" Language:     nftables config syntax
" Maintainer:   Greg Look
" Filenames:    *.nft
" Version:      1.0

" Quit when a syntax file was already loaded.
if exists("b:current_syntax")
    finish
endif

" Allow alphanumeric, hyphen, and underscores in keywords
syntax iskeyword @,48-57,-,_

" Special keywords
syntax keyword nftSpecial flush ruleset

" Variable definitions
syntax match nftVariableDefine /^\s*define *\S\+/ contains=nftDefineKeyword,nftVariableName
syntax keyword nftDefineKeyword define contained
syntax match nftVariableName /[a-zA-Z0-9_-]\+/ contained
syntax match nftVariableRef /\$[a-zA-Z0-9_-]\+/ containedin=ALL


" Table definitions
syntax region nftTableBlock matchgroup=nftDeclare start=/^\s*table / end=/^\s*}/me=e-1 fold contains=nftDelimiter
syntax match nftTableHeader /\(table \+\)\@<=\S\+ \+\S\+ *{/ contained containedin=nftTableBlock contains=nftDelimiter
syntax keyword nftTableFamily ip6 ip inet arp bridge netdev contained containedin=nftTableHeader nextgroup=nftTableName skipwhite
syntax match nftTableName /[a-zA-Z0-9-_]\+/ contained containedin=nftTableHeader


" Set definitions
syntax region nftSetBlock matchgroup=nftDeclare start=/^\s*set / end=/^\s*}/me=e-1 fold contained containedin=nftTableBlock
syntax match nftSetHeader /\(set \+\)\@<=\S\+ *{/ contained containedin=nftSetBlock contains=nftDelimiter
syntax match nftSetName /[a-zA-Z0-9_-]\+/ contained containedin=nftSetHeader
syntax match nftSetRef /@[a-zA-Z0-9_-]\+/ containedin=ALL

syntax match nftSetType /^\s*type .*$/ contained containedin=nftSetBlock contains=nftSetTypeKeyword
" TODO: contains expression
syntax match nftSetType /^\s*typeof .*$/ contained containedin=nftSetBlock
syntax keyword nftSetTypeKeyword ipv4_addr ipv6_addr ether_addr inet_proto inet_service mark ifname contained

syntax match nftSetFlags /^\s*flags .*$/ contained containedin=nftSetBlock contains=nftSetFlagKeyword
syntax keyword nftSetFlagKeyword constant interval timeout contained

syntax match nftSetPolicy /^\s*policy .*$/ contained containedin=nftSetBlock contains=nftSetPolicyKeyword
syntax keyword nftSetPolicyKeyword performance memory contained

syntax match nftSetSize /^\s*size/ contained containedin=nftSetBlock nextgroup=nftNumber skipwhite
syntax match nftSetGCInterval /^\s*gc-interval/ contained containedin=nftSetBlock nextgroup=nftDuration skipwhite
syntax match nftSetTimeout /^\s*timeout/ contained containedin=nftSetBlock nextgroup=nftDuration skipwhite
syntax match nftSetCounter /^\s*counter/ contained containedin=nftSetBlock
syntax match nftSetComment /^\s*comment/ contained containedin=nftSetBlock nextgroup=nftString skipwhite

syntax region nftSetElements start=/^\s*elements *= *{/ end=/}/ keepend contained containedin=nftSetBlock contains=nftDelimiter
syntax keyword nftSetElementsKeyword elements contained containedin=nftSetElements
" TODO: better definition of set element values here


" TODO: Map definitions


" Chain definitions
syntax region nftChainBlock matchgroup=nftDeclare start=/^\s*chain / end=/^\s*}/me=e-1 fold contained containedin=nftTableBlock
syntax match nftChainHeader /\(chain \+\)\@<=\S\+ *{/ contained containedin=nftChainBlock contains=nftDelimiter
syntax match nftChainName /[a-zA-Z0-9-_]\+/ contained containedin=nftChainHeader

syntax match nftChainRule /^\s*.\+$/ contained containedin=nftChainBlock contains=nftDelimiter,nftNumber,nftString,nftDuration
syntax keyword nftMatch iif iifname oif oifname ip ip6 tcp udp udplite sctp dccp ah esp comp icmp icmpv6 ether dst frag hbh mh rt vlan arp ct meta contained containedin=nftChainRule
"syntax keyword nftMatch saddr daddr sport dport protocol state  contained containedin=nftChainRule
syntax keyword nftStatement queue continue return dnat snat masquerade log counter limit contained containedin=nftChainRule
syntax keyword nftStatement jump goto nextgroup=nftChainName contained containedin=nftChainRule
syntax keyword nftStatementDrop drop reject nextgroup=nftChainName contained containedin=nftChainDeclaration,nftChainRule
syntax keyword nftStatementAccept accept nextgroup=nftChainName contained containedin=nftChainDeclaration,nftChainRule

syntax match nftChainDeclaration /^\s*type .*$/ contained containedin=nftChainBlock contains=nftDelimiter,nftNumber
syntax keyword nftChainKeyword type hook device priority policy contained containedin=nftChainDeclaration
syntax keyword nftChainKeyword policy contained containedin=nftChainDeclaration nextgroup=nftChainPolicyKeyword skipwhite
syntax keyword nftChainType filter route nat contained containedin=nftChainDeclaration
syntax keyword nftHookType ingress prerouting input forward output postrouting contained containedin=nftChainDeclaration


" General matches
syntax match nftDelimiter /[{};]/
syntax match nftNumber /[^a-z]\@<=-\?\d\+/
syntax region nftString start=/"/ end=/"/
" TODO: gross, is there a better way to do this?
syntax match nftDuration /\d\+d\(\d\+h\)\?\(\d\+m\)\?\(\d\+s\)\?\|\d\+h\(\d\+m\)\?\(\d\+s\)\?\|\d\+m\(\d\+s\)\?\|\d\+s/

syntax region nftComment start=/^\s*#/ end=/$/ containedin=ALL
syntax keyword nftTodo contained containedin=nftComment TODO FIXME XXX NOTE


" Highlighting
highlight def link nftDelimiter Special
highlight def link nftNumber Constant
highlight def link nftString Constant
highlight def link nftDuration Constant
highlight def link nftComment Comment
highlight def link nftTodo TODO
highlight def link nftSpecial Special
highlight def link nftDeclare Define

highlight def link nftDefineKeyword Define
highlight def link nftVariableName Identifier
highlight def link nftVariableRef Identifier

highlight def link nftTableHeader Define
highlight def link nftTableFamily Type
highlight def link nftTableName Identifier

highlight def link nftSetHeader Define
highlight def link nftSetName Identifier
highlight def link nftSetRef Identifier
highlight def link nftSetType Define
highlight def link nftSetTypeKeyword Type
highlight def link nftSetElementsKeyword Define
highlight def link nftSetFlags Define
highlight def link nftSetFlagKeyword Type
highlight def link nftSetPolicy Define
highlight def link nftSetPolicyKeyword Type
highlight def link nftSetSize Define
highlight def link nftSetGCInterval Define
highlight def link nftSetTimeout Define
highlight def link nftSetCounter Define
highlight def link nftSetComment Define

highlight def link nftChainHeader Define
highlight def link nftChainName Identifier
highlight def link nftChainKeyword Define
highlight def link nftChainType Type
highlight def link nftHookType Type

highlight nftMatch ctermfg=yellow
highlight nftStatement ctermfg=blue
highlight nftStatementDrop ctermfg=red
highlight nftStatementAccept ctermfg=green


" Syntax syncing
syntax sync fromstart

let b:current_syntax = "nftables"
