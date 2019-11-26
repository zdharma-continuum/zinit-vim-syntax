" Copyright (c) 2019 Sebastian Gniazdowski
"
" Syntax highlighting for Zplugin commands in any file of type `zsh'.
" It adds definitions for the Zplugin syntax to the ones from the
" existing zsh.vim definitions-file.

" Main Zplugin command.
" Should be the only TOP rule for the whole syntax.
syntax match ZpluginCommand     /\<zplugin\>\s/me=e-1
            \ skipwhite
            \ nextgroup=ZpluginSubCommands,ZpluginPluginSubCommands,ZpluginSnippetSubCommands
            \ contains=ZpluginSubCommands,ZpluginPluginSubCommands,ZpluginSnippetSubCommands

" TODO: add options for e.g. light
syntax match ZpluginSubCommands /\s\<\%(ice\|compinit\|env-whitelist\|cdreplay\|cdclear\|update\)\>\s/ms=s+1,me=e-1
            \ contained

syntax match ZpluginPluginSubCommands /\s\<\%(light\|load\)\>\s/ms=s+1,me=e-1
            \ skipwhite nextgroup=ZpluginPlugin1,ZpluginPlugin2,ZpluginPlugin3
            \ contains=ZpluginPlugin1,ZpluginPlugin2,ZpluginPlugin3

syntax match ZpluginSnippetSubCommands /\s\<\%(snippet\)\>\s/ms=s+1,me=e-1
            \ skipwhite
            \ nextgroup=ZpluginSnippetShorthands1,ZpluginSnippetShorthands2
            \ contains=ZpluginSnippetShorthands1,ZpluginSnippetShorthands2

" "user/plugin"
syntax match ZpluginPlugin1 /\s["]\%([!-_]*\%(\/[!-_]\+\)\+\|[!-_]\+\)["]/ms=s+1,hs=s+2,he=e-1
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" 'user/plugin'
syntax match ZpluginPlugin2 /\s[']\%([!-_]*\%(\/[!-_]\+\)\+\|[!-_]\+\)[']/ms=s+1,hs=s+2,he=e-1
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" user/plugin
syntax match ZpluginPlugin3 /\s\%([!-_]*\%(\/[!-_]\+\)\+\|[!-_]\+\)/ms=s+1,me=e+2 
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" OMZ:: or PZT::
" TODO: 'OMZ:: or 'PZT::
syntax match ZpluginSnippetShorthands1 /\s\<\%(\%(OMZ\|PZT\)\>::\|\)/hs=s+1,he=e-2
            \ contained
            \ skipwhite
            \ nextgroup=ZpluginSnippetUrl1,ZpluginSnippetUrl2
            \ contains=ZpluginSnippetUrl1,ZpluginSnippetUrl2

" "OMZ:: or "PZT::
syntax match ZpluginSnippetShorthands2 /\s["]\%(\%(OMZ\|PZT\)\>::\|\)/hs=s+2,he=e-2
            \ contained
            \ skipwhite
            \ nextgroup=ZpluginSnippetUrl3,ZpluginSnippetUrl4
            \ contains=ZpluginSnippetUrl3,ZpluginSnippetUrl4

syntax match ZpluginSnippetUrl3 /\<\%(http:\/\/\|https:\/\/\|ftp:\/\/\|\$HOME\|\/\)[!-_]\+\%(\/[!-_]\+\)*\/\?["]/he=e-1
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" TODO: Fix ZpluginTrailingWhiteSpace not matching
syntax match ZpluginSnippetUrl4 /\%(\%(OMZ\|PZT\)::\)[!-_]\+\%(\/[!-_]\+\)*\/\?["]/hs=s+5,he=e-1
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" http://… or https://… or ftp://… or $HOME/… or /…
" TODO: Fix $HOME/… and /… not matching
syntax match ZpluginSnippetUrl1 /\<\%(http:\/\/\|https:\/\/\|ftp:\/\/\|\$HOME\|\/\)[!-_]\+\%(\/[!-_]\+\)*\/\?/
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

" TODO: Fix ZpluginTrailingWhiteSpace not matching
syntax match ZpluginSnippetUrl2 /\<\%(\%(OMZ\|PZT\)::\)[!-_]\+\%(\/[!-_]\+\)*\/\?/hs=s+5
            \ contained
            \ nextgroup=ZpluginTrailingWhiteSpace
            \ contains=ZpluginTrailingWhiteSpace

syntax match ZpluginTrailingWhiteSpace /[[:space:]]\+$/ contained

" TODO: differentiate the no-value ices
" TODO: use contained
syntax match ZpluginIceSubCommand /\sice\s/ms=s+1,me=e-1 nextgroup=ZpluginIceModifiers
syntax match ZpluginIceModifiers  /\s\<\%(svn\|proto\|from\|teleid\|bindmap\|cloneopts\|id-as\|depth\|if\|wait\|load\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(unload\|blockf\|on-update-of\|subscribe\|pick\|bpick\|src\|as\|ver\|silent\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(lucid\|notify\|mv\|cp\|atinit\|atclone\|atload\|atpull\|nocd\|run-atpull\|has\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(cloneonly\|make\|service\|trackbinds\|multisrc\|compile\|nocompile\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(nocompletions\|reset-prompt\|wrap-track\|reset\|aliases\|sh\|bash\|ksh\|csh\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(\!sh\|\!bash\|\!ksh\|\!csh\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(blockf\|silent\|lucid\|trackbinds\|cloneonly\|nocd\|run-atpull\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
syntax match ZpluginIceModifiers  /\s\<\%(nocompletions\|svn\|sh\|\\!sh\|bash\|\\!bash\|ksh\|\\!ksh\|csh\|\\!csh\|aliases\|trigger-load\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
            
" Include also ices added by the existing annexes
syntax match ZpluginIceModifiers  /\s\<\%(test\|zman\|submod\|dl\|patch\|fbin\|sbin\|fsrc\|ferc\|fmod\|gem\|node\|rustup\|cargo\)\>\([[:space:]'"]\|\>\)/ms=s+1,me=e-1
        
" Additional Zsh and Zplugin functions
syntax match ZshAndZpluginFunctions     /\<\%(compdef\|compinit\|zpcdreplay\|zpcdclear\|zpcompinit\|zpcompdef\)\>/

" Link
highlight def link ZshAndZpluginFunctions    Keyword
highlight def link ZpluginCommand            Statement
highlight def link ZpluginSubCommands        Title
highlight def link ZpluginPluginSubCommands  Title
highlight def link ZpluginSnippetSubCommands Title
highlight def link ZpluginIceModifiers       Type
highlight def link ZpluginSnippetShorthands1 Keyword
highlight def link ZpluginSnippetShorthands2 Keyword
highlight def link ZpluginPlugin1            Macro
highlight def link ZpluginPlugin2            Macro
highlight def link ZpluginPlugin3            Macro
highlight def link ZpluginSnippetUrl1        Macro
highlight def link ZpluginSnippetUrl2        Macro
highlight def link ZpluginSnippetUrl3        Macro
highlight def link ZpluginSnippetUrl4        Macro
highlight def link ZpluginTrailingWhiteSpace Error
