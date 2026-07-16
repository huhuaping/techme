# Details of Evaluation Results for Major Scientific Infrastructure and Large-scale Scientific Instruments Sharing

A data set containing the evaluation results of the openness and sharing
of major scientific infrastructure and large-scale scientific
instruments by central universities and research institutes, as
published by the Ministry of Science and Technology of China (MOST). The
data is collected year by year from official public notices and
processed into a unified wide-format data frame.

## Usage

``` r
PubOpenShare
```

## Format

A data frame:

- year:

  integer, the year of the evaluation or public notice

- index:

  integer, the ordered index of the institution in the list

- institution:

  character, name of the evaluated institution (may contain multiple
  institutions separated by comma)

- result:

  character, evaluation result, e.g., "excellent", "good", "qualified",
  "poor"

- administrator:

  character, name of the administrator for the institution (may be empty
  for some years)

- province:

  character, matched province of the institution in reduced Chinese

## Source

Ministry of Science and Technology of China (MOST),
https://www.most.gov.cn/
