" Check for Makefile
" if exists: run make <current buffer>
" else: direct compile with gcc
if !filereadable('Makefile')
    setlocal makeprg=gcc\ -o\ %<\ %
else
    setlocal makeprg=make\ %:r.o
endif
" set compiler to gcc
compiler gcc
