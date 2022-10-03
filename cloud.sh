#!/bin/bash

#Reading Urls list
URLSFile="urls.txt"
OutputFile="pradeep.html"
DATETIMENOW=`date +%A," "%d-%b-%Y" "%T`
cp /dev/null $OutputFile

#Creating List with HTMl file
printf "<HTML>\n<BODY>\n<TABLE>" > $OutputFile
printf "Current Status of Application URLs at $DATETIMENOW\n"

#Reading HTTP Codes
while read URLSFile;
do
 #echo -e "reading" $URLSFile
 URLStatus=$(/usr/bin/curl -H 'Cache-Control: no-cache' -o /dev/null --silent --head --write-out '%{http_code}' "$URLSFile" )
#
# If URL HTTP Status Code = 200
#
if [ $URLStatus -eq "200" ]; then
        printf "<TR><TD>$URLSFile</TD><TD FONTCOLOR='GREEN'>$URLStatus</TD></TR>\n" >> $OutputFile
fi
#
# If URL HTTP Status Code <> 200
#
if [ $URLStatus -ne "200" ]; then
        printf "<TR><TD>$URLSFile</TD><TD FONTCOLOR='RED'>$URLStatus</TD></TR>\n" >> $OutputFile
fi
done < $URLSFile
printf "</TABLE>\n" >> $OutputFile
printf "</BODY></HTML>" >> $OutputFile
cat $OutputFile
exit
