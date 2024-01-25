# Copyright (c) 2022-2024 Orange. All rights reserved.
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

WIDOCO_BIN=./lib/widoco/widoco-1.4.21-jar-with-dependencies_JDK-17.jar
# WIDOCO_BIN=./lib/widoco/java-17-widoco-1.4.17-jar-with-dependencies.jar
# WIDOCO_BIN=./lib/widoco/widoco-1.4.19-jar-with-dependencies_JDK-17.jar

SKOSPLAY_BIN=./lib/skos-play/skos-play-cli-0.9.1-onejar.jar

# Loading (optional) environment variables from file.
-include ./.env

## makefile for the noria-ontology project
help:	## Show this help.
	# Get lines with double dash comments and display it
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'

check-ontology:	## Check syntax of ontology files
	@echo -e "\033[35m > Check turtle syntax  \033[0m - requires TurtleValidator: npm install -g turtle-validator (see https://github.com/IDLabResearch/TurtleValidator)"
	@find kos/ -type f -name *.ttl -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;
	@find ontology/ -type f -name *.ttl -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;
	@echo -e "\033[35m > Done  \033[0m"

check-skos:	## Check quality of SKOS files
	@echo -e "\033[35m > Run qSkos \033[0m (see https://github.com/cmader/qSKOS , requires Internet connection)"
	@find kos/ -type f -name *.ttl \
	  -printf "\n%f\n" \
	  -exec java \
		  -Dhttp.proxyHost=${PROXY_SRV} \
		  -Dhttp.proxyPort=${PROXY_PORT} \
		  -jar lib/qskos/qSKOS-cmd.jar \
			analyze \
			-dc bl,mil \
			{} \
			-o doc/qskos/{}.qskos.txt \;
	@echo -e "\033[35m > Done  \033[0m"

check-orsd:	## Check syntax of model files (ORSD)
	@echo -e "\033[35m > Check yaml syntax  \033[0m - requires yamllint (see https://pypi.org/project/yamllint/)"
	@yamllint -d relaxed cqs/*.yaml
	@echo -e "\033[35m > Done  \033[0m"

check-filesystem:	## Check project's filesystem content for clean commit and sharing
	@echo -e "\033[35m > Find files with long filenames  \033[0m"
	@! find | egrep '/[^/]{100,}$$'
	@echo -e "\033[35m > Done  \033[0m"

doc-widoco:	## Compile documentation (this task relies on both local and remote files)

	@echo -e "\033[35m > Remove any previous local doc \033[0m (docs/NORIA-O)"
	@rm -rf docs/NORIA-O/doc

	@echo -e "\033[35m > Call the WIDOCO documentation framework \033[0m (see https://github.com/dgarijo/Widoco)"
	@echo -e "WIDOCO_BIN = ${WIDOCO_BIN}"
	@echo -e "PROXY_SRV = ${PROXY_SRV} / PROXY_PORT = ${PROXY_PORT}"
	@java \
	  -Dhttps.proxyHost=${PROXY_SRV} \
	  -Dhttps.proxyPort=${PROXY_PORT} \
	  -jar ${WIDOCO_BIN} \
	  -ontFile ontology/noria-latest.ttl \
	  -outFolder docs/NORIA-O \
	  -saveConfig docs/noria-ontology.widoco \
	  -rewriteAll \
	  -getOntologyMetadata \
	  -includeImportedOntologies \
	  -ignoreIndividuals \
	  -webVowl \
	  -noPlaceHolderText \
	  -uniteSections

	@echo -e "\033[35m > Done  \033[0m (you may now browse the doc locally or push it to the repository)"

doc-ontotool:	## Compile documentation with the ontology-toolkit

	@echo -e "\033[35m > Create the directory structure \033[0m (docs/onto-tool)"
	@mkdir -p docs/onto-tool

	@echo -e "\033[35m > Call the ontology-toolkit graphic \033[0m (see https://github.com/semanticarts/ontology-toolkit)"
	@onto_tool graphic -t NORIA-O -o docs/onto-tool/ ontology/noria-latest.ttl

	@echo -e "\033[35m > Done  \033[0m (you may now browse the doc locally or push it to the repository)"

doc-skos:	## Compile KOS documentation

	@echo -e "\033[35m > Create the directory structure \033[0m (docs/NORIA-O-KOS)"
	@mkdir -p docs/NORIA-O-KOS

	@echo -e "\033[35m > Call the skos-play documentation framework \033[0m (see https://github.com/sparna-git/skos-play)"
	@echo -e "SKOSPLAY_BIN = ${SKOSPLAY_BIN}"
	@echo -e "PROXY_SRV = ${PROXY_SRV} / PROXY_PORT = ${PROXY_PORT}"

	@echo -e "\033[35m > Call the skos-play documentation framework \033[0m (alphabetical)"
	@java \
	  -jar ${SKOSPLAY_BIN} \
	  complete \
	  --format pdf \
	  --lang en \
	  --multilingual \
	  --input ./kos/noria-kos-latest.ttl \
	  --output ./docs/NORIA-O-KOS/noria-kos-latest.pdf

	@echo -e "\033[35m > Done  \033[0m (you may now browse the doc locally or push it to the repository)"

doc-ontology: doc-widoco doc-skos doc-ontotool
