# noria-ontology / CQs

This folder contains the **NORIA Competency Questions** (CQs) in relation to the Ontology Requirement Specification Design (ORSD).

* [NORIA-O CQs](cqs-noria-0.3.yaml) list, which contains 26 different items. 

Competency Questions follows this template:
```yaml
- Question : what is the template for competency questions?
  Archetypes:
    - id : 1
      pattern: Which [CE1] [OPE] [CE2]
      CE1: template
      OPE: is associated to
      CE2: competency questions
  Evaluation:
    - type: AT
      query: at-xxx-.sparql
      result: OK (simple SPARQL query can answer), AI (need more complex algorithm), Extension (need more concepts in the schema), ExtData (need to leverage external data)
    - type: AT
      query: at-yyy-.sparql
      result: ...
```

Competency Questions are validated with Authoring Tests (ATs) made available through the `query` field.
Files in the `query` field refers to the [../evaluation/](../evaluation/) folder.

For the CQs in relation to a specific NORIA-O release, see the corresponding `cqs-noria-<major>.<minor>.yaml` file:

* [NORIA-O v0.3](cqs-noria-0.3.yaml)
* [NORIA-O v0.2](cqs-noria-0.2.yaml)
* [NORIA-O v0.1](cqs-noria-0.1.yaml)
