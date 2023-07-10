# noria-ontology / evaluation

This folder contains the **NORIA evaluation documents**.

We provide a set of SPARQL queries for the evaluation of the NORIA-O model in relation to some corresponding Knowledge Graph (KG) instance.
Each sub-folders correspond to a specific NORIA-O release:

* [NORIA-O v0.3](noria-0.3), 25 queries
* [NORIA-O v0.2](noria-0.2), 25 queries
* [NORIA-O v0.1](noria-0.1), 25 queries

General approach:

* Design tests as SPARQL queries and store them in separate `.sparql` files,
* Run SPARQL queries on your SPARQL endpoint,
* Browse queries results if any. The test query is considered successful as long as a non-zero number of entities are returned.

Naming convention:

* `at_`: Authoring Tests (AT)
