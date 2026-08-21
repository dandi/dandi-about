---
title: "DANDI Notebooks: Persistent, Executable Companions to Neurophysiology Data"
author: Ben Dichter
description: >
    Every notebook on notebooks.dandiarchive.org can now be opened in Google Colab
    with one click or run locally in a verified container image. Together these make
    the notebook collection a platform for sharing analyses that stay executable.
tags: [ dandi, nwb, notebooks, reproducibility, colab, docker ]
date: 2026-08-20
---

A dataset on DANDI is most useful when it comes with code that shows how to read it and
what can be done with it. For several years we have collected such notebooks at
[notebooks.dandiarchive.org](https://notebooks.dandiarchive.org): walkthroughs of
individual dandisets, tutorials from workshops, and in a growing number of cases,
notebooks that reproduce specific figures from the paper a dataset was published with.

The difficulty with notebooks has always been keeping them runnable. A notebook that
worked when it was written depends on a particular set of package versions, and those
versions drift. Within a year or two, a reader who tries to run it often finds that a
dependency has changed its API, a default has moved, or a package no longer installs at
all. The code is still there, but the ability to execute it has quietly evaporated.

We have now addressed this with two complementary ways to run every notebook in the
collection, and the second of them changes what the collection can be used for.

## Running a Notebook in Google Colab

Each notebook on the index carries an "Open in Colab" badge. Clicking it opens the
notebook in Google Colab, where the first cell installs the notebook's dependencies at
fully pinned versions, not just the packages the notebook imports but their entire
transitive closure, resolved against the versions Colab ships so that the install is
fast and rarely requires a runtime restart. After that cell runs, every later cell
executes against exactly the environment the notebook was tested in. Nothing needs to be
installed on your own machine, and the data streams directly from the DANDI Archive.

This is the easiest path, and for a quick look at a dataset it is the one we expect
most people to take. Its limitation is that it rests on an environment we do not
control. Colab updates its Python version and preinstalled packages on its own
schedule, and a pinned install that works today is not guaranteed to resolve on the
Colab of a few years from now.

## Running a Notebook in a Container

For that reason each notebook is also published as a container image. The image
bundles the notebook, the exact pinned Python environment, a JupyterLab server, and any
helper files, frozen together. Running one takes a single command:

```
docker run --rm -p 127.0.0.1:8888:8888 ghcr.io/dandi/example-notebooks/001550-paganlab:latest
```

JupyterLab opens in your browser on the notebook with everything already installed.
The images are built for both Intel and ARM processors, so they run natively on Apple
Silicon laptops as well as on Linux servers, and each image carries a date tag alongside
`latest` so that a specific snapshot can be cited in a methods section.

An image is only pushed to the registry after the notebook has been executed successfully
inside it, on both processor architectures, as an unprivileged user, under a memory
limit typical of a laptop. An image that is on the registry is one whose notebook ran,
start to finish, in precisely that environment. Unlike Colab, nothing inside the
environment can change afterward, and there is a better chance it will remain
usable many years later.

The docker badge next to each notebook copies the command above to your clipboard, and
a [help page](https://notebooks.dandiarchive.org/docker-help.html) explains the rest
for anyone who has not used Docker before.

## A Platform for Executable Research Artifacts

Our original motivation was keeping demonstration notebooks working, but the verified
container images make something more ambitious possible: the notebook collection can
serve as a place to publish the computational parts of a study in a form that stays
executable.

Several notebooks in the collection already do this. The notebooks for
[Dandiset 001538](https://notebooks.dandiarchive.org/#dandiset-001538) reproduce
individual figures from Zhai et al. 2025, one notebook per figure panel. The notebook
for [Dandiset 001075](https://notebooks.dandiarchive.org/#dandiset-001075) regenerates
a paper figure from the raw data. The
[reanalysis of Dandiset 000458](https://notebooks.dandiarchive.org/#dandiset-000458)
reproduces a result from Burman et al. 2023 in Neuron. With a verified container
image, each of these is no longer a script that happened to work on the author's
machine. It is an artifact that anyone can execute, years from now, against the same
public data, in the same environment, with a one-line command.

This is a different kind of object from a methods section or a code repository. A
repository records what was done; the container, paired with the data on DANDI,
records what was done in a way that can still be run. We think this is the right level
of reproducibility to aim for in neurophysiology, where the data are large, the
software stacks are deep, and there is often a gap between "the code is available" and "the
analysis can be rerun" a few years after publication.

The design follows the [STAMPED principles](https://stamped-principles.org) for
reproducible research objects ([Macdonald, Baker, To, and Halchenko,
2026](https://paper.stamped-principles.org/)): a research object should be
Self-contained, Tracked, Actionable, Modular, Portable, Ephemeral, and Distributable. A verified
notebook image is self-contained in that the code, the environment, and the server
live under one boundary; tracked in that every image records the repository commit it
was built from and carries a dated tag; actionable in that a single command executes
it; modular in that each notebook group is its own image over a shared base; portable
in that the environment is pinned explicitly and built for both processor
architectures; ephemeral in that each run starts from the same frozen state and
discards its container afterward; and distributable in that the images are published
on a public registry under persistent, retrievable tags. The one deliberate departure
from a fully self-contained artifact is the data, which stays on DANDI and is streamed
at run time rather than copied into the image, so that the data of record remains the
archived dandiset itself.

There are honest limits. The notebooks stream their data from DANDI at run time, so an
internet connection is still needed and the data themselves are not frozen inside the
image. Notebooks that require a human in the loop, for example those that open
interactive windows, cannot be verified unattended and therefore cannot carry an image.
Notebooks for embargoed dandisets wait until the data are public. And some of the older
notebooks in the collection cannot be packaged this way at all: a few depend on a
database server that has to be set up separately, on lab-internal packages that were
never published, or on package versions that no longer install on a current Python.
Those remain in the repository as a record of how the data were used, but they carry
neither badge and are excluded from the automated testing. Within those limits, though,
the guarantee is strong.

## Contributing a Notebook

Adding a notebook to the collection is simple. A contributor writes the
notebook, adds a `requirements.in` file listing only the packages it directly imports,
and runs one script that resolves the full pinned environment and writes the Colab
install cell into the notebook. From there, everything is automatic: continuous
integration executes the notebook, and when the pull request is merged the container
image is built, verified, and published, and the index updates with both badges. The
contributor never touches Docker. The full instructions are in the repository's
[contributor guide](https://github.com/dandi/example-notebooks/blob/master/docs/adding-notebooks.md).

We would especially welcome notebooks that reproduce published figures. If you have
published a dataset on DANDI and have the analysis code that produced a figure from it,
turning that code into a notebook in this collection is a way to make the figure
permanently reproducible, at the cost of an afternoon.

## Acknowledgments

The notebook collection is a community effort, with contributions from many labs and
from the DANDI and CatalystNeuro teams. Questions and suggestions are welcome on the
[DANDI helpdesk](https://github.com/dandi/helpdesk/issues/new/choose).
