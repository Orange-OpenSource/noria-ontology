# Copyright (c) 2024 Orange. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#     1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#     2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#     3. All advertising materials mentioning features or use of this software must display the following acknowledgement:
#     This product includes software developed by Orange.
#     4. Neither the name of Orange nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY Orange "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Orange BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

PAYLOAD_FILE_SET=$(find . -type f -name to-oops.xml)

# Loading (optional) environment variables from file.
-include ./.env

echo "\033[35m > oops-recursive : start  \033[0m"

rm -f ./oops-recursive.log
echo folder_name,ontology_file_name,response_filesize >> oops-recursive.log

for i in $PAYLOAD_FILE_SET
do
  folder_name=$(dirname "$i")
  echo "\033[35m > Working on $i file in $folder_name ... \033[0m"

  echo "\033[35m > Build OOPS POST request body for $i \033[0m"
  echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<OOPSRequest>\n<OntologyURI></OntologyURI>\n<OntologyContent><![CDATA[\n" > to-oops-generated.xml
  cat $i >> to-oops-generated.xml
  echo "\n]]></OntologyContent>\n<Pitfalls></Pitfalls>\n<OutputFormat>RDF/XML</OutputFormat>\n</OOPSRequest>" >> to-oops-generated.xml

	echo "\033[35m > Copy OOPS POST request body to $folder_name (for archive purpose) \033[0m"
  cp ./to-oops-generated.xml $folder_name/to-oops-generated.xml

	echo "\033[35m > Send OOPS POST request for $i \033[0m"
	curl -A "Mozilla Chrome Safari" -X POST -H "Content-Type: text/xml" --data "@./to-oops-generated.xml" https://oops.linkeddata.es/rest --proxy ${PROXY_FULL} -o from-oops-recursive.xml -vvv

  RESPONSE_FILESIZE=$(stat -c%s "./from-oops-recursive.xml")

	echo "\033[35m > Copy OOPS response ($RESPONSE_FILESIZE bytes) to $folder_name \033[0m"
  cp ./from-oops-recursive.xml $folder_name/from-oops-recursive.xml

	echo "\033[35m > Cleaning working files \033[0m"
  rm -f ./to-oops-generated.xml
  rm -f ./from-oops-recursive.xml

	echo "\033[35m > Logging details for $i \033[0m"
  echo $folder_name,$i,$RESPONSE_FILESIZE >> oops-recursive.log

done

echo "\033[35m > Reporting on potential OOPS WebService errors \033[0m"
grep --include=from-oops-recursive.xml -r -e "unexpected_error" > oops-recursive-error.log
sort ./oops-recursive-error.log > ./oops-recursive-error-sorted.log

echo "\033[35m > oops-recursive : done  \033[0m"