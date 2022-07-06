#extract all zip files in the current directory
for i in *.zip
do
    unzip $i
done

#combine the extracted text files in the current directory
for i in *.txt
do
    cat $i >> all.txt
done

#run python scripts to find interesting matches in all.txt
python3 domainparse.py all.txt
sort suspicious_domains.txt | uniq > suspicious_domains_all.txt

python3 domainparse-int.py all.txt
sort suspicious_domains-int.txt | uniq > suspicious_domains-int_all.txt

#clean the working directory
for i in *.txt
do
    if [ $i != "suspicious_domains_all.txt" ] && [ $i != "suspicious_domains-int_all.txt" ]
    then
        rm $i
    fi
done

for i in *.zip
do
    rm $i
done
