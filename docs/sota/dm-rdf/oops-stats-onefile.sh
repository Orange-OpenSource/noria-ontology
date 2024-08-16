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

# Loading (optional) environment variables from file.
-include ./.env

echo "\033[35m > oops-stats-onefile : start  \033[0m"
IFS=$(find . -type f -name oops-stats.csv | paste -s -d ',' -)
FS=$(find . -type f -name oops-stats.csv)

echo "\033[35m > Groups :  \033[0m $IFS"
echo "\033[35m > File set :  \033[0m $FS"

#csvstack ${FS} > oops-stats-one-file.csv
#csvstack -g ${IFS} ${IFS} > oops-stats-one-file.csv
#csvstack $(find . -type f -name oops-stats.csv) > oops-stats-one-file.csv
#csvstack -g $(find . -type f -name oops-stats.csv | paste -s -d ',' -) $(find . -type f -name oops-stats.csv) > oops-stats-one-file.csv

echo "\033[35m > oops-stats-onefile : done  \033[0m"
