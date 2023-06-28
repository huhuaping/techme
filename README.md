
<!-- README.md is generated from README.Rmd. Please edit that file -->

# techme

<!-- badges: start -->
<!-- badges: end -->

The goal of techme is to supply basic data sets and toolsets to generate
research report( 《中国旱区农业技术发展报告2023new》).

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("huhuaping/techme")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
require(techme)
#> Loading required package: techme
data("varsList")
head(varsList)
#>        variables                                             chn_full_name
#> 1  v1_sc_bzmj_dd         <U+64AD><U+79CD><U+9762><U+79EF>_<U+5927><U+8C46>
#> 2  v1_sc_bzmj_dg         <U+64AD><U+79CD><U+9762><U+79EF>_<U+7A3B><U+8C37>
#> 3  v1_sc_bzmj_dl         <U+64AD><U+79CD><U+9762><U+79EF>_<U+8C46><U+7C7B>
#> 4  v1_sc_bzmj_dm         <U+64AD><U+79CD><U+9762><U+79EF>_<U+5927><U+9EA6>
#> 5 v1_sc_bzmj_ggl <U+64AD><U+79CD><U+9762><U+79EF>_<U+74DC><U+679C><U+7C7B>
#> 6  v1_sc_bzmj_gl         <U+64AD><U+79CD><U+9762><U+79EF>_<U+9AD8><U+7CB1>
#>   short_chn short_eng                    units block1 block2 block3 block4
#> 1      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj     dd
#> 2      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj     dg
#> 3      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj     dl
#> 4      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj     dm
#> 5      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj    ggl
#> 6      <NA>      <NA> <U+5343><U+516C><U+9877>     v1     sc   bzmj     gl
#>         chn_block1       chn_block2                       chn_block3
#> 1 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#> 2 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#> 3 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#> 4 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#> 5 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#> 6 <U+519C><U+4E1A> <U+751F><U+4EA7> <U+64AD><U+79CD><U+9762><U+79EF>
#>                 chn_block4
#> 1         <U+5927><U+8C46>
#> 2         <U+7A3B><U+8C37>
#> 3         <U+8C46><U+7C7B>
#> 4         <U+5927><U+9EA6>
#> 5 <U+74DC><U+679C><U+7C7B>
#> 6         <U+9AD8><U+7CB1>
#>                                                                                      chn_full
#> 1         <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+5927><U+8C46>
#> 2         <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+7A3B><U+8C37>
#> 3         <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+8C46><U+7C7B>
#> 4         <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+5927><U+9EA6>
#> 5 <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+74DC><U+679C><U+7C7B>
#> 6         <U+519C><U+4E1A>;<U+751F><U+4EA7>;<U+64AD><U+79CD><U+9762><U+79EF>;<U+9AD8><U+7CB1>
#>      flag source
#> 1 v2018.6   <NA>
#> 2 v2018.6   <NA>
#> 3 v2018.6   <NA>
#> 4 v2018.6   <NA>
#> 5 v2018.6   <NA>
#> 6 v2018.6   <NA>
```

## Data set list and source

### Basic

#### varsList

**`varsList`**：A data set containing all variables and additional
information, such as unit, chn\_name, eng\_name etc., with wide data
format.

-   Totally 16 columns including: variables, chn\_full\_name,
    short\_chn, short\_eng, units, block1, block2, block3, block4,
    chn\_block1, chn\_block2, chn\_block3, chn\_block4, chn\_full, flag,
    source.

-   Totally 586 rows.

``` r
varsList %>%
  sample_n(size = 10) %>%
  kable()
```

| variables                    | chn\_full\_name                                                                                                                                              | short\_chn                                                                                         | short\_eng | units                        | block1 | block2 | block3 | block4         | chn\_block1                                                                          | chn\_block2                                              | chn\_block3                                                                                        | chn\_block4                                                                                                                                                  | chn\_full                                                                                                                                                                                                                                                                                                                              | flag    | source                                                                                                           |
|:-----------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------|:-----------|:-----------------------------|:-------|:-------|:-------|:---------------|:-------------------------------------------------------------------------------------|:---------------------------------------------------------|:---------------------------------------------------------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------|:-----------------------------------------------------------------------------------------------------------------|
| v5\_zjtr\_jf\_dfcz           | &lt;U+5730&gt;&lt;U+65B9&gt;&lt;U+8D22&gt;&lt;U+653F&gt;&lt;U+8D44&gt;&lt;U+91D1&gt;                                                                         | NA                                                                                                 | NA         | &lt;U+4E07&gt;&lt;U+5143&gt; | v5     | zjtr   | jf     | dfcz           | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+7EFC&gt;&lt;U+5408&gt;&lt;U+5F00&gt;&lt;U+53D1&gt; | &lt;U+8D44&gt;&lt;U+91D1&gt;&lt;U+6295&gt;&lt;U+5165&gt; | &lt;U+7ECF&gt;&lt;U+8D39&gt;                                                                       | &lt;U+5730&gt;&lt;U+65B9&gt;&lt;U+8D22&gt;&lt;U+653F&gt;&lt;U+8D44&gt;&lt;U+91D1&gt;                                                                         | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+7EFC&gt;&lt;U+5408&gt;&lt;U+5F00&gt;&lt;U+53D1&gt;;&lt;U+8D44&gt;&lt;U+91D1&gt;&lt;U+6295&gt;&lt;U+5165&gt;\_&lt;U+7ECF&gt;&lt;U+8D39&gt;;&lt;U+5730&gt;&lt;U+65B9&gt;&lt;U+8D22&gt;&lt;U+653F&gt;&lt;U+8D44&gt;&lt;U+91D1&gt;                                                                       | v2018.6 | NA                                                                                                               |
| v4\_gxtj\_jf\_RDjf           | R&D&lt;U+8BFE&gt;&lt;U+9898&gt;\_&lt;U+6295&gt;&lt;U+5165&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;                                                                    | NA                                                                                                 | NA         | &lt;U+4E07&gt;&lt;U+5143&gt; | v4     | gxtj   | jf     | RDjf           | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+9AD8&gt;&lt;U+6821&gt;&lt;U+7EDF&gt;&lt;U+8BA1&gt; | &lt;U+7ECF&gt;&lt;U+8D39&gt;                                                                       | R&D&lt;U+8BFE&gt;&lt;U+9898&gt;\_&lt;U+6295&gt;&lt;U+5165&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;                                                                    | &lt;U+79D1&gt;&lt;U+6280&gt;;&lt;U+9AD8&gt;&lt;U+6821&gt;&lt;U+7EDF&gt;&lt;U+8BA1&gt;;&lt;U+7ECF&gt;&lt;U+8D39&gt;;R&D&lt;U+8BFE&gt;&lt;U+9898&gt;\_&lt;U+6295&gt;&lt;U+5165&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;                                                                                                                           | v2018.6 | NA                                                                                                               |
| v1\_sc\_dcl\_sl              | &lt;U+6BCF&gt;&lt;U+516C&gt;&lt;U+9877&gt;&lt;U+4EA7&gt;&lt;U+91CF&gt;\_&lt;U+85AF&gt;&lt;U+7C7B&gt;                                                         | NA                                                                                                 | NA         | &lt;U+5343&gt;&lt;U+514B&gt; | v1     | sc     | dcl    | sl             | &lt;U+519C&gt;&lt;U+4E1A&gt;                                                         | &lt;U+751F&gt;&lt;U+4EA7&gt;                             | &lt;U+5355&gt;&lt;U+4EA7&gt;&lt;U+91CF&gt;                                                         | &lt;U+85AF&gt;&lt;U+7C7B&gt;                                                                                                                                 | &lt;U+519C&gt;&lt;U+4E1A&gt;;&lt;U+751F&gt;&lt;U+4EA7&gt;;&lt;U+5355&gt;&lt;U+4EA7&gt;&lt;U+91CF&gt;;&lt;U+85AF&gt;&lt;U+7C7B&gt;                                                                                                                                                                                                      | v2018.6 | NA                                                                                                               |
| v4\_qy\_yfjg\_jfzc           | NA                                                                                                                                                           | NA                                                                                                 | NA         | &lt;U+4E07&gt;&lt;U+5143&gt; | v4     | qy     | yfjg   | jfzc           | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+4F01&gt;&lt;U+4E1A&gt;                             | &lt;U+4F01&gt;&lt;U+4E1A&gt;&lt;U+529E&gt;&lt;U+7814&gt;&lt;U+53D1&gt;&lt;U+673A&gt;&lt;U+6784&gt; | &lt;U+673A&gt;&lt;U+6784&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;&lt;U+652F&gt;&lt;U+51FA&gt;                                                                         | NA                                                                                                                                                                                                                                                                                                                                     | v2019.8 | NA                                                                                                               |
| v4\_jg\_RDry\_syfz           | NA                                                                                                                                                           | NA                                                                                                 | NA         | &lt;U+4EBA&gt;&lt;U+5E74&gt; | v4     | jg     | RDry   | syfz           | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+673A&gt;&lt;U+6784&gt;                             | RD&lt;U+4EBA&gt;&lt;U+5458&gt;                                                                     | &lt;U+8BD5&gt;&lt;U+9A8C&gt;&lt;U+53D1&gt;&lt;U+5C55&gt;&lt;U+5168&gt;&lt;U+65F6&gt;&lt;U+5F53&gt;&lt;U+91CF&gt;                                             | NA                                                                                                                                                                                                                                                                                                                                     | v2019.8 | NA                                                                                                               |
| v4\_cg\_jssc\_ht             | NA                                                                                                                                                           | &lt;U+8F93&gt;&lt;U+51FA&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+5408&gt;&lt;U+540C&gt;&lt;U+6570&gt; | pushn      | &lt;U+9879&gt;               | v4     | cg     | jssc   | ht             | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+6210&gt;&lt;U+679C&gt;                             | &lt;U+6280&gt;&lt;U+672F&gt;&lt;U+8F93&gt;&lt;U+51FA&gt;                                           | &lt;U+6570&gt;&lt;U+91CF&gt;                                                                                                                                 | NA                                                                                                                                                                                                                                                                                                                                     | v2019.8 | NA                                                                                                               |
| v4\_zh\_jsry\_xj             | NA                                                                                                                                                           | &lt;U+5C0F&gt;&lt;U+8BA1&gt;                                                                       | subtotal   | &lt;U+4EBA&gt;               | v4     | zh     | jsry   | xj             | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+7EFC&gt;&lt;U+5408&gt;                             | &lt;U+4E13&gt;&lt;U+4E1A&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+4EBA&gt;&lt;U+5458&gt;               | &lt;U+5C0F&gt;&lt;U+8BA1&gt;                                                                                                                                 | NA                                                                                                                                                                                                                                                                                                                                     | v2019.8 | NA                                                                                                               |
| v4\_qy\_Rdry\_nx             | NA                                                                                                                                                           | NA                                                                                                 | NA         | &lt;U+4EBA&gt;               | v4     | qy     | Rdry   | nx             | &lt;U+79D1&gt;&lt;U+6280&gt;                                                         | &lt;U+4F01&gt;&lt;U+4E1A&gt;                             | RD&lt;U+4EBA&gt;&lt;U+5458&gt;                                                                     | &lt;U+5973&gt;&lt;U+6027&gt;&lt;U+4EBA&gt;&lt;U+5458&gt;                                                                                                     | NA                                                                                                                                                                                                                                                                                                                                     | v2019.8 | NA                                                                                                               |
| v5\_rwwc\_sl\_industry\_cqyz | &lt;U+4EA7&gt;&lt;U+4E1A&gt;&lt;U+5316&gt;&lt;U+7ECF&gt;&lt;U+8425&gt;&lt;U+9879&gt;&lt;U+76EE&gt;\_&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+517B&gt;&lt;U+6B96&gt; | NA                                                                                                 | NA         | &lt;U+4E07&gt;&lt;U+5934&gt; | v5     | rwwc   | sl     | industry\_cqyz | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+7EFC&gt;&lt;U+5408&gt;&lt;U+5F00&gt;&lt;U+53D1&gt; | &lt;U+4EFB&gt;&lt;U+52A1&gt;&lt;U+5B8C&gt;&lt;U+6210&gt; | &lt;U+6570&gt;&lt;U+91CF&gt;                                                                       | &lt;U+4EA7&gt;&lt;U+4E1A&gt;&lt;U+5316&gt;&lt;U+7ECF&gt;&lt;U+8425&gt;&lt;U+9879&gt;&lt;U+76EE&gt;\_&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+517B&gt;&lt;U+6B96&gt; | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+7EFC&gt;&lt;U+5408&gt;&lt;U+5F00&gt;&lt;U+53D1&gt;;&lt;U+4EFB&gt;&lt;U+52A1&gt;&lt;U+5B8C&gt;&lt;U+6210&gt;*&lt;U+6570&gt;&lt;U+91CF&gt;;&lt;U+4EA7&gt;&lt;U+4E1A&gt;&lt;U+5316&gt;&lt;U+7ECF&gt;&lt;U+8425&gt;&lt;U+9879&gt;&lt;U+76EE&gt;*&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+517B&gt;&lt;U+6B96&gt; | v2018.6 | NA                                                                                                               |
| v8\_t6\_nfmccl\_zmyc         | NA                                                                                                                                                           | NA                                                                                                 | NA         | &lt;U+53EA&gt;               | v8     | t6     | nfmccl | zmyc           | &lt;U+79CD&gt;&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+573A&gt;&lt;U+7AD9&gt;               | &lt;U+8868&gt;6                                          | &lt;U+80FD&gt;&lt;U+7E41&gt;&lt;U+6BCD&gt;&lt;U+755C&gt;&lt;U+5B58&gt;&lt;U+680F&gt;               | &lt;U+79CD&gt;&lt;U+7EF5&gt;&lt;U+7F8A&gt;&lt;U+573A&gt;                                                                                                     | NA                                                                                                                                                                                                                                                                                                                                     | v2021.8 | &lt;U+4E2D&gt;&lt;U+56FD&gt;&lt;U+755C&gt;&lt;U+7267&gt;&lt;U+517D&gt;&lt;U+533B&gt;&lt;U+5E74&gt;&lt;U+9274&gt; |

#### BasicProvince

**`BasicProvince`**：A data set containing basic information of province
and its region, with wide data format.

-   Totally 3 columns including: id, province, region\_pro.

-   Totally 32 rows.

``` r
BasicProvince %>%
  sample_n(size = 10) %>%
  kable()
```

|  id | province                     | region\_pro                                |
|----:|:-----------------------------|:-------------------------------------------|
|  21 | &lt;U+6D77&gt;&lt;U+5357&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|  28 | &lt;U+7518&gt;&lt;U+8083&gt; | &lt;U+65F1&gt;&lt;U+533A&gt;               |
|  11 | &lt;U+6D59&gt;&lt;U+6C5F&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|   4 | &lt;U+5C71&gt;&lt;U+897F&gt; | &lt;U+65F1&gt;&lt;U+533A&gt;               |
|  23 | &lt;U+56DB&gt;&lt;U+5DDD&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|   9 | &lt;U+4E0A&gt;&lt;U+6D77&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|  25 | &lt;U+4E91&gt;&lt;U+5357&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|  14 | &lt;U+6C5F&gt;&lt;U+897F&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|  24 | &lt;U+8D35&gt;&lt;U+5DDE&gt; | &lt;U+975E&gt;&lt;U+65F1&gt;&lt;U+533A&gt; |
|   7 | &lt;U+5409&gt;&lt;U+6797&gt; | &lt;U+65F1&gt;&lt;U+533A&gt;               |

#### ProvinceCity

**`ProvinceCity`**：A data set containing Province and City of china.

-   Totally 6 columns including: index, province, city, id,
    province\_clean, city\_clean.

-   Totally 342 rows.

``` r
ProvinceCity %>%
  sample_n(size = 10) %>%
  kable()
```

| index | province                                                                                                         | city                                                                                                                                                       | id           | province\_clean                            | city\_clean                  |
|------:|:-----------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------|:-------------------------------------------|:-----------------------------|
|    11 | &lt;U+6CB3&gt;&lt;U+5317&gt;&lt;U+7701&gt;                                                                       | &lt;U+6CA7&gt;&lt;U+5DDE&gt;&lt;U+5E02&gt;                                                                                                                 | 130900000000 | &lt;U+6CB3&gt;&lt;U+5317&gt;               | &lt;U+6CA7&gt;&lt;U+5DDE&gt; |
|   236 | &lt;U+91CD&gt;&lt;U+5E86&gt;&lt;U+5E02&gt;                                                                       | &lt;U+5E02&gt;&lt;U+8F96&gt;&lt;U+533A&gt;                                                                                                                 | 500100000000 | &lt;U+91CD&gt;&lt;U+5E86&gt;               | uncheck                      |
|    16 | &lt;U+5C71&gt;&lt;U+897F&gt;&lt;U+7701&gt;                                                                       | &lt;U+9633&gt;&lt;U+6CC9&gt;&lt;U+5E02&gt;                                                                                                                 | 140300000000 | &lt;U+5C71&gt;&lt;U+897F&gt;               | &lt;U+9633&gt;&lt;U+6CC9&gt; |
|    63 | &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt;&lt;U+7701&gt;                                                         | &lt;U+9E64&gt;&lt;U+5C97&gt;&lt;U+5E02&gt;                                                                                                                 | 230400000000 | &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt; | &lt;U+9E64&gt;&lt;U+5C97&gt; |
|   187 | &lt;U+6E56&gt;&lt;U+5357&gt;&lt;U+7701&gt;                                                                       | &lt;U+5CB3&gt;&lt;U+9633&gt;&lt;U+5E02&gt;                                                                                                                 | 430600000000 | &lt;U+6E56&gt;&lt;U+5357&gt;               | &lt;U+5CB3&gt;&lt;U+9633&gt; |
|   336 | &lt;U+65B0&gt;&lt;U+7586&gt;&lt;U+7EF4&gt;&lt;U+543E&gt;&lt;U+5C14&gt;&lt;U+81EA&gt;&lt;U+6CBB&gt;&lt;U+533A&gt; | &lt;U+514B&gt;&lt;U+5B5C&gt;&lt;U+52D2&gt;&lt;U+82CF&gt;&lt;U+67EF&gt;&lt;U+5C14&gt;&lt;U+514B&gt;&lt;U+5B5C&gt;&lt;U+81EA&gt;&lt;U+6CBB&gt;&lt;U+5DDE&gt; | 653000000000 | &lt;U+65B0&gt;&lt;U+7586&gt;               | uncheck                      |
|   167 | &lt;U+6CB3&gt;&lt;U+5357&gt;&lt;U+7701&gt;                                                                       | &lt;U+7701&gt;&lt;U+76F4&gt;&lt;U+8F96&gt;&lt;U+53BF&gt;&lt;U+7EA7&gt;&lt;U+884C&gt;&lt;U+653F&gt;&lt;U+533A&gt;&lt;U+5212&gt;                             | 419000000000 | &lt;U+6CB3&gt;&lt;U+5357&gt;               | uncheck                      |
|   191 | &lt;U+6E56&gt;&lt;U+5357&gt;&lt;U+7701&gt;                                                                       | &lt;U+90F4&gt;&lt;U+5DDE&gt;&lt;U+5E02&gt;                                                                                                                 | 431000000000 | &lt;U+6E56&gt;&lt;U+5357&gt;               | &lt;U+90F4&gt;&lt;U+5DDE&gt; |
|   291 | &lt;U+9655&gt;&lt;U+897F&gt;&lt;U+7701&gt;                                                                       | &lt;U+897F&gt;&lt;U+5B89&gt;&lt;U+5E02&gt;                                                                                                                 | 610100000000 | &lt;U+9655&gt;&lt;U+897F&gt;               | &lt;U+897F&gt;&lt;U+5B89&gt; |
|    45 | &lt;U+8FBD&gt;&lt;U+5B81&gt;&lt;U+7701&gt;                                                                       | &lt;U+961C&gt;&lt;U+65B0&gt;&lt;U+5E02&gt;                                                                                                                 | 210900000000 | &lt;U+8FBD&gt;&lt;U+5B81&gt;               | &lt;U+961C&gt;&lt;U+65B0&gt; |

#### 

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

-   Totally 9 columns including: index, name\_origin, name\_search,
    address, tel, url, province, city, province\_raw.

-   Totally 464 rows.

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province                                   | year | chn\_block4                                                                                                                                  |      value | units                                      | variables                 |
|:-------------------------------------------|:-----|:---------------------------------------------------------------------------------------------------------------------------------------------|-----------:|:-------------------------------------------|:--------------------------|
| &lt;U+5B89&gt;&lt;U+5FBD&gt;               | 2011 | &lt;U+5C0F&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;                                                                       |   238.0554 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_xtlj      |
| &lt;U+7518&gt;&lt;U+8083&gt;               | 2017 | &lt;U+5C0F&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;&lt;U+914D&gt;&lt;U+5957&gt;&lt;U+519C&gt;&lt;U+5177&gt;               |   139.0000 | &lt;U+4E07&gt;&lt;U+90E8&gt;               | v7\_sctj\_nyjx\_xtlj\_pt  |
| &lt;U+5317&gt;&lt;U+4EAC&gt;               | 2014 | &lt;U+673A&gt;&lt;U+52A8&gt;&lt;U+8131&gt;&lt;U+7C92&gt;&lt;U+673A&gt;                                                                       |     0.3900 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_jdtlj     |
| &lt;U+5C71&gt;&lt;U+4E1C&gt;               | 2011 | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+673A&gt;&lt;U+68B0&gt;&lt;U+603B&gt;&lt;U+52A8&gt;&lt;U+529B&gt;                                           | 12098.3000 | &lt;U+4E07&gt;&lt;U+5343&gt;&lt;U+74E6&gt; | v7\_sctj\_nyjx\_zdl       |
| &lt;U+5317&gt;&lt;U+4EAC&gt;               | 2013 | &lt;U+8054&gt;&lt;U+5408&gt;&lt;U+6536&gt;&lt;U+83B7&gt;&lt;U+673A&gt;                                                                       |     0.1900 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_lhshj     |
| &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt; | 2015 | &lt;U+5927&gt;&lt;U+4E2D&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;&lt;U+914D&gt;&lt;U+5957&gt;&lt;U+519C&gt;&lt;U+5177&gt; |    60.3000 | &lt;U+4E07&gt;&lt;U+90E8&gt;               | v7\_sctj\_nyjx\_dztlj\_pt |
| &lt;U+5929&gt;&lt;U+6D25&gt;               | 2013 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+6392&gt;&lt;U+704C&gt;&lt;U+7535&gt;&lt;U+52A8&gt;&lt;U+673A&gt;                                           |     3.7600 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_pgddj     |
| &lt;U+5E7F&gt;&lt;U+4E1C&gt;               | 2019 | &lt;U+5927&gt;&lt;U+4E2D&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;                                                         |     2.5000 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_dztlj     |
| &lt;U+4E0A&gt;&lt;U+6D77&gt;               | 2012 | &lt;U+8282&gt;&lt;U+6C34&gt;&lt;U+704C&gt;&lt;U+6E89&gt;&lt;U+7C7B&gt;&lt;U+673A&gt;&lt;U+68B0&gt;                                           |     0.7500 | &lt;U+4E07&gt;&lt;U+5957&gt;               | v7\_sctj\_nyjx\_jsgg      |
| &lt;U+5B81&gt;&lt;U+590F&gt;               | 2018 | &lt;U+8054&gt;&lt;U+5408&gt;&lt;U+6536&gt;&lt;U+83B7&gt;&lt;U+673A&gt;                                                                       |     0.9000 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_lhshj     |

### Yearbook

#### Data from Rural Yearbook

##### AgriMachine

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 4384 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyjx\_dztlj,
    v7\_sctj\_nyjx\_dztlj\_pt, v7\_sctj\_nyjx\_jbmj,
    v7\_sctj\_nyjx\_jdtlj, v7\_sctj\_nyjx\_jgmj, v7\_sctj\_nyjx\_jsgg,
    v7\_sctj\_nyjx\_jsmj, v7\_sctj\_nyjx\_lhshj, v7\_sctj\_nyjx\_nysb,
    v7\_sctj\_nyjx\_pgcyj, v7\_sctj\_nyjx\_pgddj, v7\_sctj\_nyjx\_xtlj,
    v7\_sctj\_nyjx\_xtlj\_pt, v7\_sctj\_nyjx\_zdl

``` r
AgriMachine %>%
  sample_n(size = 10) %>%
  kable()
```

| province                                   | year | chn\_block4                                                                                        |   value | units                                      | variables             |
|:-------------------------------------------|:-----|:---------------------------------------------------------------------------------------------------|--------:|:-------------------------------------------|:----------------------|
| &lt;U+91CD&gt;&lt;U+5E86&gt;               | 2016 | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+673A&gt;&lt;U+68B0&gt;&lt;U+603B&gt;&lt;U+52A8&gt;&lt;U+529B&gt; | 1318.70 | &lt;U+4E07&gt;&lt;U+5343&gt;&lt;U+74E6&gt; | v7\_sctj\_nyjx\_zdl   |
| &lt;U+8FBD&gt;&lt;U+5B81&gt;               | 2015 | &lt;U+8282&gt;&lt;U+6C34&gt;&lt;U+704C&gt;&lt;U+6E89&gt;&lt;U+7C7B&gt;&lt;U+673A&gt;&lt;U+68B0&gt; |   13.33 | &lt;U+4E07&gt;&lt;U+5957&gt;               | v7\_sctj\_nyjx\_jsgg  |
| &lt;U+9752&gt;&lt;U+6D77&gt;               | 2016 | &lt;U+5927&gt;&lt;U+4E2D&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;               |    1.78 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_dztlj |
| &lt;U+5C71&gt;&lt;U+897F&gt;               | 2014 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+6392&gt;&lt;U+704C&gt;&lt;U+7535&gt;&lt;U+52A8&gt;&lt;U+673A&gt; |   14.55 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_pgddj |
| &lt;U+91CD&gt;&lt;U+5E86&gt;               | 2017 | &lt;U+673A&gt;&lt;U+6536&gt;&lt;U+9762&gt;&lt;U+79EF&gt;                                           |  577.80 | &lt;U+5343&gt;&lt;U+516C&gt;&lt;U+9877&gt; | v7\_sctj\_nyjx\_jsmj  |
| &lt;U+91CD&gt;&lt;U+5E86&gt;               | 2019 | &lt;U+673A&gt;&lt;U+64AD&gt;&lt;U+9762&gt;&lt;U+79EF&gt;                                           |  263.40 | &lt;U+5343&gt;&lt;U+516C&gt;&lt;U+9877&gt; | v7\_sctj\_nyjx\_jbmj  |
| &lt;U+5185&gt;&lt;U+8499&gt;&lt;U+53E4&gt; | 2019 | &lt;U+673A&gt;&lt;U+8015&gt;&lt;U+9762&gt;&lt;U+79EF&gt;                                           | 7089.60 | &lt;U+5343&gt;&lt;U+516C&gt;&lt;U+9877&gt; | v7\_sctj\_nyjx\_jgmj  |
| &lt;U+5C71&gt;&lt;U+4E1C&gt;               | 2015 | &lt;U+5C0F&gt;&lt;U+578B&gt;&lt;U+62D6&gt;&lt;U+62C9&gt;&lt;U+673A&gt;                             |  103.30 | &lt;U+4E07&gt;&lt;U+53F0&gt;               | v7\_sctj\_nyjx\_xtlj  |
| &lt;U+4E0A&gt;&lt;U+6D77&gt;               | 2011 | &lt;U+8282&gt;&lt;U+6C34&gt;&lt;U+704C&gt;&lt;U+6E89&gt;&lt;U+7C7B&gt;&lt;U+673A&gt;&lt;U+68B0&gt; |    0.73 | &lt;U+4E07&gt;&lt;U+5957&gt;               | v7\_sctj\_nyjx\_jsgg  |
| &lt;U+7518&gt;&lt;U+8083&gt;               | 2018 | &lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+673A&gt;&lt;U+68B0&gt;&lt;U+603B&gt;&lt;U+52A8&gt;&lt;U+529B&gt; | 2102.80 | &lt;U+4E07&gt;&lt;U+5343&gt;&lt;U+74E6&gt; | v7\_sctj\_nyjx\_zdl   |

##### AgriFertilizer

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 448 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyhf\_df, v7\_sctj\_nyhf\_fhf,
    v7\_sctj\_nyhf\_hj, v7\_sctj\_nyhf\_jf, v7\_sctj\_nyhf\_lf

``` r
AgriFertilizer %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                            |  value | units                        | variables          |
|:-----------------------------|:-----|:-----------------------------------------------------------------------|-------:|:-----------------------------|:-------------------|
| &lt;U+65B0&gt;&lt;U+7586&gt; | 2019 | &lt;U+78F7&gt;&lt;U+80A5&gt;                                           |   64.5 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_lf |
| &lt;U+5168&gt;&lt;U+56FD&gt; | 2013 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; | 5911.9 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+6CB3&gt;&lt;U+5357&gt; | 2019 | &lt;U+94BE&gt;&lt;U+80A5&gt;                                           |   55.3 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_jf |
| &lt;U+65B0&gt;&lt;U+7586&gt; | 2017 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |  250.7 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+5929&gt;&lt;U+6D25&gt; | 2010 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |   25.5 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+9752&gt;&lt;U+6D77&gt; | 2015 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |   10.1 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+91CD&gt;&lt;U+5E86&gt; | 2017 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |   95.5 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+897F&gt;&lt;U+85CF&gt; | 2018 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |    5.2 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+5E7F&gt;&lt;U+4E1C&gt; | 2011 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |  241.3 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |
| &lt;U+56DB&gt;&lt;U+5DDD&gt; | 2014 | &lt;U+5316&gt;&lt;U+80A5&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |  250.2 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_nyhf\_hj |

##### AgriPlastic

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 960 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nybm\_bmsy, v7\_sctj\_nybm\_dmfg,
    v7\_sctj\_nybm\_dmsy

``` r
AgriPlastic %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                                                        |   value | units          | variables            |
|:-----------------------------|:-----|:---------------------------------------------------------------------------------------------------|--------:|:---------------|:---------------------|
| &lt;U+798F&gt;&lt;U+5EFA&gt; | 2016 | NA                                                                                                 |   31547 | NA             | v7\_sctj\_nybm\_dmsy |
| &lt;U+5929&gt;&lt;U+6D25&gt; | 2018 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+8584&gt;&lt;U+819C&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |    9070 | &lt;U+5428&gt; | v7\_sctj\_nybm\_bmsy |
| &lt;U+65B0&gt;&lt;U+7586&gt; | 2010 | NA                                                                                                 |  143455 | NA             | v7\_sctj\_nybm\_dmsy |
| &lt;U+56DB&gt;&lt;U+5DDD&gt; | 2015 | NA                                                                                                 | 1002048 | NA             | v7\_sctj\_nybm\_dmfg |
| &lt;U+7518&gt;&lt;U+8083&gt; | 2013 | NA                                                                                                 | 1349000 | NA             | v7\_sctj\_nybm\_dmfg |
| &lt;U+6CB3&gt;&lt;U+5317&gt; | 2012 | NA                                                                                                 | 1159059 | NA             | v7\_sctj\_nybm\_dmfg |
| &lt;U+5B81&gt;&lt;U+590F&gt; | 2011 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+8584&gt;&lt;U+819C&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |   15244 | &lt;U+5428&gt; | v7\_sctj\_nybm\_bmsy |
| &lt;U+5317&gt;&lt;U+4EAC&gt; | 2010 | NA                                                                                                 |    4344 | NA             | v7\_sctj\_nybm\_dmsy |
| &lt;U+5168&gt;&lt;U+56FD&gt; | 2010 | NA                                                                                                 | 1183756 | NA             | v7\_sctj\_nybm\_dmsy |
| &lt;U+91CD&gt;&lt;U+5E86&gt; | 2011 | NA                                                                                                 |  299991 | NA             | v7\_sctj\_nybm\_dmfg |

##### AgriPesticide

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 352 rows.

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_cyny\_cysy, v7\_sctj\_cyny\_nysy

``` r
AgriPesticide %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                                                        |     value | units                        | variables            |
|:-----------------------------|:-----|:---------------------------------------------------------------------------------------------------|----------:|:-----------------------------|:---------------------|
| &lt;U+5168&gt;&lt;U+56FD&gt; | 2018 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             | 1503553.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+5317&gt;&lt;U+4EAC&gt; | 2010 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |    3972.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+6CB3&gt;&lt;U+5317&gt; | 2013 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |   86720.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+6E56&gt;&lt;U+5357&gt; | 2016 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |  118661.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+8D35&gt;&lt;U+5DDE&gt; | 2014 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |   13425.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+798F&gt;&lt;U+5EFA&gt; | 2019 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+67F4&gt;&lt;U+6CB9&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |      81.2 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_cyny\_cysy |
| &lt;U+5E7F&gt;&lt;U+4E1C&gt; | 2017 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |  112958.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+6D77&gt;&lt;U+5357&gt; | 2011 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |   46854.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+5E7F&gt;&lt;U+897F&gt; | 2016 | &lt;U+519C&gt;&lt;U+836F&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt;                             |   85694.0 | &lt;U+5428&gt;               | v7\_sctj\_cyny\_nysy |
| &lt;U+5B81&gt;&lt;U+590F&gt; | 2019 | &lt;U+519C&gt;&lt;U+7528&gt;&lt;U+67F4&gt;&lt;U+6CB9&gt;&lt;U+4F7F&gt;&lt;U+7528&gt;&lt;U+91CF&gt; |      21.5 | &lt;U+4E07&gt;&lt;U+5428&gt; | v7\_sctj\_cyny\_cysy |

#### Data from Sci-Tech Yearbook

##### RDIntense

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 576 rows.

-   Years range from 2011 to 2019

-   Variables including: v4\_ztr\_jf\_RD, v4\_ztr\_qd\_RD

``` r
RDIntense %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                    |  value | units                        | variables       |
|:-----------------------------|:-----|:-------------------------------|-------:|:-----------------------------|:----------------|
| &lt;U+6C5F&gt;&lt;U+82CF&gt; | 2012 | RD&lt;U+5F3A&gt;&lt;U+5EA6&gt; |   2.38 | %                            | v4\_ztr\_qd\_RD |
| &lt;U+5B89&gt;&lt;U+5FBD&gt; | 2013 | RD&lt;U+5F3A&gt;&lt;U+5EA6&gt; |   1.85 | %                            | v4\_ztr\_qd\_RD |
| &lt;U+5C71&gt;&lt;U+897F&gt; | 2012 | RD&lt;U+7ECF&gt;&lt;U+8D39&gt; | 132.30 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_ztr\_jf\_RD |
| &lt;U+91CD&gt;&lt;U+5E86&gt; | 2019 | RD&lt;U+7ECF&gt;&lt;U+8D39&gt; | 469.60 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_ztr\_jf\_RD |
| &lt;U+897F&gt;&lt;U+85CF&gt; | 2011 | RD&lt;U+5F3A&gt;&lt;U+5EA6&gt; |   0.19 | %                            | v4\_ztr\_qd\_RD |
| &lt;U+798F&gt;&lt;U+5EFA&gt; | 2015 | RD&lt;U+7ECF&gt;&lt;U+8D39&gt; | 392.90 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_ztr\_jf\_RD |
| &lt;U+5B89&gt;&lt;U+5FBD&gt; | 2011 | RD&lt;U+5F3A&gt;&lt;U+5EA6&gt; |   1.40 | %                            | v4\_ztr\_qd\_RD |
| &lt;U+5929&gt;&lt;U+6D25&gt; | 2018 | RD&lt;U+5F3A&gt;&lt;U+5EA6&gt; |   2.62 | %                            | v4\_ztr\_qd\_RD |
| &lt;U+8D35&gt;&lt;U+5DDE&gt; | 2012 | RD&lt;U+7ECF&gt;&lt;U+8D39&gt; |  41.70 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_ztr\_jf\_RD |
| &lt;U+6E56&gt;&lt;U+5317&gt; | 2013 | RD&lt;U+7ECF&gt;&lt;U+8D39&gt; | 446.20 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_ztr\_jf\_RD |

##### RDActivity

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 1280 rows.

-   Years range from 2010 to 2019

-   Variables including: v4\_zh\_nbzc\_hj, v4\_zh\_nbzc\_jcyj,
    v4\_zh\_nbzc\_syfz, v4\_zh\_nbzc\_yyyj

``` r
RDActivity %>%
  sample_n(size = 10) %>%
  kable()
```

| province                                   | year | chn\_block4                                              |     value | units                        | variables          |
|:-------------------------------------------|:-----|:---------------------------------------------------------|----------:|:-----------------------------|:-------------------|
| &lt;U+6D59&gt;&lt;U+6C5F&gt;               | 2013 | &lt;U+5E94&gt;&lt;U+7528&gt;&lt;U+7814&gt;&lt;U+7A76&gt; |  398068.4 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_yyyj |
| &lt;U+65B0&gt;&lt;U+7586&gt;               | 2017 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  569519.3 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_hj   |
| &lt;U+5317&gt;&lt;U+4EAC&gt;               | 2015 | &lt;U+5E94&gt;&lt;U+7528&gt;&lt;U+7814&gt;&lt;U+7A76&gt; | 3182636.6 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_yyyj |
| &lt;U+65B0&gt;&lt;U+7586&gt;               | 2015 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  520009.7 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_hj   |
| &lt;U+4E91&gt;&lt;U+5357&gt;               | 2013 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  798371.4 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_hj   |
| &lt;U+6CB3&gt;&lt;U+5357&gt;               | 2013 | &lt;U+5E94&gt;&lt;U+7528&gt;&lt;U+7814&gt;&lt;U+7A76&gt; |  166057.3 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_yyyj |
| &lt;U+6CB3&gt;&lt;U+5357&gt;               | 2013 | &lt;U+57FA&gt;&lt;U+7840&gt;&lt;U+7814&gt;&lt;U+7A76&gt; |   81825.5 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_jcyj |
| &lt;U+9655&gt;&lt;U+897F&gt;               | 2011 | &lt;U+57FA&gt;&lt;U+7840&gt;&lt;U+7814&gt;&lt;U+7A76&gt; |  129869.2 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_jcyj |
| &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt; | 2017 | &lt;U+8BD5&gt;&lt;U+9A8C&gt;&lt;U+53D1&gt;&lt;U+5C55&gt; |  961817.0 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_syfz |
| &lt;U+798F&gt;&lt;U+5EFA&gt;               | 2010 | &lt;U+8BD5&gt;&lt;U+9A8C&gt;&lt;U+53D1&gt;&lt;U+5C55&gt; | 1572225.7 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_zh\_nbzc\_syfz |

##### IndustryOperation

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 384 rows.

-   Years range from 2015 to 2019

-   Variables including: v4\_cy\_scjy\_lrze, v4\_cy\_scjy\_qys,
    v4\_cy\_scjy\_zyyw

``` r
IndustryOperation %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                                          |        value | units                                       | variables          |
|:-----------------------------|:-----|:-------------------------------------------------------------------------------------|-------------:|:--------------------------------------------|:-------------------|
| &lt;U+6C5F&gt;&lt;U+82CF&gt; | 2019 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |   1405.00000 | &lt;U+4E2A&gt;,&lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_cy\_scjy\_lrze |
| &lt;U+65B0&gt;&lt;U+7586&gt; | 2015 | &lt;U+4E3B&gt;&lt;U+8425&gt;&lt;U+4E1A&gt;&lt;U+52A1&gt;&lt;U+6536&gt;&lt;U+5165&gt; |     71.72214 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_zyyw |
| &lt;U+5B89&gt;&lt;U+5FBD&gt; | 2016 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |    238.66142 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_lrze |
| &lt;U+798F&gt;&lt;U+5EFA&gt; | 2018 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |    450.00000 | &lt;U+4E2A&gt;,&lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_cy\_scjy\_lrze |
| &lt;U+5168&gt;&lt;U+56FD&gt; | 2016 | &lt;U+4E3B&gt;&lt;U+8425&gt;&lt;U+4E1A&gt;&lt;U+52A1&gt;&lt;U+6536&gt;&lt;U+5165&gt; | 153796.33451 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_zyyw |
| &lt;U+5B89&gt;&lt;U+5FBD&gt; | 2015 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |    221.94755 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_lrze |
| &lt;U+9752&gt;&lt;U+6D77&gt; | 2016 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |      8.77192 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_lrze |
| &lt;U+8FBD&gt;&lt;U+5B81&gt; | 2018 | &lt;U+4E3B&gt;&lt;U+8425&gt;&lt;U+4E1A&gt;&lt;U+52A1&gt;&lt;U+6536&gt;&lt;U+5165&gt; |   1825.00000 | &lt;U+4E2A&gt;,&lt;U+4EBF&gt;&lt;U+5143&gt; | v4\_cy\_scjy\_zyyw |
| &lt;U+5B81&gt;&lt;U+590F&gt; | 2015 | &lt;U+5229&gt;&lt;U+6DA6&gt;&lt;U+603B&gt;&lt;U+989D&gt;                             |      3.21741 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_lrze |
| &lt;U+5409&gt;&lt;U+6797&gt; | 2015 | &lt;U+4E3B&gt;&lt;U+8425&gt;&lt;U+4E1A&gt;&lt;U+52A1&gt;&lt;U+6536&gt;&lt;U+5165&gt; |   1848.46657 | &lt;U+4EBF&gt;&lt;U+5143&gt;                | v4\_cy\_scjy\_zyyw |

##### IndustryRD

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 2176 rows.

-   Years range from 2016 to 2019

-   Variables including: v4\_cy\_cytz\_gdzc, v4\_cy\_cytz\_jcxm,
    v4\_cy\_cytz\_kgxm, v4\_cy\_cytz\_sgxm, v4\_cy\_cytz\_tzze,
    v4\_cy\_jsgz\_gmzc, v4\_cy\_jsgz\_gzzc, v4\_cy\_jsgz\_xszc,
    v4\_cy\_jsgz\_yjzc, v4\_cy\_qyzl\_fms, v4\_cy\_qyzl\_sqs,
    v4\_cy\_qyzl\_yxs, v4\_cy\_RDhd\_nbzc, v4\_cy\_RDhd\_qsdl,
    v4\_cy\_RDhd\_xmjf, v4\_cy\_RDhd\_xmsl, v4\_cy\_RDhd\_yfjgs,
    v4\_cy\_xcp\_ck, v4\_cy\_xcp\_kfjf, v4\_cy\_xcp\_kfxm,
    v4\_cy\_xcp\_xssr

``` r
IndustryRD %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                                                                                                  |     value | units                        | variables          |
|:-----------------------------|:-----|:---------------------------------------------------------------------------------------------------------------------------------------------|----------:|:-----------------------------|:-------------------|
| &lt;U+5C71&gt;&lt;U+897F&gt; | 2019 | &lt;U+7ECF&gt;&lt;U+8D39&gt;&lt;U+5185&gt;&lt;U+90E8&gt;&lt;U+652F&gt;&lt;U+51FA&gt;                                                         |  133299.0 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_RDhd\_nbzc |
| &lt;U+7518&gt;&lt;U+8083&gt; | 2017 | &lt;U+4EBA&gt;&lt;U+5458&gt;&lt;U+6298&gt;&lt;U+5408&gt;&lt;U+5168&gt;&lt;U+65F6&gt;&lt;U+5F53&gt;&lt;U+91CF&gt;                             |    1442.3 | &lt;U+4EBA&gt;&lt;U+5E74&gt; | v4\_cy\_RDhd\_qsdl |
| &lt;U+6D77&gt;&lt;U+5357&gt; | 2017 | &lt;U+9500&gt;&lt;U+552E&gt;&lt;U+6536&gt;&lt;U+5165&gt;                                                                                     |  202628.5 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_xcp\_xssr  |
| &lt;U+8FBD&gt;&lt;U+5B81&gt; | 2016 | &lt;U+8D2D&gt;&lt;U+4E70&gt;&lt;U+5883&gt;&lt;U+5185&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;&lt;U+652F&gt;&lt;U+51FA&gt; |    2282.5 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_jsgz\_gmzc |
| &lt;U+56DB&gt;&lt;U+5DDD&gt; | 2016 | &lt;U+5F00&gt;&lt;U+53D1&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;&lt;U+652F&gt;&lt;U+51FA&gt;                                                         | 1203951.7 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_xcp\_kfjf  |
| &lt;U+8FBD&gt;&lt;U+5B81&gt; | 2018 | &lt;U+51FA&gt;&lt;U+53E3&gt;                                                                                                                 |  485916.0 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_xcp\_ck    |
| &lt;U+7518&gt;&lt;U+8083&gt; | 2018 | &lt;U+8D2D&gt;&lt;U+4E70&gt;&lt;U+5883&gt;&lt;U+5185&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+7ECF&gt;&lt;U+8D39&gt;&lt;U+652F&gt;&lt;U+51FA&gt; |    6452.0 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_jsgz\_gmzc |
| &lt;U+5B89&gt;&lt;U+5FBD&gt; | 2019 | &lt;U+6709&gt;&lt;U+6548&gt;&lt;U+4E13&gt;&lt;U+5229&gt;&lt;U+6570&gt;                                                                       |    8902.0 | &lt;U+4EF6&gt;               | v4\_cy\_qyzl\_yxs  |
| &lt;U+5C71&gt;&lt;U+4E1C&gt; | 2017 | &lt;U+65BD&gt;&lt;U+5DE5&gt;&lt;U+9879&gt;&lt;U+76EE&gt;&lt;U+4E2A&gt;&lt;U+6570&gt;                                                         |    2110.0 | &lt;U+4E2A&gt;               | v4\_cy\_cytz\_sgxm |
| &lt;U+6E56&gt;&lt;U+5317&gt; | 2019 | &lt;U+53D1&gt;&lt;U+660E&gt;&lt;U+4E13&gt;&lt;U+5229&gt;                                                                                     |    8764.0 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cy\_qyzl\_fms  |

##### IndustryTrade

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 288 rows.

-   Years range from 2016 to 2018

-   Variables including: v4\_cy\_my\_ck, v4\_cy\_my\_jck, v4\_cy\_my\_jk

``` r
IndustryTrade %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                                                            |     value | units                                                    | variables       |
|:-----------------------------|:-----|:-----------------------------------------------------------------------|----------:|:---------------------------------------------------------|:----------------|
| &lt;U+5929&gt;&lt;U+6D25&gt; | 2016 | &lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+603B&gt;&lt;U+989D&gt;               | 38868.143 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jck |
| &lt;U+6CB3&gt;&lt;U+5317&gt; | 2018 | &lt;U+8FDB&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; |  2449.000 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jk  |
| &lt;U+8FBD&gt;&lt;U+5B81&gt; | 2018 | &lt;U+51FA&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; |  7135.000 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_ck  |
| &lt;U+5C71&gt;&lt;U+4E1C&gt; | 2017 | &lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+603B&gt;&lt;U+989D&gt;               | 29368.413 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jck |
| &lt;U+5E7F&gt;&lt;U+897F&gt; | 2017 | &lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+603B&gt;&lt;U+989D&gt;               |  8000.579 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jck |
| &lt;U+6CB3&gt;&lt;U+5357&gt; | 2017 | &lt;U+51FA&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; | 30904.585 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_ck  |
| &lt;U+56DB&gt;&lt;U+5DDD&gt; | 2016 | &lt;U+51FA&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; | 15676.968 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_ck  |
| &lt;U+7518&gt;&lt;U+8083&gt; | 2018 | &lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+603B&gt;&lt;U+989D&gt;               |   713.000 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jck |
| &lt;U+897F&gt;&lt;U+85CF&gt; | 2017 | &lt;U+8FDB&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; |   275.218 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_jk  |
| &lt;U+4E91&gt;&lt;U+5357&gt; | 2016 | &lt;U+51FA&gt;&lt;U+53E3&gt;&lt;U+8D38&gt;&lt;U+6613&gt;&lt;U+989D&gt; |  1492.712 | &lt;U+767E&gt;&lt;U+4E07&gt;&lt;U+7F8E&gt;&lt;U+5143&gt; | v4\_cy\_my\_ck  |

##### MarketPull

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 704 rows.

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssr\_ht, v4\_cg\_jssr\_je

``` r
MarketPull %>%
  sample_n(size = 10) %>%
  kable()
```

| province                     | year | chn\_block4                  |      value | units                        | variables        |
|:-----------------------------|:-----|:-----------------------------|-----------:|:-----------------------------|:-----------------|
| &lt;U+5C71&gt;&lt;U+4E1C&gt; | 2000 | &lt;U+6570&gt;&lt;U+91CF&gt; |   30909.00 | &lt;U+9879&gt;               | v4\_cg\_jssr\_ht |
| &lt;U+4E91&gt;&lt;U+5357&gt; | 2010 | &lt;U+6570&gt;&lt;U+91CF&gt; |    2824.00 | &lt;U+9879&gt;               | v4\_cg\_jssr\_ht |
| &lt;U+5409&gt;&lt;U+6797&gt; | 2013 | &lt;U+91D1&gt;&lt;U+989D&gt; |  469841.62 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssr\_je |
| &lt;U+9655&gt;&lt;U+897F&gt; | 2017 | &lt;U+91D1&gt;&lt;U+989D&gt; | 5218568.64 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssr\_je |
| &lt;U+4E0A&gt;&lt;U+6D77&gt; | 2010 | &lt;U+91D1&gt;&lt;U+989D&gt; | 3291199.52 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssr\_je |
| &lt;U+65B0&gt;&lt;U+7586&gt; | 2017 | &lt;U+91D1&gt;&lt;U+989D&gt; |  985539.02 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssr\_je |
| &lt;U+9752&gt;&lt;U+6D77&gt; | 2010 | &lt;U+6570&gt;&lt;U+91CF&gt; |     882.00 | &lt;U+9879&gt;               | v4\_cg\_jssr\_ht |
| &lt;U+8FBD&gt;&lt;U+5B81&gt; | 2000 | &lt;U+6570&gt;&lt;U+91CF&gt; |    9631.00 | &lt;U+9879&gt;               | v4\_cg\_jssr\_ht |
| &lt;U+4E0A&gt;&lt;U+6D77&gt; | 2017 | &lt;U+6570&gt;&lt;U+91CF&gt; |   22661.00 | &lt;U+9879&gt;               | v4\_cg\_jssr\_ht |
| &lt;U+897F&gt;&lt;U+85CF&gt; | 2013 | &lt;U+91D1&gt;&lt;U+989D&gt; |   72179.73 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssr\_je |

##### MarketPush

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 704 rows.

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssc\_ht, v4\_cg\_jssc\_je

``` r
MarketPush %>%
  sample_n(size = 10) %>%
  kable()
```

| province                                   | year | chn\_block4                  |     value | units                        | variables        |
|:-------------------------------------------|:-----|:-----------------------------|----------:|:-----------------------------|:-----------------|
| &lt;U+5168&gt;&lt;U+56FD&gt;               | 2019 | &lt;U+6570&gt;&lt;U+91CF&gt; |  484077.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt; | 2005 | &lt;U+6570&gt;&lt;U+91CF&gt; |    2041.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+5929&gt;&lt;U+6D25&gt;               | 2015 | &lt;U+6570&gt;&lt;U+91CF&gt; |   12456.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+91CD&gt;&lt;U+5E86&gt;               | 2012 | &lt;U+6570&gt;&lt;U+91CF&gt; |    3538.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+5409&gt;&lt;U+6797&gt;               | 2018 | &lt;U+91D1&gt;&lt;U+989D&gt; | 3419460.3 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssc\_je |
| &lt;U+8FBD&gt;&lt;U+5B81&gt;               | 2016 | &lt;U+6570&gt;&lt;U+91CF&gt; |   13004.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+5E7F&gt;&lt;U+897F&gt;               | 2017 | &lt;U+91D1&gt;&lt;U+989D&gt; |  394227.7 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssc\_je |
| &lt;U+7518&gt;&lt;U+8083&gt;               | 2014 | &lt;U+91D1&gt;&lt;U+989D&gt; | 1145162.3 | &lt;U+4E07&gt;&lt;U+5143&gt; | v4\_cg\_jssc\_je |
| &lt;U+798F&gt;&lt;U+5EFA&gt;               | 2005 | &lt;U+6570&gt;&lt;U+91CF&gt; |    6510.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |
| &lt;U+6C5F&gt;&lt;U+82CF&gt;               | 2015 | &lt;U+6570&gt;&lt;U+91CF&gt; |   32508.0 | &lt;U+9879&gt;               | v4\_cg\_jssc\_ht |

#### Data from China National Yearbook

##### PublicBudget

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 1244 rows.

-   Years range from 2010 to 2019

-   Variables including: v6\_cz\_yszc\_hj, v6\_cz\_yszc\_jy,
    v6\_cz\_yszc\_kxjs, v6\_cz\_yszc\_nls

#### Data from Livestock Yearbook

``` r
PublicBudget %>%
  sample_n(size = 10) %>%
  kable()
```

| province                                   | year | chn\_block4                                              |      value | units                        | variables          |
|:-------------------------------------------|:-----|:---------------------------------------------------------|-----------:|:-----------------------------|:-------------------|
| &lt;U+9655&gt;&lt;U+897F&gt;               | 2015 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  4376.0600 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+5E7F&gt;&lt;U+4E1C&gt;               | 2017 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             | 15037.4788 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+9ED1&gt;&lt;U+9F99&gt;&lt;U+6C5F&gt; | 2019 | &lt;U+519C&gt;&lt;U+6797&gt;&lt;U+6C34&gt;               |   881.9900 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_nls  |
| &lt;U+798F&gt;&lt;U+5EFA&gt;               | 2011 | &lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+6280&gt;&lt;U+672F&gt; |    40.4800 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_kxjs |
| &lt;U+5929&gt;&lt;U+6D25&gt;               | 2018 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  3103.1600 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+9655&gt;&lt;U+897F&gt;               | 2019 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  5718.5200 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+5C71&gt;&lt;U+4E1C&gt;               | 2017 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  9258.3984 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+5185&gt;&lt;U+8499&gt;&lt;U+53E4&gt; | 2014 | &lt;U+6559&gt;&lt;U+80B2&gt;                             |   477.7716 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_jy   |
| &lt;U+9752&gt;&lt;U+6D77&gt;               | 2014 | &lt;U+5408&gt;&lt;U+8BA1&gt;                             |  1347.4303 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_hj   |
| &lt;U+798F&gt;&lt;U+5EFA&gt;               | 2018 | &lt;U+519C&gt;&lt;U+6797&gt;&lt;U+6C34&gt;               |   431.5100 | &lt;U+4EBF&gt;&lt;U+5143&gt; | v6\_cz\_yszc\_nls  |

**`LivestockBreeding`**：A **long format** data set containing Livestock
Breeding statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables.

-   Totally 23712 rows.

-   Years range from 2011 to 2018

-   Variables including: v8\_t1\_zcqc\_zhnc, v8\_t1\_zcqc\_zmc,
    v8\_t1\_zcqc\_zmsyc, v8\_t1\_zcqc\_zmyc, v8\_t1\_zcqc\_znc,
    v8\_t1\_zcqc\_znnc1, v8\_t1\_zcqc\_znnc2, v8\_t1\_zcqc\_zrnc,
    v8\_t1\_zcqc\_zs, v8\_t1\_zcqc\_zsnc, v8\_t1\_zcqc\_zsyc,
    v8\_t1\_zcqc\_zxmyc, v8\_t1\_zcqc\_zyc, v8\_t1\_zcqc\_zzc,
    v8\_t2\_zcqc\_fmddjc, v8\_t2\_zcqc\_fmdrjc, v8\_t2\_zcqc\_qt,
    v8\_t2\_zcqc\_zdjc, v8\_t2\_zcqc\_zdjysdjc,
    v8\_t2\_zcqc\_zdjysrjc（top 20 of totally 98 variables.

### Public site

#### Data from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

##### PubNKRDP

**`PubNKRDP`**：A **wide format** data set containing Details of
National Key R&D Plans(NKRDP) statistics.

-   Totally 17 columns including: year, date, NO, index, title,
    institution, chairman, funds, type, duration, NO\_head, NO\_year,
    NO\_mark, NO\_num, NO\_num\_p1, NO\_num\_p2, NO\_tail.

-   Totally 2579 rows.

-   Years range from 2018 to 2020

``` r
PubNKRDP %>%
  sample_n(size = 10) %>%
  kable()
```

| year | date     | NO              | index | title                                                                                                                                                                                                                                                                                                                                                                                                                                              | institution                                                                                                                                                                                          | chairman                                   | funds   | type                                                                                                                                                                                                 | duration | NO\_head | NO\_year | NO\_mark | NO\_num  | NO\_num\_p1 | NO\_num\_p2 | NO\_tail |
|:-----|:---------|:----------------|:------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------------------------------------------|:--------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------|:---------|:---------|:---------|:---------|:------------|:------------|:---------|
| 2020 | 20201127 | 2020YFB0116000  | 302   | &lt;U+6742&gt;&lt;U+73AF&gt;&lt;U+805A&gt;&lt;U+82B3&gt;&lt;U+919A&gt;&lt;U+6811&gt;&lt;U+8102&gt;&lt;U+57FA&gt;&lt;U+590D&gt;&lt;U+5408&gt;&lt;U+6750&gt;&lt;U+6599&gt;&lt;U+5728&gt;&lt;U+822A&gt;&lt;U+7A7A&gt;&lt;U+53D1&gt;&lt;U+52A8&gt;&lt;U+673A&gt;&lt;U+9AD8&gt;&lt;U+901F&gt;&lt;U+6B62&gt;&lt;U+63A8&gt;&lt;U+8F74&gt;&lt;U+627F&gt;&lt;U+4E0A&gt;&lt;U+7684&gt;&lt;U+5E94&gt;&lt;U+7528&gt;                                           | &lt;U+5927&gt;&lt;U+8FDE&gt;&lt;U+7406&gt;&lt;U+5DE5&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                 | NA                                         | NA      | &lt;U+91CD&gt;&lt;U+70B9&gt;&lt;U+57FA&gt;&lt;U+7840&gt;&lt;U+6750&gt;&lt;U+6599&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+63D0&gt;&lt;U+5347&gt;&lt;U+4E0E&gt;&lt;U+4EA7&gt;&lt;U+4E1A&gt;&lt;U+5316&gt; | NA       |          | 2020     | YFB      | 0116000  | 01          | 16000       | NA       |
| 2018 | 20191015 | 2018YFA0306900  | 29    | &lt;U+4E8C&gt;&lt;U+7EF4&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+529F&gt;&lt;U+80FD&gt;&lt;U+6750&gt;&lt;U+6599&gt;&lt;U+53CA&gt;&lt;U+5176&gt;&lt;U+5F02&gt;&lt;U+8D28&gt;&lt;U+7ED3&gt;&lt;U+6784&gt;&lt;U+7684&gt;&lt;U+5236&gt;&lt;U+5907&gt;&lt;U+3001&gt;&lt;U+8F93&gt;&lt;U+8FD0&gt;&lt;U+6027&gt;&lt;U+8D28&gt;&lt;U+8C03&gt;&lt;U+63A7&gt;&lt;U+4E0E&gt;&lt;U+76F8&gt;&lt;U+5173&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+5668&gt;&lt;U+4EF6&gt; | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                                             | &lt;U+53F6&gt;&lt;U+5809&gt;               | 465     | &lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+8C03&gt;&lt;U+63A7&gt;&lt;U+4E0E&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+4FE1&gt;&lt;U+606F&gt;                                                                       | NA       |          | 2018     | YFA      | 0306900  | 03          | 06900       | NA       |
| 2020 | 20201223 | 2020YFC1512500  | 60    | &lt;U+5B50&gt;&lt;U+6BCD&gt;&lt;U+5F0F&gt;&lt;U+5BA4&gt;&lt;U+5185&gt;&lt;U+5916&gt;&lt;U+7A7A&gt;&lt;U+5730&gt;&lt;U+4E24&gt;&lt;U+7528&gt;&lt;U+707E&gt;&lt;U+60C5&gt;&lt;U+83B7&gt; &lt;U+53D6&gt;&lt;U+673A&gt;&lt;U+5668&gt;&lt;U+4EBA&gt;&lt;U+88C5&gt;&lt;U+5907&gt;&lt;U+784F&gt;&lt;U+53D1&gt;                                                                                                                                            | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+7406&gt;&lt;U+5DE5&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                 | NA                                         | NA      | &lt;U+91CD&gt;&lt;U+5927&gt;&lt;U+81EA&gt;&lt;U+7136&gt;&lt;U+707E&gt;&lt;U+5BB3&gt;&lt;U+76D1&gt;&lt;U+6D4B&gt;&lt;U+9884&gt;&lt;U+8A93&gt;&lt;U+4E0E&gt;&lt;U+9632&gt;&lt;U+8303&gt;               | 4        |          | 2020     | YFC      | 1512500  | 15          | 12500       | NA       |
| 2018 | 20191015 | 2018YFA0702100  | 1345  | &lt;U+57FA&gt;&lt;U+4E8E&gt;&lt;U+591A&gt;&lt;U+91CD&gt;&lt;U+6709&gt;&lt;U+5E8F&gt;&lt;U+7ED3&gt;&lt;U+6784&gt;&lt;U+8C03&gt;&lt;U+63A7&gt;&lt;U+7684&gt;&lt;U+4F4E&gt;&lt;U+6E29&gt;&lt;U+533A&gt;&lt;U+7528&gt;&lt;U+9AD8&gt;&lt;U+6548&gt;&lt;U+4F4E&gt;&lt;U+6210&gt;&lt;U+672C&gt;&lt;U+70ED&gt;&lt;U+7535&gt;&lt;U+6750&gt;&lt;U+6599&gt;&lt;U+4E0E&gt;&lt;U+65B0&gt;&lt;U+578B&gt;&lt;U+5668&gt;&lt;U+4EF6&gt;                             | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+822A&gt;&lt;U+7A7A&gt;&lt;U+822A&gt;&lt;U+5929&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                     | &lt;U+9093&gt;&lt;U+5143&gt;               | 2724.00 | &lt;U+53D8&gt;&lt;U+9769&gt;&lt;U+6027&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+5173&gt;&lt;U+952E&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+95EE&gt;&lt;U+9898&gt;                                           | NA       |          | 2018     | YFA      | 0702100  | 07          | 02100       | NA       |
| 2019 | 20200327 | 2019YFC1907000  | 32    | &lt;U+6709&gt;&lt;U+673A&gt;&lt;U+5371&gt;&lt;U+5E9F&gt;&lt;U+9AD8&gt;&lt;U+6548&gt;&lt;U+6E05&gt;&lt;U+6D01&gt;&lt;U+7A33&gt;&lt;U+5B9A&gt;&lt;U+711A&gt;&lt;U+70E7&gt;&lt;U+5904&gt;&lt;U+7F6E&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+4E0E&gt;&lt;U+88C5&gt;&lt;U+5907&gt;                                                                                                                                                                         | &lt;U+4E2D&gt;&lt;U+8282&gt;&lt;U+80FD&gt;&lt;U+6E05&gt;&lt;U+6D01&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+53D1&gt;&lt;U+5C55&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;               | NA                                         | NA      | &lt;U+56FA&gt;&lt;U+5E9F&gt;&lt;U+8D44&gt;&lt;U+6E90&gt;&lt;U+5316&gt;                                                                                                                               | 4        |          | 2019     | YFC      | 1907000  | 19          | 07000       | NA       |
| 2018 | 20191015 | 2018YFB1306600  | 1163  | &lt;U+6C7D&gt;&lt;U+8F66&gt;&lt;U+677F&gt;&lt;U+6750&gt;&lt;U+673A&gt;&lt;U+5668&gt;&lt;U+4EBA&gt;&lt;U+6FC0&gt;&lt;U+5149&gt;&lt;U+843D&gt;&lt;U+6599&gt;&lt;U+548C&gt;&lt;U+4E09&gt;&lt;U+7EF4&gt;&lt;U+5207&gt;&lt;U+5272&gt;&lt;U+7CFB&gt;&lt;U+7EDF&gt;&lt;U+7814&gt;&lt;U+53D1&gt;&lt;U+4E0E&gt;&lt;U+5E94&gt;&lt;U+7528&gt;                                                                                                                 | &lt;U+91CD&gt;&lt;U+5E86&gt;&lt;U+5143&gt;&lt;U+521B&gt;&lt;U+6C7D&gt;&lt;U+8F66&gt;&lt;U+6574&gt;&lt;U+7EBF&gt;&lt;U+96C6&gt;&lt;U+6210&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt; | &lt;U+6BB5&gt;&lt;U+4E66&gt;&lt;U+51EF&gt; |         | &lt;U+667A&gt;&lt;U+80FD&gt;&lt;U+673A&gt;&lt;U+5668&gt;&lt;U+4EBA&gt;                                                                                                                               | NA       |          | 2018     | YFB      | 1306600  | 13          | 06600       | NA       |
| 2018 | 20191015 | 2018YFF01012000 | 743   | &lt;U+9AD8&gt;&lt;U+901F&gt;&lt;U+6FC0&gt;&lt;U+5149&gt;&lt;U+5171&gt;&lt;U+805A&gt;&lt;U+7126&gt;&lt;U+62C9&gt;&lt;U+66FC&gt;&lt;U+5149&gt;&lt;U+8C31&gt;&lt;U+6210&gt;&lt;U+50CF&gt;&lt;U+4EEA&gt;&lt;U+7814&gt;&lt;U+53D1&gt;&lt;U+53CA&gt;&lt;U+5E94&gt;&lt;U+7528&gt;&lt;U+7814&gt;&lt;U+7A76&gt;                                                                                                                                             | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+5353&gt;&lt;U+7ACB&gt;&lt;U+6C49&gt;&lt;U+5149&gt;&lt;U+4EEA&gt;&lt;U+5668&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                             | &lt;U+90B1&gt;&lt;U+4E3D&gt;&lt;U+8363&gt; | 1526    | &lt;U+91CD&gt;&lt;U+5927&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+4EEA&gt;&lt;U+5668&gt;&lt;U+8BBE&gt;&lt;U+5907&gt;&lt;U+5F00&gt;&lt;U+53D1&gt;                                                         | NA       |          | 2018     | YFF      | 01012000 | 01          | 012000      | NA       |
| 2018 | 20191015 | 2018YFB1702700  | 1134  | &lt;U+57FA&gt;&lt;U+4E8E&gt;&lt;U+5F00&gt;&lt;U+653E&gt;&lt;U+67B6&gt;&lt;U+6784&gt;&lt;U+7684&gt;&lt;U+4E91&gt;&lt;U+5236&gt;&lt;U+9020&gt;&lt;U+5173&gt;&lt;U+952E&gt;&lt;U+6280&gt;&lt;U+672F&gt;&lt;U+4E0E&gt;&lt;U+5E73&gt;&lt;U+53F0&gt;&lt;U+7814&gt;&lt;U+53D1&gt;                                                                                                                                                                         | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+822A&gt;&lt;U+5929&gt;&lt;U+667A&gt;&lt;U+9020&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+53D1&gt;&lt;U+5C55&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt; | &lt;U+5E84&gt;&lt;U+946B&gt;               |         | &lt;U+7F51&gt;&lt;U+7EDC&gt;&lt;U+534F&gt;&lt;U+540C&gt;&lt;U+5236&gt;&lt;U+9020&gt;&lt;U+4E0E&gt;&lt;U+667A&gt;&lt;U+80FD&gt;&lt;U+5DE5&gt;&lt;U+5382&gt;                                           | NA       |          | 2018     | YFB      | 1702700  | 17          | 02700       | NA       |
| 2018 | 20191015 | 2018YFA0306100  | 21    | &lt;U+534A&gt;&lt;U+5BFC&gt;&lt;U+4F53&gt;&lt;U+590D&gt;&lt;U+5408&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+7ED3&gt;&lt;U+6784&gt;&lt;U+7684&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+8F93&gt;&lt;U+8FD0&gt;&lt;U+673A&gt;&lt;U+7406&gt;&lt;U+53CA&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+5668&gt;&lt;U+4EF6&gt;&lt;U+7814&gt;&lt;U+7A76&gt;                                                                                                                 | &lt;U+4E2D&gt;&lt;U+56FD&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;&lt;U+534A&gt;&lt;U+5BFC&gt;&lt;U+4F53&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+6240&gt;                                           | &lt;U+725B&gt;&lt;U+667A&gt;&lt;U+5DDD&gt; | 1859    | &lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+8C03&gt;&lt;U+63A7&gt;&lt;U+4E0E&gt;&lt;U+91CF&gt;&lt;U+5B50&gt;&lt;U+4FE1&gt;&lt;U+606F&gt;                                                                       | NA       |          | 2018     | YFA      | 0306100  | 03          | 06100       | NA       |
| 2018 | 20191015 | 2018YFB1600800  | 1100  | &lt;U+5C01&gt;&lt;U+95ED&gt;&lt;U+548C&gt;&lt;U+534A&gt;&lt;U+5F00&gt;&lt;U+653E&gt;&lt;U+6761&gt;&lt;U+4EF6&gt;&lt;U+4E0B&gt;&lt;U+667A&gt;&lt;U+80FD&gt;&lt;U+8F66&gt;&lt;U+8DEF&gt;&lt;U+7CFB&gt;&lt;U+7EDF&gt;&lt;U+6D4B&gt;&lt;U+8BD5&gt;&lt;U+8BC4&gt;&lt;U+4F30&gt;&lt;U+4E0E&gt;&lt;U+793A&gt;&lt;U+8303&gt;&lt;U+5E94&gt;&lt;U+7528&gt;                                                                                                   | &lt;U+4EA4&gt;&lt;U+901A&gt;&lt;U+8FD0&gt;&lt;U+8F93&gt;&lt;U+90E8&gt;&lt;U+516C&gt;&lt;U+8DEF&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+6240&gt;                             | &lt;U+5C91&gt;&lt;U+664F&gt;&lt;U+9752&gt; |         | &lt;U+7EFC&gt;&lt;U+5408&gt;&lt;U+4EA4&gt;&lt;U+901A&gt;&lt;U+8FD0&gt;&lt;U+8F93&gt;&lt;U+4E0E&gt;&lt;U+667A&gt;&lt;U+80FD&gt;&lt;U+4EA4&gt;&lt;U+901A&gt;                                           | NA       |          | 2018     | YFB      | 1600800  | 16          | 00800       | NA       |

##### PubAgriParkList

**`PubAgriParkList`**：A **wide format** data set containing Details of
Approved List of National Agricultural Sci-tech Park.

-   Totally 4 columns including: index, batch, name, province.

-   Totally 233 rows.

-   Years (Batch) range from 01 to 09

``` r
PubAgriParkList %>%
  sample_n(size = 10) %>%
  kable()
```

| index | batch | name                                                                                                                                                                                                 | province                     |
|------:|:------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------|
|    17 | 09    | &lt;U+5E7F&gt;&lt;U+4E1C&gt;&lt;U+4E91&gt;&lt;U+6D6E&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+5E7F&gt;&lt;U+4E1C&gt; |
|    11 | 09    | &lt;U+5B89&gt;&lt;U+5FBD&gt;&lt;U+9EC4&gt;&lt;U+5C71&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+5B89&gt;&lt;U+5FBD&gt; |
|    19 | 07    | &lt;U+5E7F&gt;&lt;U+897F&gt;&lt;U+8D3A&gt;&lt;U+5DDE&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+5E7F&gt;&lt;U+897F&gt; |
|    11 | 05    | &lt;U+6C5F&gt;&lt;U+897F&gt;&lt;U+4E0A&gt;&lt;U+9976&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+6C5F&gt;&lt;U+897F&gt; |
|    21 | 05    | &lt;U+56DB&gt;&lt;U+5DDD&gt;&lt;U+5B9C&gt;&lt;U+5BBE&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+56DB&gt;&lt;U+5DDD&gt; |
|     3 | 04    | &lt;U+5C71&gt;&lt;U+897F&gt;&lt;U+8FD0&gt;&lt;U+57CE&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+5C71&gt;&lt;U+897F&gt; |
|    10 | 06    | &lt;U+91CD&gt;&lt;U+5E86&gt;&lt;U+4E30&gt;&lt;U+90FD&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+91CD&gt;&lt;U+5E86&gt; |
|     2 | 03    | &lt;U+6D59&gt;&lt;U+6C5F&gt;&lt;U+676D&gt;&lt;U+5DDE&gt;&lt;U+8427&gt;&lt;U+5C71&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt; | &lt;U+6D59&gt;&lt;U+6C5F&gt; |
|    19 | 09    | &lt;U+91CD&gt;&lt;U+5E86&gt;&lt;U+6B66&gt;&lt;U+9686&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                             | &lt;U+91CD&gt;&lt;U+5E86&gt; |
|    18 | 08    | &lt;U+6E56&gt;&lt;U+5357&gt;&lt;U+5F20&gt;&lt;U+5BB6&gt;&lt;U+754C&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;               | &lt;U+6E56&gt;&lt;U+5357&gt; |

##### PubAgriParkEval

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

-   Totally 5 columns including: year, index, name, result, province.

-   Totally 162 rows.

-   Years range from 2019 to 2020

``` r
PubAgriParkEval %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | name                                                                                                                                                                                                               | result | province                                   |
|-----:|------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-------|:-------------------------------------------|
| 2019 |    66 | &lt;U+9655&gt;&lt;U+897F&gt;&lt;U+6768&gt;&lt;U+51CC&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | ok     | &lt;U+9655&gt;&lt;U+897F&gt;               |
| 2020 |    27 | &lt;U+7518&gt;&lt;U+8083&gt;&lt;U+9152&gt;&lt;U+6CC9&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | ok     | &lt;U+7518&gt;&lt;U+8083&gt;               |
| 2019 |    10 | &lt;U+5B89&gt;&lt;U+5FBD&gt;&lt;U+5408&gt;&lt;U+80A5&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | good   | &lt;U+5B89&gt;&lt;U+5FBD&gt;               |
| 2019 |     6 | &lt;U+6C5F&gt;&lt;U+82CF&gt;&lt;U+5357&gt;&lt;U+4EAC&gt;&lt;U+767D&gt;&lt;U+9A6C&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;               | good   | &lt;U+6C5F&gt;&lt;U+82CF&gt;               |
| 2020 |     2 | &lt;U+6CB3&gt;&lt;U+5317&gt;&lt;U+5B9A&gt;&lt;U+5DDE&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | good   | &lt;U+6CB3&gt;&lt;U+5317&gt;               |
| 2019 |    48 | &lt;U+6E56&gt;&lt;U+5357&gt;&lt;U+8861&gt;&lt;U+9633&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | ok     | &lt;U+6E56&gt;&lt;U+5357&gt;               |
| 2020 |     1 | &lt;U+6CB3&gt;&lt;U+5317&gt;&lt;U+77F3&gt;&lt;U+5BB6&gt;&lt;U+5E84&gt;&lt;U+85C1&gt;&lt;U+57CE&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt; | good   | &lt;U+6CB3&gt;&lt;U+5317&gt;               |
| 2019 |     5 | &lt;U+5E7F&gt;&lt;U+897F&gt;&lt;U+6842&gt;&lt;U+6797&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | fail   | &lt;U+5E7F&gt;&lt;U+897F&gt;               |
| 2019 |     2 | &lt;U+5929&gt;&lt;U+6D25&gt;&lt;U+6D25&gt;&lt;U+5357&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt;                                           | ok     | &lt;U+5929&gt;&lt;U+6D25&gt;               |
| 2019 |     2 | &lt;U+5185&gt;&lt;U+8499&gt;&lt;U+53E4&gt;&lt;U+548C&gt;&lt;U+6797&gt;&lt;U+683C&gt;&lt;U+5C14&gt;&lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+56ED&gt;&lt;U+533A&gt; | fail   | &lt;U+5185&gt;&lt;U+8499&gt;&lt;U+53E4&gt; |

#### Data from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

##### PubObsStation

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

-   Totally 6 columns including: officer, year, index, name,
    institution, province.

-   Totally 158 rows.

-   Years range from 2018 to 2019

<!---CARS from MOA---->

``` r
data("PubCars")
```

**`PubCars`**：A **wide format** data set containing Details of China
Agricultural Research System(CARS) from MOA.

-   Totally 16 columns including: year, index, area\_num\_eng,
    area\_name, chairman\_industry, institution\_industry, func\_num,
    func\_name, func\_inst, func\_director, researcher\_area,
    researcher\_name, researcher\_inst, province\_industry,
    province\_func, province\_researcher.

-   Totally 1691 rows.

-   Years range from 2011 to 2021

``` r
PubObsStation %>%
  sample_n(size = 10) %>%
  kable()
```

| officer | year | index | name                                                                                                                                                                                                                                                                                                                                                                                       | institution                                                                                                                                                                                                                                                                | province                     |
|:--------|-----:|:------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------|
| MOA     | 2018 | 14    | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+571F&gt;&lt;U+58E4&gt;&lt;U+8D28&gt;&lt;U+91CF&gt;&lt;U+51C9&gt;&lt;U+5DDE&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                                                                                     | &lt;U+7518&gt;&lt;U+8083&gt;&lt;U+7701&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;                                                                                                                                                           | &lt;U+7518&gt;&lt;U+8083&gt; |
| MOA     | 2019 | 42    | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+571F&gt;&lt;U+58E4&gt;&lt;U+8D28&gt;&lt;U+91CF&gt;&lt;U+5E7F&gt;&lt;U+5DDE&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                             | &lt;U+5E7F&gt;&lt;U+4E1C&gt;&lt;U+7701&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;                                                                                                                                                           | &lt;U+5E7F&gt;&lt;U+4E1C&gt; |
| MOA     | 2019 | 51    | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+571F&gt;&lt;U+58E4&gt;&lt;U+8D28&gt;&lt;U+91CF&gt;&lt;U+6606&gt;&lt;U+660E&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                             | &lt;U+4E91&gt;&lt;U+5357&gt;&lt;U+7701&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;                                                                                                                                                           | &lt;U+4E91&gt;&lt;U+5357&gt; |
| MOA     | 2019 | 59    | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+73AF&gt;&lt;U+5883&gt;&lt;U+897F&gt;&lt;U+5B81&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                             | &lt;U+9752&gt;&lt;U+6D77&gt;&lt;U+7701&gt;&lt;U+519C&gt;&lt;U+6797&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;                                                                                                                                                           | &lt;U+9752&gt;&lt;U+6D77&gt; |
| MOA     | 2018 | 6     | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+79CD&gt;&lt;U+8D28&gt;&lt;U+8D44&gt;&lt;U+6E90&gt;&lt;U+7BA1&gt;&lt;U+57CE&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                                                                                     | &lt;U+4E2D&gt;&lt;U+56FD&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;&lt;U+90D1&gt;&lt;U+5DDE&gt;&lt;U+679C&gt;&lt;U+6811&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+6240&gt;                                                                       | &lt;U+6CB3&gt;&lt;U+5357&gt; |
| MOA     | 2019 | 63    | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+571F&gt;&lt;U+58E4&gt;&lt;U+8D28&gt;&lt;U+91CF&gt;&lt;U+963F&gt;&lt;U+514B&gt;&lt;U+82CF&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                               | &lt;U+65B0&gt;&lt;U+7586&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;                                                                                                                                                                         | &lt;U+65B0&gt;&lt;U+7586&gt; |
| MOE     | 2019 | 32    | &lt;U+5C71&gt;&lt;U+897F&gt;&lt;U+4E9A&gt;&lt;U+9AD8&gt;&lt;U+5C71&gt;&lt;U+8349&gt;&lt;U+5730&gt;&lt;U+751F&gt;&lt;U+6001&gt;&lt;U+7CFB&gt;&lt;U+7EDF&gt;&lt;U+6559&gt;&lt;U+80B2&gt;&lt;U+90E8&gt;&lt;U+91CE&gt;&lt;U+5916&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+7AD9&gt;                                                         | &lt;U+5C71&gt;&lt;U+897F&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                                                                                                                   | &lt;U+5C71&gt;&lt;U+897F&gt; |
| MOE     | 2019 | 13    | &lt;U+677E&gt;&lt;U+5AE9&gt;&lt;U+8349&gt;&lt;U+5730&gt;&lt;U+751F&gt;&lt;U+6001&gt;&lt;U+7CFB&gt;&lt;U+7EDF&gt;&lt;U+6559&gt;&lt;U+80B2&gt;&lt;U+90E8&gt;&lt;U+91CE&gt;&lt;U+5916&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+7AD9&gt;                                                                                                   | &lt;U+4E1C&gt;&lt;U+5317&gt;&lt;U+5E08&gt;&lt;U+8303&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                                                                                       | &lt;U+5409&gt;&lt;U+6797&gt; |
| MOA     | 2018 | 4     | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+571F&gt;&lt;U+58E4&gt;&lt;U+8D28&gt;&lt;U+91CF&gt;&lt;U+6D1B&gt;&lt;U+9F99&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+5B9E&gt;&lt;U+9A8C&gt;&lt;U+7AD9&gt;                                                                                                                                                                                                     | &lt;U+4E2D&gt;&lt;U+56FD&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+9662&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+8D44&gt;&lt;U+6E90&gt;&lt;U+4E0E&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+533A&gt;&lt;U+5212&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+6240&gt; | &lt;U+5317&gt;&lt;U+4EAC&gt; |
| MOE     | 2019 | 28    | &lt;U+5317&gt;&lt;U+65B9&gt;&lt;U+7F3A&gt;&lt;U+6C34&gt;&lt;U+5730&gt;&lt;U+533A&gt;&lt;U+5178&gt;&lt;U+578B&gt;&lt;U+4E0B&gt;&lt;U+57AB&gt;&lt;U+9762&gt;&lt;U+751F&gt;&lt;U+6001&gt;&lt;U+6C34&gt;&lt;U+6587&gt;&lt;U+6559&gt;&lt;U+80B2&gt;&lt;U+90E8&gt;&lt;U+91CE&gt;&lt;U+5916&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+89C2&gt;&lt;U+6D4B&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+7AD9&gt; | &lt;U+6E05&gt;&lt;U+534E&gt;&lt;U+5927&gt;&lt;U+5B66&gt;                                                                                                                                                                                                                   | &lt;U+5317&gt;&lt;U+4EAC&gt; |

##### PubBreedingXmj

**`PubBreedingXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

-   Totally 7 columns including: year, index, province, type,
    name\_origin, name\_change, mark.

-   Totally 287 rows.

-   Years range from 2010 to 2020

``` r
PubBreedingXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province                     | type                                                                                                                                                                     | name\_origin                                                                                                                                                                                                                                                               | name\_change                                                                                                                                                                                         | mark                                                     |
|:-----|:------|:-----------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:---------------------------------------------------------|
| 2015 | 7     | &lt;U+6C5F&gt;&lt;U+897F&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+751F&gt;&lt;U+732A&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+6C5F&gt;&lt;U+897F&gt;&lt;U+52A0&gt;&lt;U+5927&gt;&lt;U+79CD&gt;&lt;U+732A&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                               | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2015 | 1     | &lt;U+6C5F&gt;&lt;U+82CF&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+8089&gt;&lt;U+9E21&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+6C5F&gt;&lt;U+82CF&gt;&lt;U+7701&gt;&lt;U+5BB6&gt;&lt;U+79BD&gt;&lt;U+79D1&gt;&lt;U+5B66&gt;&lt;U+7814&gt;&lt;U+7A76&gt;&lt;U+6240&gt;&lt;U+5BB6&gt;&lt;U+79BD&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+4E2D&gt;&lt;U+5FC3&gt;                                           | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2014 | 8     | &lt;U+56DB&gt;&lt;U+5DDD&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+86CB&gt;&lt;U+9E21&gt;&lt;U+826F&gt;&lt;U+79CD&gt;&lt;U+6269&gt;&lt;U+7E41&gt;&lt;U+63A8&gt;&lt;U+5E7F&gt;&lt;U+57FA&gt;&lt;U+5730&gt; | &lt;U+56DB&gt;&lt;U+5DDD&gt;&lt;U+5723&gt;&lt;U+8FEA&gt;&lt;U+4E50&gt;&lt;U+6751&gt;&lt;U+751F&gt;&lt;U+6001&gt;&lt;U+98DF&gt;&lt;U+54C1&gt;&lt;U+80A1&gt;&lt;U+4EFD&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                           | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2015 | 3     | &lt;U+6D59&gt;&lt;U+6C5F&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+8089&gt;&lt;U+9E21&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+6D59&gt;&lt;U+6C5F&gt;&lt;U+5149&gt;&lt;U+5927&gt;&lt;U+79CD&gt;&lt;U+79BD&gt;&lt;U+4E1A&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                 | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2010 | 1     | &lt;U+5317&gt;&lt;U+4EAC&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+751F&gt;&lt;U+732A&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+5317&gt;&lt;U+4EAC&gt;&lt;U+987A&gt;&lt;U+946B&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+80A1&gt;&lt;U+4EFD&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;&lt;U+5C0F&gt;&lt;U+5E97&gt;&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+826F&gt;&lt;U+79CD&gt;&lt;U+573A&gt; | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2012 | 12    | &lt;U+6E56&gt;&lt;U+5357&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+751F&gt;&lt;U+732A&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+6E56&gt;&lt;U+5357&gt;&lt;U+5929&gt;&lt;U+5FC3&gt;&lt;U+79CD&gt;&lt;U+4E1A&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                               | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2017 | 3     | &lt;U+5C71&gt;&lt;U+4E1C&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+8089&gt;&lt;U+725B&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+5C71&gt;&lt;U+4E1C&gt;&lt;U+65E0&gt;&lt;U+68E3&gt;&lt;U+534E&gt;&lt;U+5174&gt;&lt;U+6E24&gt;&lt;U+6D77&gt;&lt;U+9ED1&gt;&lt;U+725B&gt;&lt;U+79CD&gt;&lt;U+4E1A&gt;&lt;U+80A1&gt;&lt;U+4EFD&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;               | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2018 | 2     | &lt;U+6CB3&gt;&lt;U+5357&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+8089&gt;&lt;U+7F8A&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+6CB3&gt;&lt;U+5357&gt;&lt;U+4E09&gt;&lt;U+9633&gt;&lt;U+755C&gt;&lt;U+7267&gt;&lt;U+80A1&gt;&lt;U+4EFD&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                   | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |
| 2017 | 2     | &lt;U+6CB3&gt;&lt;U+5317&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+751F&gt;&lt;U+732A&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+77F3&gt;&lt;U+5BB6&gt;&lt;U+5E84&gt;&lt;U+53CC&gt;&lt;U+9E3D&gt;&lt;U+98DF&gt;&lt;U+54C1&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+8D23&gt;&lt;U+4EFB&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                     | &lt;U+6CB3&gt;&lt;U+5317&gt;&lt;U+53CC&gt;&lt;U+9E3D&gt;&lt;U+7F8E&gt;&lt;U+4E39&gt;&lt;U+755C&gt;&lt;U+7267&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt; | &lt;U+540D&gt;&lt;U+79F0&gt;&lt;U+53D8&gt;&lt;U+66F4&gt; |
| 2019 | 4     | &lt;U+7518&gt;&lt;U+8083&gt; | &lt;U+56FD&gt;&lt;U+5BB6&gt;&lt;U+8089&gt;&lt;U+725B&gt;&lt;U+6838&gt;&lt;U+5FC3&gt;&lt;U+80B2&gt;&lt;U+79CD&gt;&lt;U+573A&gt;                                           | &lt;U+7518&gt;&lt;U+8083&gt;&lt;U+5171&gt;&lt;U+88D5&gt;&lt;U+9AD8&gt;&lt;U+65B0&gt;&lt;U+519C&gt;&lt;U+7267&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+5F00&gt;&lt;U+53D1&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                           | NA                                                                                                                                                                                                   | &lt;U+9074&gt;&lt;U+9009&gt;&lt;U+516C&gt;&lt;U+793A&gt; |

##### PubStandardXmj

**`PubStandardXmj`**：A **wide format** data set containing details of
Officer’ Livestock Breeding List from MOA (Xmj).

-   Totally 5 columns including: year, index, province, prod\_name,
    com\_name.

-   Totally 3377 rows.

-   Years range from 2010 to 2020

``` r
PubStandardXmj %>%
  sample_n(size = 10) %>%
  kable()
```

| year | index | province                     | prod\_name                   | com\_name                                                                                                                                                                                                                                                                                                            |
|:-----|:------|:-----------------------------|:-----------------------------|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 2016 | 186   | &lt;U+5B89&gt;&lt;U+5FBD&gt; | &lt;U+751F&gt;&lt;U+732A&gt; | &lt;U+660E&gt;&lt;U+5EB7&gt;&lt;U+6C47&gt;&lt;U+751F&gt;&lt;U+6001&gt;&lt;U+519C&gt;&lt;U+4E1A&gt;&lt;U+96C6&gt;&lt;U+56E2&gt;&lt;U+660E&gt;&lt;U+5149&gt;&lt;U+517B&gt;&lt;U+6B96&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                       |
| 2016 | 463   | &lt;U+56DB&gt;&lt;U+5DDD&gt; | &lt;U+8089&gt;&lt;U+725B&gt; | &lt;U+4E50&gt;&lt;U+5C71&gt;&lt;U+5E02&gt;&lt;U+5C71&gt;&lt;U+5730&gt;&lt;U+755C&gt;&lt;U+7267&gt;&lt;U+4E13&gt;&lt;U+4E1A&gt;&lt;U+5408&gt;&lt;U+4F5C&gt;&lt;U+793E&gt;&lt;U+5251&gt;&lt;U+950B&gt;&lt;U+8089&gt;&lt;U+725B&gt;&lt;U+517B&gt;&lt;U+6B96&gt;&lt;U+573A&gt;                                           |
| 2013 | 56    | &lt;U+8FBD&gt;&lt;U+5B81&gt; | &lt;U+8089&gt;&lt;U+9E21&gt; | &lt;U+6C88&gt;&lt;U+9633&gt;&lt;U+534E&gt;&lt;U+7F8E&gt;&lt;U+755C&gt;&lt;U+79BD&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;&lt;U+76D8&gt;&lt;U+53E4&gt;&lt;U+53F0&gt;&lt;U+8089&gt;&lt;U+9E21&gt;&lt;U+573A&gt;                                                                                     |
| 2013 | 296   | &lt;U+7518&gt;&lt;U+8083&gt; | &lt;U+751F&gt;&lt;U+732A&gt; | &lt;U+6B66&gt;&lt;U+5A01&gt;&lt;U+548C&gt;&lt;U+519C&gt;&lt;U+7267&gt;&lt;U+4E1A&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                                                                         |
| 2017 | 42    | &lt;U+6CB3&gt;&lt;U+5317&gt; | &lt;U+86CB&gt;&lt;U+9E21&gt; | &lt;U+5927&gt;&lt;U+57CE&gt;&lt;U+53BF&gt;&lt;U+5FB7&gt;&lt;U+6210&gt;&lt;U+517B&gt;&lt;U+6B96&gt;&lt;U+573A&gt;                                                                                                                                                                                                     |
| 2018 | 73    | &lt;U+6E56&gt;&lt;U+5317&gt; | &lt;U+751F&gt;&lt;U+732A&gt; | &lt;U+6E56&gt;&lt;U+5317&gt;&lt;U+5965&gt;&lt;U+767B&gt;&lt;U+519C&gt;&lt;U+7267&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                                             |
| 2015 | 384   | &lt;U+65B0&gt;&lt;U+7586&gt; | &lt;U+8089&gt;&lt;U+7F8A&gt; | &lt;U+963F&gt;&lt;U+52D2&gt;&lt;U+6CF0&gt;&lt;U+5E02&gt;&lt;U+5DF4&gt;&lt;U+91CC&gt;&lt;U+5DF4&gt;&lt;U+76D6&gt;&lt;U+4E61&gt;&lt;U+6208&gt;&lt;U+58C1&gt;&lt;U+5929&gt;&lt;U+7136&gt;&lt;U+517B&gt;&lt;U+6B96&gt;&lt;U+519C&gt;&lt;U+6C11&gt;&lt;U+4E13&gt;&lt;U+4E1A&gt;&lt;U+5408&gt;&lt;U+4F5C&gt;&lt;U+793E&gt; |
| 2017 | 351   | &lt;U+6CB3&gt;&lt;U+5357&gt; | &lt;U+5976&gt;&lt;U+725B&gt; | &lt;U+90D1&gt;&lt;U+5DDE&gt;&lt;U+660C&gt;&lt;U+660E&gt;&lt;U+519C&gt;&lt;U+7267&gt;&lt;U+79D1&gt;&lt;U+6280&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;&lt;U+517B&gt;&lt;U+6B96&gt;&lt;U+573A&gt;                                                                                                   |
| 2016 | 249   | &lt;U+5C71&gt;&lt;U+4E1C&gt; | &lt;U+5976&gt;&lt;U+725B&gt; | &lt;U+73B0&gt;&lt;U+4EE3&gt;&lt;U+7267&gt;&lt;U+4E1A&gt;&lt;U+5546&gt;&lt;U+6CB3&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                                                                         |
| 2013 | 218   | &lt;U+6E56&gt;&lt;U+5357&gt; | &lt;U+751F&gt;&lt;U+732A&gt; | &lt;U+65B0&gt;&lt;U+5316&gt;&lt;U+53BF&gt;&lt;U+4E94&gt;&lt;U+4EBF&gt;&lt;U+519C&gt;&lt;U+7267&gt;&lt;U+53D1&gt;&lt;U+5C55&gt;&lt;U+6709&gt;&lt;U+9650&gt;&lt;U+516C&gt;&lt;U+53F8&gt;                                                                                                                               |
