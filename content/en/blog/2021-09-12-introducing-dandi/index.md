---
title: "DANDI: A data archive and collaboration space for neurophysiology"
linktitle: "Introducing DANDI"
author: DANDI team
tags: [ data sharing, data archive, neurophysiology ]
date: 2021-09-12
---

DANDI is a [US BRAIN Initiative supported data archive](https://braininitiative.nih.gov/funded-awards/dandi-distributed-archives-neurophysiology-data-integration) for publishing and sharing neurophysiology data including intracellular and extracellular electrophysiology, optophysiology, and behavioral time-series, and images from immunostaining experiments.  For example, data from experimental techniques like patch clamps, silicon probes, and calcium imaging can be published on DANDI. So can data from lightsheet microscopy experiments when combined with associated MRI data.

DANDI allows scientists to publish “dandisets,” collections of data from neuroscience experiments that are often associated with specific papers or projects. DANDI is built to scale with the growing data engineering needs of the community and can easily receive and publish TBs of data for free supported by the [AWS public dataset program](https://registry.opendata.aws/dandiarchive/). It also uses best practices in metadata curation using [the DANDI schema](https://github.com/dandi/dandischema) and allows users to mint DOIs using Datacite for publishing dandisets.

For neurophysiology data, DANDI supports the [Neurodata Without Borders (NWB)](https://www.nwb.org/) standard. The NWB standard ensures that data is shared with the necessary metadata for reanalysis, allows for analyses that aggregate data across dandisets, provides a common platform for building analysis and visualization tools for published data, and allows DANDI to easily extract metadata to provide powerful detailed search features. For MRI and related data, DANDI has been leveraging the BIDS standards and working with other groups to extend support to microscopy and electrophysiology.

With [DANDI Hub](https://hub.dandiarchive.org/), DANDI is more than just an archive, but in fact an entire cloud-based collaborative platform, available for free to all DANDI users! DANDI Hub is a JupyterHub with access to high performance multi-core compute nodes and high-bandwidth access to all data hosted on DANDI. DANDI Hub provides many different workflows to interact with your data, including Python, R, and Julia Jupyter notebooks, a terminal, and even a Linux desktop view, all deployed for free and on demand in the cloud. The hub can be used to share code that reproduces key figures from papers, or to interactively explore any dandiset.

You can navigate all data conveniently using the Web app, or for more control we have several software tools for interacting with DANDI. The [DANDI Python library and command line interface](https://github.com/dandi/dandi-cli) allows for performant upload, download, and querying. The [DANDI REST API](https://api.dandiarchive.org/swagger/) can also be used to interface with web applications. Also, all [dandisets are made available using Datalad](https://github.com/dandisets), which provides convenient data access across different systems.

Upload your data today! See our user guide for details. If you have any questions, please use our help desk and we will be happy to assist.