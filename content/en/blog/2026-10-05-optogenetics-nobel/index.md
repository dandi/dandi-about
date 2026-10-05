---
title: "A Nobel Prize for Controlling the Brain with Light"
author: Ben Dichter
description: >
    The 2026 Nobel Prize in Physiology or Medicine honors optogenetics, a method for switching brain cells on and off with light using a protein borrowed from pond algae. Here is what the technology is, where it came from, and where you can explore open datasets on DANDI that use it.
tags: [ dataset-highlight, optogenetics, nobel-prize ]
date: 2026-10-05
slug: optogenetics-nobel
---

*How a protein from pond algae became one of the most important tools in brain science, and where you can see the data it produces.*

On October 5, 2026, the Nobel Assembly at Karolinska Institutet awarded the [Nobel Prize in Physiology or Medicine](https://www.nobelprize.org/prizes/medicine/2026/press-release/) to Karl Deisseroth, Peter Hegemann and Georg Nagel. The citation is short: "for their discoveries concerning light-gated ion channels and optogenetics."

Optogenetics lets scientists switch specific brain cells on or off with a flash of light. That sounds like science fiction. It is now an everyday method in thousands of laboratories, and it has changed what we can learn about memory, mood, movement and disease.

At the DANDI Archive, we see the results of this work every day. DANDI is a free public library of brain recordings, and many of the datasets shared here were made with the technology honored this week. This post explains what optogenetics is, where it came from, and how anyone can explore the experiments it made possible.

## A light switch for brain cells

Your brain holds roughly 90 billion nerve cells, called neurons. They talk to each other with tiny electrical pulses. Every thought, memory and movement is a pattern of those pulses.

For most of the last century, scientists could watch this activity but could not control it precisely. They could see that a group of neurons was busy when an animal felt afraid. They could not prove those neurons *caused* the fear. Older tools, such as electrical stimulation or drugs, affected every cell in the neighborhood at once.

Optogenetics solves this with two ingredients, which give it its name:

- **Genetics.** Scientists give chosen neurons the instructions to build a light-sensitive protein. Only the cell type they pick receives it.
- **Optics.** A hair-thin optical fiber delivers light to that part of the brain. Neurons carrying the protein respond within thousandths of a second. Their neighbors do not.

Some of these proteins turn neurons on. Others turn them off. Researchers can now ask a direct question: what happens to behavior when this exact group of cells is switched on, or silenced, at this exact moment?

Think of the brain as a city at night. Earlier methods could show which neighborhoods were lit up. Optogenetics lets you flip the switch in a single house and see what changes.

## It started with algae that swim toward light

The story does not begin in a brain lab. It begins with *Chlamydomonas*, a single-celled green alga found in ponds and soil. It has a tiny orange "eyespot" and swims toward light.

In the early 1990s, Peter Hegemann wondered how it reacts so quickly. He measured an electrical response half a millisecond after light hit the eyespot. That is more than twenty times faster than the human eye. He proposed that a single protein both catches light and lets electrical charge into the cell. Many colleagues were skeptical.

About a decade later, Hegemann teamed up with Georg Nagel. Nagel put two candidate algae genes into frog eggs and showed that Hegemann was right. They named the proteins channelrhodopsins, and described them in papers in [2002](https://doi.org/10.1126/science.1072068) and [2003](https://doi.org/10.1073/pnas.1936192100). They also showed that other kinds of cells became light-sensitive when given the gene.

Karl Deisseroth, a psychiatrist and neuroscientist at Stanford, was looking for exactly such a protein. He wanted better ways to understand the illnesses he saw in his patients. He wrote to Nagel and asked for the DNA. In [2005](https://doi.org/10.1038/nn1525), his group reported that rat neurons carrying the algae protein fired on command when lit with blue light. In 2007, they made it work in the brains of living mice, steering whisker movements through an optical fiber.

| Year | Milestone |
| --- | --- |
| Early 1990s | Hegemann measures the algae's ultrafast response to light and proposes a light-gated channel |
| 2002–2003 | Nagel and Hegemann identify channelrhodopsin-1 and channelrhodopsin-2 |
| 2005 | Deisseroth's group controls rat neurons in a dish with blue light |
| 2006 | The method gets its name: optogenetics |
| 2007 | First control of neurons in the brains of living mice |
| 2012 | Researchers reactivate a specific fear memory in mice |
| 2021 | A clinical trial reports partial recovery of vision in a blind patient with retinitis pigmentosa |

Dates are from the Nobel Committee's [popular science background](https://www.nobelprize.org/prizes/medicine/2026/popular-information/).

Three names are on the prize, but many hands built the field. The 2005 paper was co-authored by Edward Boyden, Feng Zhang and Ernst Bamberg, alongside Nagel and Deisseroth. Hundreds of labs have since added new proteins, new colors of light and new ways to deliver them.

There is a lesson here about curiosity. Nobody studying pond algae in 1990 was trying to treat blindness or understand depression. Basic research paid off in a direction no one could have planned.

## Optogenetics on the DANDI Archive

When a lab runs an optogenetics experiment, it records what the neurons and the animal did before, during and after each flash of light. Those recordings are the raw evidence behind the discoveries. More and more labs now share them openly on DANDI, so that anyone can check the results or ask new questions of the same data.

A search for "optogenetic" on DANDI returns 68 datasets as of October 5, 2026. Here are six that show the range of questions this tool can help answer.

| Question | What the researchers did | Dataset |
| --- | --- | --- |
| How does the brain hold a plan in mind? | Mice had to wait a moment before licking left or right. Briefly silencing the motor cortex or the thalamus on one side with light biased their choices. Silencing either region also shut down activity in the other, suggesting the two keep the plan alive together. | [DANDI:000009](https://dandiarchive.org/dandiset/000009) (Svoboda lab, [paper](https://doi.org/10.1038/nature22324)) |
| What does dopamine do when no reward is on offer? | Light was used to nudge dopamine at precise moments while mice roamed freely. Small boosts made the mice more likely to repeat whatever they had just been doing. | [DANDI:000559](https://dandiarchive.org/dandiset/000559) (Datta lab, [paper](https://doi.org/10.1038/s41586-022-05611-2)) |
| How does a habit become a compulsion? | Turning dopamine signals up in one part of the striatum sped the shift to compulsive reward seeking in mice. Turning them down delayed it. | [DANDI:000971](https://dandiarchive.org/dandiset/000971) (Lerner lab, [paper](https://doi.org/10.1016/j.cub.2022.01.055)) |
| How do signals travel through a whole brain? | In a tiny worm, researchers lit up neurons one at a time and watched the rest of the brain respond. They measured 23,433 pairs of neurons and found signals that the wiring diagram alone did not predict. | [DANDI:001075](https://dandiarchive.org/dandiset/001075) (Leifer lab, [paper](https://doi.org/10.1038/s41586-023-06683-4)) |
| How do neurons weigh their inputs? | Gentle light pulses were used to probe hippocampal neurons in freely moving mice, revealing hidden "place fields" in cells that had not shown one. | [DANDI:000568](https://dandiarchive.org/dandiset/000568) (Buzsáki lab, [paper](https://doi.org/10.1126/science.abm1891)) |
| Could light calm overactive human brain tissue? | Slices of human hippocampus, donated by patients having epilepsy surgery, were given light-sensitive proteins. Light then lowered the tissue's firing under conditions that provoke overactivity. | [DANDI:001132](https://dandiarchive.org/dandiset/001132) ([paper](https://doi.org/10.1038/s41593-024-01782-5)) |

Several newer datasets apply the same tool to Parkinson's disease. In [DANDI:001933](https://dandiarchive.org/dandiset/001933), light activates the dopamine neurons most vulnerable in the disease, to test how a Parkinson's-linked gene affects them. [DANDI:001832](https://dandiarchive.org/dandiset/001832) uses light in brain slices to show how one circuit in the striatum is disrupted in parkinsonian mice. [DANDI:001538](https://dandiarchive.org/dandiset/001538) uses it to probe the involuntary movements that can follow long-term levodopa treatment.

Notice the pattern across these studies. Each one goes beyond watching the brain. It changes something specific and measures what follows. That move from correlation to cause is what the Nobel Committee recognized.

## Why sharing the data matters

Optogenetics spread fast because its inventors shared it. Deisseroth got the channelrhodopsin DNA by writing to Nagel and asking. His lab then sent the tools to thousands of other labs.

Open data follows the same idea. Brain experiments are slow and costly, and most are paid for with public money. When the recordings are shared, other scientists can verify the findings, combine studies, and test ideas the original team never thought of. Students anywhere in the world can learn from real data.

DANDI is funded by the U.S. National Institutes of Health through the BRAIN Initiative. It holds more than 1,100 datasets and over 2 petabytes of data, free to anyone.

You do not need to be a scientist to look around:

- Browse the archive at [dandiarchive.org](https://dandiarchive.org) and search for a topic such as "optogenetics," "memory" or "Parkinson's."
- Open any dataset above to read its description and see who made it.
- If you write code, try the [example notebooks](https://github.com/dandi/example-notebooks) that walk through loading and plotting real recordings.

Congratulations to Karl Deisseroth, Peter Hegemann and Georg Nagel, and to the many researchers whose work with their discovery fills this archive.

## Sources and further reading

- Nobel Assembly at Karolinska Institutet: [press release](https://www.nobelprize.org/prizes/medicine/2026/press-release/) and [popular science background, "A light-sensitive algal protein energised neuroscience"](https://www.nobelprize.org/prizes/medicine/2026/popular-information/)
- HHMI: [Karl Deisseroth wins the 2026 Nobel Prize in Physiology or Medicine](https://www.hhmi.org/news/karl-deisseroth-2026-nobel-prize-physiology-medicine)
- STAT: [2026 Nobel Prize in Medicine awarded for brain research tool called optogenetics](https://www.statnews.com/2026/10/05/nobel-prize-medicine-2026-winner-deisseroth-hegemann-nagel/)
- Scientific American: [2026 Nobel Prize awarded for work on optogenetics](https://www.scientificamerican.com/article/2026-nobel-prize-in-physiology-or-medicine-awarded-to-karl-deisseroth-george-nagel-and-peter-hegemann-for-work-on-optogenetics/)
- Nagel et al., [Channelrhodopsin-1: a light-gated proton channel in green algae](https://doi.org/10.1126/science.1072068), *Science*, 2002
- Nagel et al., [Channelrhodopsin-2, a directly light-gated cation-selective membrane channel](https://doi.org/10.1073/pnas.1936192100), *PNAS*, 2003
- Boyden et al., [Millisecond-timescale, genetically targeted optical control of neural activity](https://doi.org/10.1038/nn1525), *Nature Neuroscience*, 2005
- Sahel et al., [Partial recovery of visual function in a blind patient after optogenetic therapy](https://doi.org/10.1038/s41591-021-01351-4), *Nature Medicine*, 2021
- DANDI Archive: [search results for "optogenetic"](https://dandiarchive.org/dandiset/search?search=optogenetic)
