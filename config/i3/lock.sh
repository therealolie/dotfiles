#!/bin/sh

# totally full-proof secure way of making a random file that nothing will use
[ -f "/tmp/$USER-lock-dfsiu3qezxczlksdaljk" ] && exit
touch "/tmp/$USER-lock-dfsiu3qezxczlksdaljk"
i3lock -nfF --indicator --{ring{,ver},insidewrong}-color=5bcefa -B 10 --radius 60 --{verif,wrong,noinput}-text="" --{insidever,keyhl}-color=ffffff --{ringwrong,inside}-color=f5a9b8 --{line,separator}-color=00000000 --bshl-color=ffb9c8
rm "/tmp/$USER-lock-dfsiu3qezxczlksdaljk"
