# Details of National Crop Germplasm Resource Banks and Nurseries

A data set containing the full list of national crop germplasm resource
banks and nurseries from the National Crop Germplasm Resources
Information Platform, which is public at
<https://ncgrip.cgris.net/web/home/protection>, with wide data format.
Includes long-term banks, mid-term banks, germplasm nurseries, and in
vitro banks. Maintained from 2026 onward, distinct from the year-by-year
approved batch list `PubGeneticResource`.

## Usage

``` r
PubGeneticResourceCrop
```

## Format

A data frame:

- year:

  integer, the scrape / update year of this snapshot

- index:

  integer, the ordered index of the list

- determineYear:

  integer, the official recognition year of the bank or nursery

- province:

  character, province in reduced Chinese

- nature:

  character, type of the facility

- title:

  character, name of the bank or nursery

- institution:

  character, name of the supporting institution

## Source

National Crop Germplasm Resources Information Platform,
<https://ncgrip.cgris.net/web/home/protection>

## Examples

``` r
if (FALSE) { # \dontrun{
str(PubGeneticResourceCrop)
} # }
```
