function IdrisReload()
  let tc = system("idris --client :r")
  if (! (tc is ""))
    echo tc
  endif
  return tc
endfunction

function IdrisShowType()
  let word = expand("<cword>")
  let tc = IdrisReload()
  if (! (tc is ""))
    echo tc
  else
    let ty = system("idris --client :t " . word)
    echo ty
  endif
  return tc
endfunction

function IdrisCaseSplit()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload()

  if (tc is "")
    let fn = "idris --client :cs! " . cline . " " . word
    let result = system(fn)
    if (! (result is "")) 
       echo result
    else
      e
      call winrestview(view)
    endif
  endif
endfunction

function IdrisMakeWith()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload()

  if (tc is "")
    let fn = "idris --client :mw! " . cline . " " . word
    let result = system(fn)
    if (! (result is "")) 
       echo result
    else
      e
      call winrestview(view)
      call search("_")
    endif
  endif
endfunction

function IdrisAddClause()
  let view = winsaveview()
  w
  let cline = line(".")
  let word = expand("<cword>")
  let tc = IdrisReload()

  if (tc is "")
    let fn = "idris --client :ac! " . cline . " " . word
    let result = system(fn)
    if (! (result is "")) 
       echo result
    else
      e
      call winrestview(view)
      call search(word)

    endif 
  endif
endfunction

function IdrisEval()
  let tc = IdrisReload()
  if (tc is "")
     let expr = input ("Expression: ")
     let fn = "idris --client '" . expr . "'"
     let result = system(fn)
     echo result
  endif
  echo ""
endfunction

map ct :call IdrisShowType()<ENTER>
map cr :call IdrisReload()<ENTER>
map ci :call IdrisCaseSplit()<ENTER>
map cd ?:<ENTER>b:call IdrisAddClause()<ENTER>w
map cm 0:call IdrisMakeWith()<ENTER>
map ce :call IdrisEval()<ENTER>
