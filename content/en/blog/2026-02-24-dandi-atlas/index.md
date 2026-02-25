---
title: "Introducing DANDI Atlas Explorer: Explore the DANDI Archive in 3D"
author: Ben Dichter
description: >
    DANDI Atlas Explorer is an interactive 3D brain viewer that maps DANDI Archive datasets
    onto the Allen Common Coordinate Framework mouse brain atlas, letting researchers
    explore data availability by brain region.
tags: [ dandi, nwb, visualization, data-discovery ]
date: 2026-02-24
---

Where in the brain does DANDI have data? As the archive grows, this question becomes
increasingly important for researchers planning experiments, searching for
collaborators, or surveying available data for meta-analyses. Today, we're excited to
introduce [DANDI Atlas Explorer](https://atlas.dandiarchive.org/)---an interactive 3D
brain viewer that lets you explore the DANDI Archive through the lens of the Allen
Common Coordinate Framework (CCF) mouse brain atlas.

{{< youtube D8514CLVXYo >}}

## What is DANDI Atlas Explorer?

DANDI Atlas Explorer is a browser-based tool that renders an interactive 3D mouse brain and
highlights which regions have associated neurophysiology datasets on DANDI. Regions
with more datasets appear more opaque, giving you an immediate, intuitive sense of
data coverage across the brain. Click any region to see the specific dandisets that
recorded there, with direct links back to the DANDI Archive.

The tool currently covers **48 dandisets** spanning **353 brain structures**, with data
automatically updated nightly from the archive.

## Key Features

**Interactive 3D brain visualization.** Rotate, zoom, and pan a fully rendered mouse
brain with 445 anatomical meshes from the Allen Institute. Orientation buttons let you
snap to standard views---dorsal, ventral, anterior, posterior, left, and right.

**Hierarchical brain region browser.** A searchable, collapsible tree mirrors the Allen
CCF structure hierarchy. Each region displays a badge with the number of associated
dandisets, making it easy to identify regions with available data.

**Region-to-dataset linking.** Click any brain region to see all dandisets that recorded
from that area. Each dandiset entry shows its title, subject count, and a direct link
to the DANDI Archive. You can drill down further to see individual subjects and their
recording locations.

**3D electrode visualization.** For electrophysiology datasets, DANDI Atlas Explorer extracts
electrode coordinates from NWB files and renders them as 3D point clouds within the
brain. Select a subject to see exactly where electrodes were placed, overlaid on the
anatomical context.

**Shareable URLs.** The app encodes your current selection in the URL, so you can share
a link that takes a colleague directly to a specific brain region or dandiset view.

## How It Works

DANDI Atlas Explorer bridges two major neuroscience resources. Brain anatomy comes from the
[Allen Brain Atlas API](https://portal.brain-map.org/), which provides the hierarchical
structure graph and 3D mesh geometry for every brain region. Dataset metadata comes from
the [DANDI Archive](https://dandiarchive.org), where NWB files store brain region
annotations and electrode coordinates alongside the neurophysiology data.

A Python pipeline processes this data:

1. It queries the DANDI API for all mouse (*Mus musculus*) dandisets.
2. For each dandiset, it streams NWB files to extract brain region labels and electrode
   coordinates---without downloading the full files.
3. It matches extracted region names to Allen CCF structure IDs.
4. It aggregates statistics and generates static JSON files that power the frontend.

The frontend is built with [Three.js](https://threejs.org/) for 3D rendering, with no
framework dependencies. A
[GitHub Actions workflow](https://github.com/dandi/dandi-atlas/blob/main/.github/workflows/update-dandi-data.yml)
runs the data pipeline nightly, so the atlas stays current as new datasets are published
to DANDI.

## Use Cases

- **Planning experiments:** Check what data already exists for your brain region of
  interest before starting a new study.
- **Finding collaborators:** Discover which labs have published data from the same brain
  areas you study.
- **Meta-analysis:** Quickly survey data availability across brain regions for
  cross-dataset analyses.
- **Teaching:** Use the interactive 3D brain to teach neuroanatomy in the context of
  real datasets.
- **Data discovery:** Browse the DANDI Archive spatially rather than by keyword search.

## Try It Now

DANDI Atlas Explorer is open source and runs entirely in your browser---no installation required.

**[Launch DANDI Atlas Explorer](https://atlas.dandiarchive.org/)**

The source code is available on
[GitHub](https://github.com/dandi/dandi-atlas). Contributions, bug reports, and feature
requests are welcome.

DANDI Atlas Explorer was developed by [CatalystNeuro](https://catalystneuro.com) with support
from the DANDI project.
