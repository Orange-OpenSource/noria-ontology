# noria-ontology / kos (vocabulary) files repository

This folder contains the **NORIA vocabulary documents**.

The vocabularies follows the [SKOS](https://www.w3.org/TR/skos-reference/) model.

## Naming convention

Each vocabulary document must be in [Turtle](https://www.w3.org/TR/turtle/) syntax, and saved in a folder whose name corresponds to the version of the release:

```
NAME-MAJOR.MINOR/DOCUMENT.ttl
```

where:

- NAME matches `^[a-z]*$`
- MAJOR matches `^[0-9]+$`
- MINOR matches `^[0-9]+$`

see http://semver.org/ for semantic versioning specification.

When releasing a new version of the ontology,

* create a `noria-<major>.<minor>` folder,
* update the `noria-latest.ttl` symbolic link for targeting the latest ontology version:
  ```shell
  # From the ontology directory
  ln -s -f noria-<MAJOR.MINOR>/noria-kos.ttl noria-kos-latest.ttl
  # e.g. ln -s -f noria-0.3/noria-kos.ttl noria-kos-latest.ttl
  ```

Direct reference to a versioned vocabulary implementation also makes use of the *noria* identifier.
For example, the v0.3 main vocabulary file is available at: [https://w3id.org/noria/kos/noria-0.3](https://w3id.org/noria/kos/noria-0.3).
Using this approach rely on rewriting rules defined at the [perma-id/w3id.org](https://github.com/perma-id/w3id.org) level towards the relevant folder/sub-folder.

## Vocabulary metadata

A vocabulary instance uses the following metadata within the top `skos:ConceptSchemeConcept` (provided as an example):

```turtle
@base <https://w3id.org/noria/kos/> .

<voc-name>
  a skos:ConceptScheme;
  skos:definition "xxx";
  skos:notation "xxx" ;
  rdfs:isDefinedBy <https://example.org/xxx> ;
  # --- Vocab metadata ---
  dcterms:creator "Lionel Tailhardat (https://orcid.org/0000-0001-5887-899X)" ;  # Lionel Tailhardat
  dcterms:creator "Yoan Chabot (https://orcid.org/0000-0001-5639-1504)" ;  # Yoan Chabot
  dcterms:creator "Raphaël Troncy (https://orcid.org/0000-0003-0457-1436)" ;  # Raphaël Troncy
  dcterms:publisher <https://www.orange.com/> ;
  dcterms:license <https://spdx.org/licenses/BSD-4-Clause> ;
  dcterms:title "The NORIA <xxx> vocabulary" ;
  dcterms:type <https://nkos.dublincore.org/#thesaurus> ;
  dcterms:issued "2022-05-10"^^xsd:date ;
  dcterms:modified "2022-12-15"^^xsd:date ;
  skos:changeNote """Changes in 2022-12-15:
  - Added this
  - Changed that"""@en ;
.
```

## Concept metadata

Every other definition in the vocabulary `<https://w3id.org/noria/kos/SOME_ConceptScheme/Concept>` must have the following metadata (provided as an example):

```turtle
<voc-name/voc-object>
    a skos:Concept;
    skos:definition "yyy"@en;
    skos:inScheme <voc-upperScheme> ;
    skos:notation "yyy";
    skos:prefLabel "yyy"@en;
    skos:prefLabel "yyy"@fr;
.
```