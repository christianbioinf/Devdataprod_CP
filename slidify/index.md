---
title       : Benchmarking read aligners
subtitle    : Course Project of the Developing Data Product Course
author      : Christian Otto
job         : Bioinformatics Group, University of Leipzig, Germany
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # {tomorrow, solarized_light}
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
ext_widgets : {rCharts: ["libraries/highcharts"]}
---
<style>
slides > slide:not(.nobackground):after {
  content: ""
}
</style>

## About
<br/>

- aligning reads from
  [NGS](http://en.wikibooks.org/wiki/Next_Generation_Sequencing_%28NGS%29)
  experiments is an important computational task
- benchmarking of [read
  aligners](http://en.wikipedia.org/wiki/List_of_sequence_alignment_software#Short-Read_Sequence_Alignment)
  is therefore necessary for non-experts to decide on<br/>the "best" tool
  for their specific task
- done as part of my publication ([Otto et
  al., 2014](http://bioinformatics.oxfordjournals.org/content/30/13/1837.abstract))

---

## Problem: Dimensionality

Dimensions of the benchmarking results (current extent in parenthesis):
- datasets (9)
- benchmarking measures (4)
- parameter settings (3)
- selection of up to 6 read aligners (-)

Already with the existing numbers, there would be 9 * 4 * 3 = 108 possible figures.

That's one hell of a boring supplement.

(I know there are tricks to combine some of them together - as I did in the supplement but this will not solve the problem.)

---

## Solution: Shiny app as interactive supplement

- input selection via dropdown list and radio buttons 
- interactive and nice rCharts figures (see below)
- inspect and download raw numbers

<iframe src="fig/h.html" width=100%, height=500></iframe>

---

## Result: [Benchmarks Shiny App](https://christianbioinf.shinyapps.io/Benchmarks/)
<br/>
<img class="center" src="assets/img/screenshot.png" height=350>

