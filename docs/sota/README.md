# noria-ontology / docs / sota files repository

This folder contains the **NORIA-O SotA resources**: a state of the art (SotA) of ontologies related to the NORIA-O field prior to the design of NORIA-O, and means to analyze them.

This work has been published in:

```bibtex
@misc{LTailhardat-noria-sota-2025,
  title        = {Anomaly Detection using Knowledge Graphs: A Survey for Network Management and Cybersecurity Application},
  author       = {{Lionel Tailhardat} and {Yoan Chabot} and {Raphael Troncy}},
  year         = {2025},
  howpublished = {\url{https://hal.science/hal-04930539}},
  note         = {RefId: hal-04930539}
}
```

## Usage

The main components of this repository are the following ones:

* List of data models: the [./noria-sota-ontology.xlsx](noria-sota-ontology.xlsx) file
* Dataset of data models: sub-folders in [./dm-rdf](./dm-rdf)

### Browse and/or edit the list of data models

* Open the [noria-sota-ontology.xlsx](noria-sota-ontology.xlsx) file
* Edit the file:
  * Add references and details to ontologies.
  * Download an ontology implementation to the [./dm-rdf](./dm-rdf) folder and reflect the folder name into the *downloaded* column.
  * Use Protege 5.1.0 or the ontology authors' claims to fill the following columns: *classCount*, *objectPropertyCount*, *dataPropertyCount*, *individualCount*, *vocabularyExpressivity*, *vocabularyStatsAndExpressivityOrigin*.

### Run the OOPS! analysis for ontologies with an implementation

The [./dm-rdf](./dm-rdf) folder is for archiving referenced RDF ontologies and studying their characteristics.
The analysis is carried-out using [OOPS!](https://oops.linkeddata.es/) via its WebService https://oops.linkeddata.es/webservice.html.

#### Per model analysis

* Navigate to `dm-rdf/`

    ```shell
    cd dm-rdf
    ```

* Copy the ontology to [dm-rdf/to-oops.xml](dm-rdf/to-oops.xml)
* Make the call to OOPS:

    ```shell
    make oops
    ```
* Analyze the results from [dm-rdf/from-oops.xml](dm-rdf/from-oops.xml)

Calling the OOPS WebService may require commenting out certain lines in the XML file, especially some *import* clauses.
The following comment can be helpful in identifying the lines to comment out:
```
        <!-- HACK: comment the following line to avoid OOPS WebService unexpected_issue -->
```

#### Recursive Analysis

* Execute OOPS queries for each directory:

  ```shell
  sh ./oops-recursive.sh
  ```

  The execution log is available in [oops-recursive.log](dm-rdf%2Foops-recursive.log) and [oops-recursive-error-sorted.log](dm-rdf%2Foops-recursive-error-sorted.log)

* Extract OOPS statistics for each directory using a SPARQL query:

  ```shell
  sh ./oops-stats.sh
  ```

  The execution log is available in [oops-stats.log](dm-rdf%2Foops-stats.log)

* Aggregate the statistics into a single file:

  ```shell
  csvstack -g $(find . -type f -name oops-stats.csv | paste -s -d ',' -) $(find . -type f -name oops-stats.csv) > oops-stats-one-file.csv
  ```

  The results are in [oops-stats-one-file.csv](dm-rdf%2Foops-stats-one-file.csv); the `group` column indicates the source of the indicators.

* Analyze the statistics on [oops-stats-one-file.csv](dm-rdf%2Foops-stats-one-file.csv)
  * Summary view:

    ```shell
    csvstat oops-stats-one-file.csv > oops-stats-one-file-csvstat.csv
    ```

    See the output in [oops-stats-one-file-csvstat.csv](dm-rdf%2Foops-stats-one-file-csvstat.csv):

    Example:

    ```
      1. "group"
        Most common values:    ./ICAS/oops-stats.csv (15x)
                               ./ForensicOntology/oops-stats.csv (11x)
                               ./UCO/oops-stats.csv (11x)
                               ./OM/oops-stats.csv (10x)
                               ./DogOnt/oops-stats.csv (10x)
      3. "pit_code"
        Most common values:    P13 (43x)
                               P11 (42x)
                               P08 (41x)
                               P04 (29x)
                               P10 (20x)
      5. "pit_importance"
        Most common values:    Minor (156x)
                               Important (135x)
                               Critical (17x)
    ```


### Browse the list of data models as a Turtle file

Steps for converting the list of data models into a [Turtle](https://www.w3.org/TR/turtle/) file, and thereby enabling further processing:

* Browse the Web to the [SKOS Play ! Convert](https://skos-play.sparna.fr/play/convert) service
* Convert the [noria-sota-ontology.xlsx](noria-sota-ontology.xlsx)
  * Output format = Turtle
  * Ignore SKOS post-processing = Checked
* Save the resulting file as [noria-sota-ontology.ttl](noria-sota-ontology.ttl)

### Generating the ontology diagram

Steps for generating an ontology diagram rely on the [WebVOWL](https://github.com/VisualDataWeb/WebVOWL) tool:

* Ontology > Select ontology file > Upload : select the `to-oops.xml` file
* Let WebVOWL apply the recommended layout parameters
* Center graph
* Export > Export as SVG : fetch and store the resulting `to-oops.xml.svg` file

### Get insights using a Jupyter notebook

Install requirements:

* Python 3.11
* Python packages:

  ```shell
  pip install -r ./scripts/requirements.txt
  ```

* Jupyter notebook framework:

  ```shell
  sudo apt install jupyter-core jupyter-notebook
  ```

Run the notebook service:

* (optional) If using a virtual env

  ```shell
  python -m ipykernel install --user --name=<VirtualEnvName>
  ```
* Start the Jupyter notebook service

  ```shell
  jupyter notebook
  ```

* Load and run the [./scripts/noria-sota-stats.ipynb](./scripts/noria-sota-stats.ipynb) notebook.
