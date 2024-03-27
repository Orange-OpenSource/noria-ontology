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

OOPS_FILE_SET=$(find . -type f -name from-oops-recursive.xml)
SPARQL_ENGINE=~/.local/jena/bin/sparql

# Loading (optional) environment variables from file.
-include ./.env

echo "\033[35m > oops-stats : start  \033[0m"

rm -f ./oops-stats.log

for i in $OOPS_FILE_SET
do
  FOLDER_NAME=$(dirname "$i")
  echo "\033[35m > Working on $i file in $FOLDER_NAME ... \033[0m"
  echo "> Working on $i ..." >> ./oops-stats.log

  echo "\033[35m > Run SPARQL queries on $i \033[0m"
  ${SPARQL_ENGINE} --query=rq-oops-pitfalls-stats.sparql --data $i --results csv > $FOLDER_NAME/oops-stats.csv 2>> ./oops-stats.log

done

echo "\033[35m > oops-stats : done  \033[0m"