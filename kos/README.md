# noria-ontology / kos (vocabulary) files repository

This folder contains the **NORIA vocabulary documents**.

The vocabularies follows the [SKOS](https://www.w3.org/TR/skos-reference/) model.

## Naming convention

Every vocabulary document must be a Turtle document, and be named as follows:

```
NAMEVocabulary.ttl
```

## Vocabulary metadata

A vocabulary instance uses the following metadata within the top `skos:ConceptSchemeConcept` (provided as an example):

```turtle
voc:xxx
  a skos:ConceptScheme;
  skos:definition "xxx";
  skos:notation "xxx" ;
  rdfs:isDefinedBy <https://example.org/xxx> ;
  # --- Vocab metadata ---
  dcterms:issued "2022-05-10"^^xsd:date ;
  dcterms:publisher <https://www.orange.com/> ;
  dcterms:creator <https://orcid.org/0000-0001-5887-899X> ;  # Lionel Tailhardat
  dcterms:creator <https://orcid.org/0000-0001-5639-1504> ;  # Yoan Chabot
  dcterms:creator <https://orcid.org/0000-0003-0457-1436> ;  # Raphaël Troncy
  dcterms:license <https://spdx.org/licenses/BSD-4-Clause> ;
  dcterms:title "The NORIA <xxx> vocabulary" ;
  dcterms:type <https://nkos.dublincore.org/#thesaurus> ;
.
```

## Concept metadata

Every other definition in the vocabulary `<https://w3id.org/noria/kos/SOME_ConceptScheme/Concept>` must have the following metadata (provided as an example):

```turtle
voc-objects:yyy
    a skos:Concept;
    skos:definition "yyy"@en;
    skos:inScheme voc:upperScheme ;
    skos:notation "yyy";
    skos:prefLabel "yyy"@en;
    skos:prefLabel "yyy"@fr .
```