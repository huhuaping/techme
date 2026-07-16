# Details of Checking result of National Agricultural Sci-tech Park

A data set containing cheking result of National Agricultural Sci-tech
Park year by year from the public site <https://www.most.gov.cn>, with
wide data format.

## Usage

``` r
PubAgriParkCheck
```

## Format

A data frame:

- year:

  integer, year of document

- index:

  integer, the ordered index of list

- name:

  character, name of the agri park

- result:

  character, evaluation result marked in c('good','ok','fail')

- province:

  character, province of agri park in reduced chinese

- doc_num:

  character, officer document number

## Source

<https://www.huhuaping.com/>
