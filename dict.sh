#!/run/current-system/sw/bin/env bash

while read word ; do
	dict -d fd-eng-deu $word | sed -e '1,3d'
done
