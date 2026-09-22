---
title: "Suggesting Metadata Improvements to Dandiset Owners"
author: Ben Dichter
description: >
    We are using an AI assistant to find gaps in dandiset metadata, fill them from
    public sources, and send each owner a link that opens the DANDI metadata editor
    with the changes ready to review. Nothing changes on the archive until the owner
    commits.
tags: [ dandi, metadata, fair, orcid, ror, ontologies ]
date: 2026-09-22
slug: metadata-proposals
---

The metadata attached to a dandiset determines how well the data can be found, cited,
and credited. When a dandiset lists the paper it supports, a reader who finds the paper
can find the data and a reader who finds the data can find the paper. When contributors
carry ORCID identifiers, the dataset shows up on their ORCID records. When funders are
linked to their ROR records with award numbers, program officers can trace the data
their grants produced. When the subject field names brain regions and conditions from
standard ontologies, the dandiset can be found by searching for those terms.

Many dandisets are missing some of this. It is common to find a dandiset whose
description cites a paper that is not listed as a related resource, whose authors have
no ORCIDs, whose funders are listed only by name, and whose subject field is empty. Most
of these fields are optional at upload time, the paper often
comes out after the data is shared, and looking up a dozen ORCIDs and ontology terms by
hand is tedious work that is easy to put off.

## The DANDI Metadata Editor

We maintain a metadata editor at
[medit.dandiarchive.org](https://medit.dandiarchive.org). It loads the draft version of
any dandiset, shows its metadata in an editable view, and includes a checklist that
scores the metadata on the items above: license, authors, ORCIDs, affiliations, funders,
subject terms, keywords, a linked publication, and ethics approval. It also has an AI
assistant that can look up papers, ORCIDs, ROR records, and ontology terms and propose
edits. Every edit is held as a pending change and shown as an inline diff, and nothing is
written to the archive until an owner commits it with their own API key.

The editor can also package a set of pending changes as a proposal link. The link
carries the changes and a hash of the metadata they were computed against, and opening it
loads the dandiset with the changes applied and highlighted. Anyone can make a proposal
link, but only an owner can commit it. If the dandiset has been edited since the link was
made, the hash no longer matches and the editor refuses to apply the changes.

## Proposing Changes Across the Archive

Proposal links make it possible to do the tedious part of the work for owners and leave
them the decision. We have built a pipeline that does this across the archive. It runs the editor's checklist on every open dandiset and ranks them by how much
of what is missing could be filled in from public sources. For each dandiset near the top
of that list, an AI assistant (Claude) reads the metadata and searches OpenAlex, Crossref,
ROR, ORCID, the EBI Ontology Lookup Service, the Allen Mouse Brain Atlas, and the
Cognitive Atlas for the missing information, then proposes a set of changes.

Those changes then pass through a set of checks written as ordinary code, separate from
the AI. Every ORCID, ROR identifier, DOI, and ontology term in a proposal must have been
returned by one of the lookups during that dandiset's run, so an identifier the assistant
invents or misremembers is rejected. A person can only be added as an author if they
appear on a paper that is linked to the dandiset. Only structured fields may change: the
title and description are never touched, existing contributors are never removed, and
existing award numbers are left alone. A contact person is only proposed when the choice
is unambiguous, for example when only one contributor has an email address; otherwise the
email asks the owner to choose. The proposed metadata is validated against the DANDI
schema and must not introduce any errors the draft did not already have. Proposals are
capped at twelve changes so that the review stays short.

The pipeline builds the proposal link with the editor's own hashing and diff code and
drafts an email to the dandiset's contact person. The email links to the dandiset,
opens the editor with the proposed changes, lists each change in plain language, and
explains the three steps to accept them: paste a DANDI API key into the editor, read
through the highlighted changes and adjust or discard anything that looks wrong, and
click commit. We read every draft before it is sent.

## What It Found

The first 76 proposals added the following to the dandisets they cover:

| Change | Count |
|---|---|
| ORCIDs for existing contributors | 240 |
| Contributor affiliations linked to ROR | 160 |
| Funder entries with a ROR identifier | 141 |
| Subject terms from UBERON, the Cell Ontology, the Allen Mouse Brain Atlas, disease ontologies, and the Cognitive Atlas | 135 |
| Related publications and preprints | 80 |
| Authors added from a linked paper, with ORCIDs | 32 |

The most valuable single change is usually the paper. Once the assistant finds the
publication a dandiset supports, OpenAlex returns the authors' ORCIDs and institutions and
the funders and award numbers acknowledged in the paper, so one lookup fills in most of
the rest.

## Owners Stay in Control

The emails started going out today. By the end of the first day, owners of three
dandisets had committed the suggested changes. One of them kept most of the proposal,
used the editor's assistant to add further brain regions covered by the recordings, and
published a new version of the dandiset with the improved metadata. Because the proposal only applies to the exact version of
the metadata it was built from, an owner can edit freely before or after, and a link that
has gone stale simply stops working. An owner who disagrees with a change can discard it
in the editor before committing, and we would like to hear about anything the assistant
got wrong so that we can fix it in the pipeline as well as in the dandiset.

If you own a dandiset and have not received one of these emails, you can get the same
help directly. Open your dandiset in [medit.dandiarchive.org](https://medit.dandiarchive.org),
look at the checklist, and ask the assistant to fill in what is missing.
