" Key bindings for VHDL
" ---
"  Automatize some vhdl development actioins.

function! vhdl#maplist(l, fnc)
  let lr = []
  for elem in l
    call add(lr, fnc(elem))
  endfor
  return lr
endfunc

function! vhdl#componentSnippet()
  let p_input   = ""
  let cont      = 0

  let component_name = input("Component name: ")
  if strlen(component_name) > 0 
    let component = ["component " . component_name]
  else
    let component = ['component top']
  endif

  
  " GENERICS
  let generics = []
  while true
    let p_input_a = input("generic name [EOF to finish]: ")
    let p_input_b = input("generic type [EOF to finish]: ")
    if p_input_a == "EOF" || p_input_b == "EOF"
      break
    endif
    call add(generics, p_input_a . '\t\t: ' . p_input_b . ';')
  endwhile

  if len(generics) > 0
    call add(generics, ' is generic(')
    for g in generics
      call add(component, g)
    endfor
  endif

  " PORTS
  let generics = []
  while true
    let p_input_a = input("generic name [EOF to finish]: ")
    let p_input_b = input("generic type [EOF to finish]: ")
    if p_input_a == "EOF" || p_input_b == "EOF"
      break
    endif
    call add(generics, p_input_a . '\t\t: ' . p_input_b . ';')
  endwhile

  if len(generics) > 0
    call add(generics, ' is generic(')
    for g in generics
      call add(component, g)
    endfor
  endif
endfunc

function! vhdl#entitySnippet()
endfunc

function! vhdl#architectureSnippet()
endfunc

function! vhdl#forLoopSnippet()
endfunc

function! vhdl#forGenerateSnippet()
endfunc


function! vhdl#snippetParser(snippet)
  " Process target snippet line by line.
  " For each line inserts the content after being processed in the cursor
  " position incrementally.
  "  
  " + It accepts the control flow statements if else, for and until.
  " + Everything else is considered a variable and will be replaced by the
  "   user input.
  " --
  " @param snippet list

  if type(snippet) != type([])
    echoerr 'Snippet call failed: snippet should be a list of elements'
  endif

  for lne in snippet
    let endpos = 0
    while match(lne, '\$[a-zA-Z][a-zA-Z0-9_\-]\+', endpos)
      let lne_prev = lne
      let [mdata, startpos, endpos] = 
            \ matchstrpos(lne, '\$[a-zA-Z][a-zA-Z0-9_\-\{\}]+', endpos)

      if mdata[1] == '{'
        if mdata[2:3] == 'if'
          call processIf(mdata[2:])
        elseif mdata[2:4] == 'for'
          call processFor(mdata[2:])
        elseif mdata[2:len('until')+2] == 'until'
          call processUntil(mdata[2:])
        else

        endif
      endif

    endwhile
  endfor
endfunc

function! sniffet#PutSnippet(snip)
endfunc
