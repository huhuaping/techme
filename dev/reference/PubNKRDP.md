# Details of National Key R&D Plans(NKRDP)

A data set containing NKRDP from the public site
<https://www.sciping.com/keyproject.html#>, with wide data format.

## Usage

``` r
PubNKRDP
```

## Format

A data frame:

- year:

  year marked in the file name

- date:

  date of the data deadline which the web page declaimed

- NO:

  the Number of the NKRDP

- index:

  index in the table of web page

- title:

  title of the NKRDP

- institution:

  executive agency of the NKRDP

- chairman:

  chairman of the NKRDP

- funds:

  offered funds to the NKRDP

- type:

  type of the NKRDP

- duration:

  years duration of the NKRDP

- NO_head:

  decomposed Number of the NKRDP, 'head part', usually "NA"

- NO_year:

  decomposed Number of the NKRDP, 'year' part

- NO_mark:

  decomposed Number of the NKRDP, 'mark' part with format 'YFD' ect.

- NO_num:

  decomposed Number of the NKRDP, 'num' part with digits 7 or 8

- NO_num_p1:

  decomposed Number of the NKRDP, 'num_p1' part with digits 2

- NO_num_p2:

  decomposed Number of the NKRDP, 'num_p2' part with digits 5 or 6

- NO_tail:

  decomposed Number of the NKRDP, 'tail' part which usually "NA" or '\*'

## Source

<https://www.huhuaping.com/>
