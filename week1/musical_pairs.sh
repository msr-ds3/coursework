members=("ahmed" "aisha" "alou" "naomi" "sara" "sofia" "srijana" "vaishnavi" "vanessa" "dereck" "drishya" "yehtut")

if command -v md5sum &> /dev/null; then 
    seed=$(date +%F | md5sum | awk '{print $1}')
else
     seed=$(date +%F | md5sum | awk '{print $NF}')

fi 

printf "%s\n" "${members[@]}" | shuf --random-source=<(echo $seed) | xargs -n2 echo "Pair: "