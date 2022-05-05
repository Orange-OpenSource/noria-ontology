# noria-ontology / ontology files repository

This folder contains the **NORIA ontology documents**.

Every ontology document must be a Turtle document, and be named as follows:

```
NAME-MAJOR.MINOR.ttl
```
where:

- NAME matches `^[a-z]*$`
- MAJOR matches `^[0-9]+$`
- MINOR matches `^[0-9]+$`

see http://semver.org/ for semantic versioning specification.

When a new release of the core ontology is released, please update the `noria-latest.ttl` symbolic link for targeting the latest core file version:
```shell
# From the ontology directory
ln -s -f noria-<MAJOR.MINOR>.ttl noria-latest.ttl
# e.g. ln -s -f noria-0.1.ttl noria-latest.ttl
```
## Ontology metadata

NORIA ontologies are modularized and versioned.
An ontology instance uses the following metadata:

- type `owl:Ontology`;
- a `owl:versionIRI` equal to `<https://w3id.org/noria/NAME-MAJOR.MINOR>`;
- a `owl:versionInfo` that starts with `"vMAJOR.MINOR"`;
- potentially, a `owl:priorVersion`;
- zero or more `owl:import`s that point to other ontologies (potentially ontology version IRIs) to be imported.


Then every ontology instance must have the following recommended metadata:

- type `voaf:Vocabulary`;
- at least one `dcterms:title` with a language tag;
- at least one `dcterms:description` with a language tag (it SHOULD use the markdown syntax);
- a `dcterms:issued` (some `xsd:date`);
- a `dcterms:modified` (some `xsd:date`);
- a `dcterms:creator` (some `foaf:Person`);
- zero or more `dcterms:contributor` (some `foaf:Person`);
- a `cc:licence` equal to `<https://spdx.org/licenses/BSD-4-Clause>`;
- a `vann:preferredNamespacePrefix` equal to `"noria"`;
- a `vann:preferredNamespaceUri` equal to `<https://w3id.org/noria/ontology/>`;

## Concept metadata

Every other resource in the ontology `<https://w3id.org/noria/ontology/SOME_RESOURCE>` must have the following metadata:

- at least one `rdfs:label`;
- at least one `rdfs:comment` with a language tag (it SHOULD use the [Markdown](https://www.markdownguide.org/) syntax);
- a `vs:term_status`: one of `"unstable"`, `"testing"`, or `"stable"`;
- a `rdfs:isDefinedBy` equal to `noria:ONTOLOGY_NAME`.

## Alignment to other schemas

Alignment to other schemas should be defined in independent files, and be named as follows:

```
<SCHEMA>Alignement-MAJOR.MINOR.ttl
```

If precise vocabulary/concept alignment is not defined, Concepts should at least have an "*alignment reference*" in its `rdfs:comment` metadata (e.g. "*this concept is partially in line with the semantics of `bot:Site`*"). 