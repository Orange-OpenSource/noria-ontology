# Copyright (c) 2022 Orange. All rights reserved.
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

SERIALIZATION=turtle
MAPPING=time docker run --rm -v $$(pwd):/data rmlio/rmlmapper-java rmlmapper -v -s ${SERIALIZATION}

## makefile for noria-ontology / dataset project
help:	## Show this help.
	# Get lines with double dash comments and display it
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'

install-dev-tools:	## Install requirements and development tools
	@echo -e "\033[35m > Get Python dependencies  \033[0m"
	pip3 install -r requirements.txt

	@echo -e "\033[35m > Install TurtleValidator  \033[0m (see https://github.com/IDLabResearch/TurtleValidator)"
	sudo npm install -g turtle-validator

	@echo -e "\033[35m > Install Newman  \033[0m (see https://learning.postman.com/docs/running-collections/using-newman-cli/command-line-integration-with-newman/)"
	sudo npm install -g newman
	@echo -e "\033[35m > Done  \033[0m"

check-kg:	## Check syntax of KG/ttl files
	@echo -e "\033[35m > Check RML/Turtle syntax  \033[0m"
	@find output/ -type f -name '*.ttl' -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;
	@echo -e "\033[35m > Done  \033[0m"

check-rml:	## Check syntax of RML/ttl files
	@echo -e "\033[35m > Check RML/Turtle syntax  \033[0m"
	@find . -type f -name 'rml_*.ttl' -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;
	@echo -e "\033[35m > Done  \033[0m"

build-kg: build-kg-topology-networklinks build-kg-topology-resources build-kg-folio-fmea build-kg-users build-kg-teams build-kg-applications

build-kg-topology-networklinks:	## Run RML mapping for building KG : Topology NetworkLinks
	@echo -e "\033[35m > Call RMLMapper for Topology NetworkLinks \033[0m"
	@${MAPPING} -m ./engine/rml_noria_topology_edges.ttl -o output/noria_topology_edges.ttl -t http://example.org/noria/engine/MP_Topology_NetworkLink -f ./engine/functions_noria.ttl
	@echo -e "\033[35m > Done  \033[0m"

build-kg-topology-resources:	## Run RML mapping for building KG : Topology Resources
	@echo -e "\033[35m > Call RMLMapper for Topology Resources \033[0m"
	@${MAPPING} -m ./engine/rml_noria_topology_resources.ttl -o output/noria_topology_resources.ttl -t http://example.org/noria/engine/MP_NORIA_Resource
	@echo -e "\033[35m > Done  \033[0m"

build-rml-folio-fmea:	## Run yarrrml-parser for building FOLIO translation rules
	@echo -e "\033[35m > Call yarrrml-parser for noria_folio_mapping.yml to rml_noria_folio_fmea.ttl conversion \033[0m"
	@docker run --rm -it -v $$(pwd):/data rmlio/yarrrml-parser:latest -i /data/engine/noria_folio_mapping.yml > engine/rml_noria_folio_fmea.ttl
	@echo -e "\033[35m > Done  \033[0m"

build-kg-folio-fmea:	build-rml-folio-fmea	## Run RML mapping for building KG : FMEA FOLIO example
	@echo -e "\033[35m > Call RMLMapper for FMEA FOLIO example \033[0m"
	@${MAPPING} -m engine/rml_noria_folio_fmea.ttl -o output/noria_folio_out.ttl -f engine/functions_folio.ttl
	@echo -e "\033[35m > Done  \033[0m"

build-kg-users:	## Run RML mapping for building KG : Users
	@echo -e "\033[35m > Call RMLMapper for Users \033[0m"
	@${MAPPING} -m engine/rml_noria_users.ttl -o output/noria_users.ttl -t http://example.org/noria/engine/MP_NORIA_Users
	@echo -e "\033[35m > Done  \033[0m"

build-kg-teams:	## Run RML mapping for building KG : Teams
	@echo -e "\033[35m > Call RMLMapper for Teams \033[0m"
	@${MAPPING} -m engine/rml_noria_users.ttl -o output/noria_teams.ttl -t http://example.org/noria/engine/MP_NORIA_Teams
	@echo -e "\033[35m > Done  \033[0m"

build-kg-applications:	## Run RML mapping for building KG : Applications
	@echo -e "\033[35m > Call RMLMapper for Applications \033[0m"
	@${MAPPING} -m engine/rml_noria_applications.ttl -o output/noria_applications.ttl
	@echo -e "\033[35m > Done  \033[0m"
