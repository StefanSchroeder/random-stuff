
./setup-x86_64 -P `awk 'NR==1{printf \$1}{printf ",%s", \$1}' packagelist`

