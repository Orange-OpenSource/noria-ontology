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

SHELL := /bin/bash
ROOT_DIR := $(PWD)

SRC_FOLDER=src
PYTHON_BIN=/usr/bin/python3
export PYTHONPATH := ./:${SRC_FOLDER}:$(PYTHONPATH)

SPARQL_ENGINE=~/.local/jena/bin/sparql

# Loading (optional) environment variables from file.
-include ./.env

## makefile for noria-o/docs/sota/dm-rdf
help:	## Show this help.
	# Get lines with double dash comments and display it
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'

build-oops-request:	## Build OOPS POST request body
	@echo -e "\033[35m > Build OOPS POST request body \033[0m"
	@echo -e "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<OOPSRequest>\n<OntologyURI></OntologyURI>\n<OntologyContent><![CDATA[\n" > to-oops-generated.xml
	@cat to-oops.xml >> to-oops-generated.xml
	@echo -e "\n]]></OntologyContent>\n<Pitfalls></Pitfalls>\n<OutputFormat>RDF/XML</OutputFormat>\n</OOPSRequest>" >> to-oops-generated.xml
	@echo -e "\033[35m > Done  \033[0m"

send-oops-request:	## Send OOPS POST request
	@echo -e "\033[35m > Send OOPS POST request \033[0m"
	@curl -A "Mozilla Chrome Safari" -X POST -H "Content-Type: text/xml" --data "@./to-oops-generated.xml" https://oops.linkeddata.es/rest --proxy ${PROXY_FULL} -o from-oops.xml -vvv
	@echo -e "\033[35m > Done  \033[0m"

oops: build-oops-request send-oops-request  ## Full OOPS process
	@echo -e "\033[35m > Full OOPS process \033[0m"
	#@rm to-oops.rdf
	#@rm to-oops.txt
	@echo -e "\033[35m > Done  \033[0m"

combine-uco:	## Combine files from UCO
	@echo -e "\033[35m > Combine files from UCO \033[0m"
	@find UCO/ -type f -name *.ttl \
      	  -exec cat {} >> uco.ttl \;
	@echo -e "\033[35m > Done  \033[0m"

combine-icas:	## Combine files from ICAS
	@echo -e "\033[35m > Combine files from ICAS \033[0m"
	@find ICAS/icas-ontology-master/ontology -type f -name *.ttl \
      	  -exec cat {} >> ICAS/icas.ttl \;
	@echo -e "\033[35m > Done  \033[0m"

