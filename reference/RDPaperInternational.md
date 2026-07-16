# International Scientific Papers by Region

This dataset contains statistics on Chinese scientific papers indexed by
major international databases (such as SCI) by region. The data is
extracted from the China Statistical Yearbook on Science and Technology,
covering all provinces and regions in China.

## Usage

``` r
RDPaperInternational
```

## Format

A data frame:

- province:

  character. Province name, including national total.

- year:

  character. Year of the statistics.

- chn_block4:

  character. Type of international index in Chinese (e.g., "SCI
  Papers").

- value:

  numeric. Number of papers indexed.

- units:

  character. Units of measurement (papers/articles).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers Chinese scientific papers indexed by major
  international databases by region from 2010 to the latest available
  year.

- Main international databases include SCI (Science Citation Index) and
  other major indexing tools.

- Data is in long format for easy analysis and visualization.

- Values represent the number of papers indexed by international
  databases.

## Examples

``` r
# View the structure of the dataset
str(RDPaperInternational)
#> 'data.frame':    2496 obs. of  6 variables:
#>  $ province  : chr  "全国" "北京" "天津" "河北" ...
#>  $ year      : chr  "2022" "2022" "2022" "2022" ...
#>  $ chn_block4: chr  "篇数SCI" "篇数SCI" "篇数SCI" "篇数SCI" ...
#>  $ value     : num  681884 91634 18464 10947 7658 ...
#>  $ units     : chr  "篇" "篇" "篇" "篇" ...
#>  $ variables : chr  "v4_cg_gwlw_pssci" "v4_cg_gwlw_pssci" "v4_cg_gwlw_pssci" "v4_cg_gwlw_pssci" ...
# Filter data for SCI papers in 2022
RDPaperInternational[RDPaperInternational$year == "2022" & 
                     grepl("SCI", RDPaperInternational$chn_block4), ]
#>     province year chn_block4  value units        variables
#> 1       全国 2022    篇数SCI 681884    篇 v4_cg_gwlw_pssci
#> 2       北京 2022    篇数SCI  91634    篇 v4_cg_gwlw_pssci
#> 3       天津 2022    篇数SCI  18464    篇 v4_cg_gwlw_pssci
#> 4       河北 2022    篇数SCI  10947    篇 v4_cg_gwlw_pssci
#> 5       山西 2022    篇数SCI   7658    篇 v4_cg_gwlw_pssci
#> 6     内蒙古 2022    篇数SCI   3154    篇 v4_cg_gwlw_pssci
#> 7       辽宁 2022    篇数SCI  23751    篇 v4_cg_gwlw_pssci
#> 8       吉林 2022    篇数SCI  13616    篇 v4_cg_gwlw_pssci
#> 9     黑龙江 2022    篇数SCI  16560    篇 v4_cg_gwlw_pssci
#> 10      上海 2022    篇数SCI  49638    篇 v4_cg_gwlw_pssci
#> 11      江苏 2022    篇数SCI  68814    篇 v4_cg_gwlw_pssci
#> 12      浙江 2022    篇数SCI  37966    篇 v4_cg_gwlw_pssci
#> 13      安徽 2022    篇数SCI  18791    篇 v4_cg_gwlw_pssci
#> 14      福建 2022    篇数SCI  14738    篇 v4_cg_gwlw_pssci
#> 15      江西 2022    篇数SCI   9332    篇 v4_cg_gwlw_pssci
#> 16      山东 2022    篇数SCI  38056    篇 v4_cg_gwlw_pssci
#> 17      河南 2022    篇数SCI  19857    篇 v4_cg_gwlw_pssci
#> 18      湖北 2022    篇数SCI  36174    篇 v4_cg_gwlw_pssci
#> 19      湖南 2022    篇数SCI  25056    篇 v4_cg_gwlw_pssci
#> 20      广东 2022    篇数SCI  51413    篇 v4_cg_gwlw_pssci
#> 21      广西 2022    篇数SCI   8238    篇 v4_cg_gwlw_pssci
#> 22      海南 2022    篇数SCI   3066    篇 v4_cg_gwlw_pssci
#> 23      重庆 2022    篇数SCI  15637    篇 v4_cg_gwlw_pssci
#> 24      四川 2022    篇数SCI  32952    篇 v4_cg_gwlw_pssci
#> 25      贵州 2022    篇数SCI   5713    篇 v4_cg_gwlw_pssci
#> 26      云南 2022    篇数SCI   7849    篇 v4_cg_gwlw_pssci
#> 27      西藏 2022    篇数SCI    188    篇 v4_cg_gwlw_pssci
#> 28      陕西 2022    篇数SCI  36135    篇 v4_cg_gwlw_pssci
#> 29      甘肃 2022    篇数SCI   9349    篇 v4_cg_gwlw_pssci
#> 30      青海 2022    篇数SCI   1023    篇 v4_cg_gwlw_pssci
#> 31      宁夏 2022    篇数SCI   1619    篇 v4_cg_gwlw_pssci
#> 32      新疆 2022    篇数SCI   4496    篇 v4_cg_gwlw_pssci
#> 97      全国 2022    位次SCI     NA    位 v4_cg_gwlw_wcsci
#> 98      北京 2022    位次SCI      1    位 v4_cg_gwlw_wcsci
#> 99      天津 2022    位次SCI     14    位 v4_cg_gwlw_wcsci
#> 100     河北 2022    位次SCI     19    位 v4_cg_gwlw_wcsci
#> 101     山西 2022    位次SCI     24    位 v4_cg_gwlw_wcsci
#> 102   内蒙古 2022    位次SCI     27    位 v4_cg_gwlw_wcsci
#> 103     辽宁 2022    位次SCI     11    位 v4_cg_gwlw_wcsci
#> 104     吉林 2022    位次SCI     18    位 v4_cg_gwlw_wcsci
#> 105   黑龙江 2022    位次SCI     15    位 v4_cg_gwlw_wcsci
#> 106     上海 2022    位次SCI      4    位 v4_cg_gwlw_wcsci
#> 107     江苏 2022    位次SCI      2    位 v4_cg_gwlw_wcsci
#> 108     浙江 2022    位次SCI      6    位 v4_cg_gwlw_wcsci
#> 109     安徽 2022    位次SCI     13    位 v4_cg_gwlw_wcsci
#> 110     福建 2022    位次SCI     17    位 v4_cg_gwlw_wcsci
#> 111     江西 2022    位次SCI     21    位 v4_cg_gwlw_wcsci
#> 112     山东 2022    位次SCI      5    位 v4_cg_gwlw_wcsci
#> 113     河南 2022    位次SCI     12    位 v4_cg_gwlw_wcsci
#> 114     湖北 2022    位次SCI      7    位 v4_cg_gwlw_wcsci
#> 115     湖南 2022    位次SCI     10    位 v4_cg_gwlw_wcsci
#> 116     广东 2022    位次SCI      3    位 v4_cg_gwlw_wcsci
#> 117     广西 2022    位次SCI     22    位 v4_cg_gwlw_wcsci
#> 118     海南 2022    位次SCI     28    位 v4_cg_gwlw_wcsci
#> 119     重庆 2022    位次SCI     16    位 v4_cg_gwlw_wcsci
#> 120     四川 2022    位次SCI      9    位 v4_cg_gwlw_wcsci
#> 121     贵州 2022    位次SCI     25    位 v4_cg_gwlw_wcsci
#> 122     云南 2022    位次SCI     23    位 v4_cg_gwlw_wcsci
#> 123     西藏 2022    位次SCI     31    位 v4_cg_gwlw_wcsci
#> 124     陕西 2022    位次SCI      8    位 v4_cg_gwlw_wcsci
#> 125     甘肃 2022    位次SCI     20    位 v4_cg_gwlw_wcsci
#> 126     青海 2022    位次SCI     30    位 v4_cg_gwlw_wcsci
#> 127     宁夏 2022    位次SCI     29    位 v4_cg_gwlw_wcsci
#> 128     新疆 2022    位次SCI     26    位 v4_cg_gwlw_wcsci
```
