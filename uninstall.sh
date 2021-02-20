#!/bin/bash

###############################################################################
#
#   A shell script used to remove files which installed with `make install`
#   from texmf directory.
#
###############################################################################
TEXMFLOCAL=$(sh get_texmf_dir.sh)

TEX_DIR=$TEXMFLOCAL/tex/latex/scutthesis
DOC_DIR=$TEXMFLOCAL/doc/latex/scutthesis
BST_FILE=$TEXMFLOCAL/bibtex/bst/gbt7714-2005.bst

if [ -d "$TEX_DIR" ]; then
    printf '%s\n' "Removing ($TEX_DIR)"
    rm -rf "$TEX_DIR"
fi

if [ -d "$DOC_DIR" ]; then
    printf '%s\n' "Removing ($DOC_DIR)"
    rm -rf "$DOC_DIR"
fi

if [ -e "$BST_FILE" ]; then
    printf '%s\n' "Removing ($BST_FILE)"
    rm "$BST_FILE"
fi

# refresh the ls-R database
texhash
