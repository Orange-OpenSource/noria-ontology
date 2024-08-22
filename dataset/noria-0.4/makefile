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

# =============================================================================

SHELL := /bin/bash
ROOT_DIR := $(PWD)

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

SRC_FOLDER=src

SERIALIZATION=turtle
MAPPING=time docker run --rm -v $$(pwd):/data rmlio/rmlmapper-java rmlmapper -v -s ${SERIALIZATION}

VIRTDB_IMG=openlink/virtuoso-opensource-7

# =============================================================================

## makefile for noria-o/dataset project
help:	## Show this help.
	# Get lines with double dash comments and display it
	@fgrep -h "## " $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/## //'

install-turtle-validator:
	@echo -e "\033[35m > Install TurtleValidator  \033[0m (see https://github.com/IDLabResearch/TurtleValidator)"
	sudo npm install -g turtle-validator
	@echo -e "\033[35m > Done  \033[0m"

install-yarrrml-parser:
	@echo -e "\033[35m > Get YARRRML Docker image  \033[0m (see https://github.com/RMLio/yarrrml-parser)"
	@docker pull rmlio/yarrrml-parser
	@echo -e "\033[35m > Done  \033[0m"

install-rmlmapper-java:
	@echo -e "\033[35m > Get RMLMapper Docker image  \033[0m (see https://github.com/RMLio/rmlmapper-java)"
	@docker pull rmlio/rmlmapper-java
	@echo -e "\033[35m > Done  \033[0m"

install-virtdb:
	@echo -e "\033[35m > Get Virtuoso Docker image  \033[0m (see https://hub.docker.com/u/openlink)"
	@docker pull ${VIRTDB_IMG}
	@echo -e "\033[35m > Done  \033[0m"

install-dev-tools: install-turtle-validator install-yarrrml-parser install-rmlmapper-java install-virtdb	## Install requirements and development tools

check-kg:	## Check syntax of KG/ttl files
	@echo -e "\033[35m > Check RML/Turtle syntax  \033[0m (TurtleValidator)"
	@find output/ -type f -name '*.ttl' -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;

	@echo -e "\033[35m > Done  \033[0m"

check-rml:	## Check syntax of RML/ttl files
	@echo -e "\033[35m > Check RML/Turtle syntax  \033[0m  (TurtleValidator)"
	@find . -type f -name 'rml_*.ttl' -printf "\n%f\n" -exec /usr/local/bin/ttl {} \;

	@echo -e "\033[35m > Done  \033[0m"

# =============================================================================

build-kg: build-kg-resources-assets build-kg-resources-location build-kg-resources-manufacturer build-kg-org build-kg-services build-kg-applications build-kg-topology

build-kg-resources-assets:	## Run RML mapping for building KG : Resources Assets
	@echo -e "\033[35m > Call RMLMapper for Resources Assets \033[0m"
	@${MAPPING} -m ./engine/rml_noria_resources.ttl -o output/noria_resources_assets.ttl -t http://example.org/noria/engine/MP_NORIA_Resource
	@echo -e "\033[35m > Done  \033[0m"

build-kg-resources-location:	## Run RML mapping for building KG : Resources Location
	@echo -e "\033[35m > Call RMLMapper for Resources Location \033[0m"
	@${MAPPING} -m ./engine/rml_noria_resources.ttl -o output/noria_resources_location.ttl -t http://example.org/noria/engine/MP_NORIA_Site,http://example.org/noria/engine/MP_NORIA_Building,http://example.org/noria/engine/MP_NORIA_Storey,http://example.org/noria/engine/MP_NORIA_Room,http://example.org/noria/engine/MP_NORIA_Locus
	@echo -e "\033[35m > Done  \033[0m"

build-kg-resources-manufacturer:	## Run RML mapping for building KG : Resources Manufacturer
	@echo -e "\033[35m > Call RMLMapper for Resources Manufacturer \033[0m"
	@${MAPPING} -m ./engine/rml_noria_resources.ttl -o output/noria_resources_manufacturer.ttl -t http://example.org/noria/engine/MP_NORIA_Manufacturer,http://example.org/noria/engine/MP_NORIA_ManufacturerProductModel
	@echo -e "\033[35m > Done  \033[0m"

build-kg-topology:	## Run RML mapping for building KG : Topology NetworkLinks
	@echo -e "\033[35m > Call RMLMapper for Topology NetworkLinks \033[0m"
	@${MAPPING} -m ./engine/rml_noria_topology_edges.ttl -o output/noria_topology_edges.ttl -t http://example.org/noria/engine/MP_Topology_NetworkLink -f ./engine/functions_noria.ttl
	@echo -e "\033[35m > Done  \033[0m"

build-kg-org:	## Run RML mapping for building KG : Organization (teams, users)
	@echo -e "\033[35m > Call RMLMapper for Organization \033[0m"
	@${MAPPING} -m engine/rml_noria_org.ttl -o output/noria_org.ttl -t http://example.org/noria/engine/MP_NORIA_EntityOF,http://example.org/noria/engine/MP_NORIA_Teams,http://example.org/noria/engine/MP_NORIA_CUid,http://example.org/noria/engine/MP_NORIA_Users
	@echo -e "\033[35m > Done  \033[0m"

build-kg-applications:	## Run RML mapping for building KG : Applications
	@echo -e "\033[35m > Call RMLMapper for Applications \033[0m"
	@${MAPPING} -m engine/rml_noria_applications.ttl -o output/noria_applications.ttl -t http://example.org/noria/engine/MP_NORIA_Application,http://example.org/noria/engine/MP_NORIA_ApplicationModule
	@echo -e "\033[35m > Done  \033[0m"

build-kg-services:	## Run RML mapping for building KG : Services
	@echo -e "\033[35m > Call RMLMapper for Applications \033[0m"
	@${MAPPING} -m engine/rml_noria_applications.ttl -o output/noria_services.ttl -t http://example.org/noria/engine/MP_NORIA_Service,http://example.org/noria/engine/MP_NORIA_ServiceAppModuleIdRelationship
	@echo -e "\033[35m > Done  \033[0m"

# =============================================================================

build-rml-folio-fmea:	## Run yarrrml-parser for building FOLIO translation rules
	@echo -e "\033[35m > Call yarrrml-parser for noria_folio_mapping.yml to rml_noria_folio_fmea.ttl conversion \033[0m"
	@docker run --rm -it -v $$(pwd):/data rmlio/yarrrml-parser:latest -i /data/engine/noria_folio_mapping.yml > engine/rml_noria_folio_fmea.ttl
	@echo -e "\033[35m > Done  \033[0m"

build-kg-folio-fmea:	build-rml-folio-fmea	## Run RML mapping for building KG : FMEA FOLIO example
	@echo -e "\033[35m > Call RMLMapper for FMEA FOLIO example \033[0m"
	@${MAPPING} -m engine/rml_noria_folio_fmea.ttl -o output/noria_folio_out.ttl -f engine/functions_folio.ttl
	@echo -e "\033[35m > Done  \033[0m"

# =============================================================================

concat-kg:	## Concat noria_*.ttl files into single file
	@echo -e "\033[35m > Concat noria_*.ttl files into single file \033[0m"
	@cat $$(ls output/noria_*.ttl) > output/noria-full.ttl
	@echo -e "\033[35m > Done  \033[0m"

# =============================================================================

virtdb-start:	## Start a Virtuoso instance on localhost
	@echo -e "\033[35m > Create the virtdb directory  \033[0m"
	mkdir -p virtdb
	@echo -e "\033[35m > Start a Virtuoso instance on localhost  \033[0m"
	@docker run \
		--name virtdb \
		--interactive \
		--rm \
		-d \
		--tty \
		--env DBA_PASSWORD=mysecret \
		--publish 1111:1111 \
		--publish  8890:8890 \
		--volume `pwd`/virtdb:/database \
		--volume `pwd`/output:/mnt \
		${VIRTDB_IMG}
	@echo -e "\033[35m > The Virtuoso instance is now available on http://localhost:8890 with admin account dba/mysecret \033[0m"

	@echo -e "\033[35m > Done  \033[0m"

virtdb-config:	## Configure the Virtuoso instance on localhost
	@echo -e "\033[35m > Send configuration file \033[0m"
	docker exec \
	  --interactive \
	  virtdb isql localhost dba mysecret /mnt/virtdb-config.sql || true
	@echo -e "\033[35m > Done  \033[0m"

virtdb-stop:	## Stop the Virtuoso instance on localhost
	@echo -e "\033[35m > Stop the Virtuoso instance on localhost  \033[0m"
	@docker container stop virtdb
	@echo -e "\033[35m > Done  \033[0m"

push-kg-virtdb: virtdb-config  ## Push KG data to local virtdb instance
	@echo -e "\033[35m > Push KG data to local virtdb instance \033[0m"
	for i in $$(find '.' -name '*.ttl'); do \
	    echo -e "\n\n*** ${YELLOW}Processing $i ${NC}***\n"; \
	    curl --digest --user dba:mysecret --verbose --url "http://localhost:8890/sparql-graph-crud-auth?graph-uri=urn:graph:update:noria-kg" -T $$i ;\
	done
	@echo -e "\033[35m > Done  \033[0m"

# =============================================================================

hooks:	## Set GIT hooks (see https://knpw.rs/blog/direnv-git-hooks)
	git config --local core.hooksPath $(shell pwd)/.githooks

# === EOF =====================================================================
