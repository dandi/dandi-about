---
title: "Find Dandisets Faster with Advanced Search"
author: Ben Dichter
description: >
    The dandiset search box now understands Gmail/GitHub-style `key:value` operators. Filter by species, contributor, role, funder, affiliation, owner, creation date, file type, and more — all from a single input, with an autocomplete dropdown to help you discover what's available.
tags: [ "dandi", "search", "archive", "feature" ]
date: 2026-06-11
---

Until now, searching the [DANDI Archive](https://dandiarchive.org) dandiset list meant typing free text and hoping the words you chose appeared somewhere in a dandiset's metadata. That works well for finding a dataset you already know by name, but it's a blunt instrument when you want to ask a more specific question — *"Which dandisets have mouse electrophysiology data published since 2024?"* or *"What has my lab contributed?"*

The search box now understands a structured, Gmail/GitHub-style syntax that lets you mix free-text terms with `key:value` operators. You can filter by creation date, species, file type, contributor, role, funder, affiliation, owner, and more — all from the same input you already use.

## A few examples

```
neuropixels species:mouse created_after:2023-01-01
author:"Doe, Jane" funder:NIH
data_curator:"Smith, Alice" published_after:2024-01-01
affiliation:Stanford
```

Operators combine with AND. Quoted phrases (`"like this"`) are treated as a single value, and anything you type without a `key:` prefix is full-text matched against the dandiset metadata — exactly the way the original search box worked. So you can adopt the new syntax incrementally, adding one operator at a time to an ordinary text search.

## Discoverable by design

A feature like this only helps if people can find it. So the search field now shows an **autocomplete dropdown** of the available operators, much like the one on GitHub's issue search. Focus the field and you'll see the full list with short descriptions; start typing an operator prefix and it narrows to the matches. Use ↑/↓ to move the highlight, **Enter** or **Tab** to insert an operator, and **Esc** to dismiss. The operators stay out of your way when you don't need them and surface themselves the moment you do.

## What you can filter on

**Dates.** `created_before:` / `created_after:`, `modified_before:` / `modified_after:`, and `published_before:` / `published_after:`, each taking an ISO `YYYY-MM-DD` date.

**Asset content.** `species:`, `approach:`, `technique:`, `standard:`, and `file_type:` match against the metadata of a dandiset's assets. A dandiset matches if at least one of its assets satisfies the predicate, so `species:mouse approach:electrophysiological` finds dandisets that contain some mouse data and some electrophysiology data. `file_type:` accepts friendly aliases like `nwb`, `image`, `text`, and `video`, as well as explicit MIME prefixes.

**Owner.** `owner:` returns dandisets owned by a user, matched case-insensitively against username, email, first name, last name, or full display name.

**Contributors and roles.** `contributor:` matches anyone in the contributor list regardless of role, by name, email, or identifier — which means a Person's ORCID (`0000-0002-2990-9889`) and an Organization's ROR URL both work. On top of that, a set of role-specific operators — `author:`, `contact_person:`, `data_collector:`, `data_curator:`, `data_manager:`, `maintainer:`, `project_leader:`, `funder:`, and `sponsor:` — match a contributor *and* require them to hold the corresponding role. So `author:Doe funder:NIH` finds dandisets where someone named Doe is an author and someone named NIH is a funder (possibly different entries).

**Affiliation.** `affiliation:` queries the nested affiliation field on contributors by organization name or ROR identifier, so you can find every dandiset with a contributor from a given institution: `affiliation:Stanford`.

## Helpful when you get it wrong

Invalid syntax doesn't fail silently. Misspell an operator and you get a suggestion — `specie:mouse` returns *"Unknown search operator 'specie'. Did you mean 'species'?"*. Bad dates, empty values, and unbalanced quotes all return clear, friendly error messages rather than a confusing empty result set.

## It works from the API too

The same syntax works against the REST API through the `?search=` query parameter on `/api/dandisets/`:

```python
import requests

r = requests.get(
    "https://api.dandiarchive.org/api/dandisets/",
    params={"search": "species:mouse author:Doe"},
)
r.json()
```

The full `/swagger/` OpenAPI description lists every operator inline.

## Learn more

The complete operator reference — with every operator, quoting rules, error messages, and a set of practical recipes — lives in the [Advanced Search page of the DANDI documentation](https://docs.dandiarchive.org/user-guide-using/advanced-search/). Give it a try on the [dandiset list](https://dandiarchive.org/dandiset), and let us know what other operators would make your searches easier.
