# noria-ontology

The **NORIA-O** project is a data model for IT networks, events and operations information.
The ontology is developed using web technologies (e.g. RDF, OWL, SKOS) and is intended as a structure for realizing an IT Service Management (ITSM) Knowledge Graph (KG) for Anomaly Detection (AD) and Risk Management applications.
The model has been developed in collaboration with operational teams, and in connection with third parties linked vocabularies.

Cite:
```bibtex
@inproceedings{noria-o-2022,
  title = {NORIA-O: an Ontology for Anomaly Detection and Incident Management in ICT Systems},
  author = {{Lionel Tailhardat} and {Yoan Chabot} and {Rapha\"el Troncy}},
  year = {2022}
}
```

## Usage

We provide a direct access to the NORIA-O resources with the **noria** [w3id.org](https://w3id.org/) identifier:
* [https://w3id.org/noria/](https://w3id.org/noria/)

Based on this identifier, the following links apply for direct access to the NORIA-O featured topics:

| NORIA-O | Link |
| --- | --- |
| Ontologies | https://w3id.org/noria/ontology/ |
| Documentation | https://w3id.org/noria/doc/ |
| Vocabularies | https://w3id.org/noria/kos/ |
| Competency Questions | https://w3id.org/noria/ORSD/ |
| Authoring Tests | https://w3id.org/noria/evaluation/ |

Direct reference to a versioned ontology implementation also makes use of the *noria* identifier.
For example, the v0.1 main ontology file is available at:
* [https://w3id.org/noria/noria-0.1](https://w3id.org/noria/noria-0.1)


See also the *Repository Structure* for navigating into this repository:
```
noria-ontology
├───evaluation <noria ontology evaluation tool set> (e.g. Authoring Tests)
├───kos <noria controlled vocabulary> (e.g. codelists)
├───ontology <the noria ontology implementation>
└───ORSD <Ontology Requirements and Specification> (e.g. Competency Questions)
```

## Contribute

In the general case, please
* *fork and create merge request* OR
* *raise an issue* into the project's space.

## Copyright

Copyright (c) 2020-2023, Orange / EURECOM. All rights reserved.

## License

[BSD-4-Clause](LICENSE.txt).

## Maintainer

* [Lionel TAILHARDAT](mailto:lionel.tailhardat@orange.com)
* [Yoan CHABOT](mailto:yoan.chabot@orange.com)
* [Raphaël TRONCY](mailto:raphael.troncy@eurecom.fr)