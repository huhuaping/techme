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
#> 'data.frame':    2685 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "北京" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "篇数SCI" "篇数EI" "篇数cpcis" "篇数SCI" ...
#>  $ value     : num  684510 457214 27544 90278 64388 ...
#>  $ units     : chr  "篇" "篇" "篇" "篇" ...
#>  $ variables : chr  "v4_cg_gwlw_pssci" "v4_cg_gwlw_psei" "v4_cg_gwlw_pscpcis" "v4_cg_gwlw_pssci" ...
# Filter data for SCI papers in 2022
RDPaperInternational[RDPaperInternational$year == "2022" & 
                     grepl("SCI", RDPaperInternational$chn_block4), ]
#>     province year chn_block4  value units        variables
#> 190     全国 2022    篇数SCI 681884    篇 v4_cg_gwlw_pssci
#> 191     北京 2022    篇数SCI  91634    篇 v4_cg_gwlw_pssci
#> 192     天津 2022    篇数SCI  18464    篇 v4_cg_gwlw_pssci
#> 193     河北 2022    篇数SCI  10947    篇 v4_cg_gwlw_pssci
#> 194     山西 2022    篇数SCI   7658    篇 v4_cg_gwlw_pssci
#> 195   内蒙古 2022    篇数SCI   3154    篇 v4_cg_gwlw_pssci
#> 196     辽宁 2022    篇数SCI  23751    篇 v4_cg_gwlw_pssci
#> 197     吉林 2022    篇数SCI  13616    篇 v4_cg_gwlw_pssci
#> 198   黑龙江 2022    篇数SCI  16560    篇 v4_cg_gwlw_pssci
#> 199     上海 2022    篇数SCI  49638    篇 v4_cg_gwlw_pssci
#> 200     江苏 2022    篇数SCI  68814    篇 v4_cg_gwlw_pssci
#> 201     浙江 2022    篇数SCI  37966    篇 v4_cg_gwlw_pssci
#> 202     安徽 2022    篇数SCI  18791    篇 v4_cg_gwlw_pssci
#> 203     福建 2022    篇数SCI  14738    篇 v4_cg_gwlw_pssci
#> 204     江西 2022    篇数SCI   9332    篇 v4_cg_gwlw_pssci
#> 205     山东 2022    篇数SCI  38056    篇 v4_cg_gwlw_pssci
#> 206     河南 2022    篇数SCI  19857    篇 v4_cg_gwlw_pssci
#> 207     湖北 2022    篇数SCI  36174    篇 v4_cg_gwlw_pssci
#> 208     湖南 2022    篇数SCI  25056    篇 v4_cg_gwlw_pssci
#> 209     广东 2022    篇数SCI  51413    篇 v4_cg_gwlw_pssci
#> 210     广西 2022    篇数SCI   8238    篇 v4_cg_gwlw_pssci
#> 211     海南 2022    篇数SCI   3066    篇 v4_cg_gwlw_pssci
#> 212     重庆 2022    篇数SCI  15637    篇 v4_cg_gwlw_pssci
#> 213     四川 2022    篇数SCI  32952    篇 v4_cg_gwlw_pssci
#> 214     贵州 2022    篇数SCI   5713    篇 v4_cg_gwlw_pssci
#> 215     云南 2022    篇数SCI   7849    篇 v4_cg_gwlw_pssci
#> 216     西藏 2022    篇数SCI    188    篇 v4_cg_gwlw_pssci
#> 217     陕西 2022    篇数SCI  36135    篇 v4_cg_gwlw_pssci
#> 218     甘肃 2022    篇数SCI   9349    篇 v4_cg_gwlw_pssci
#> 219     青海 2022    篇数SCI   1023    篇 v4_cg_gwlw_pssci
#> 220     宁夏 2022    篇数SCI   1619    篇 v4_cg_gwlw_pssci
#> 221     新疆 2022    篇数SCI   4496    篇 v4_cg_gwlw_pssci
#> 286     全国 2022    位次SCI     NA    位 v4_cg_gwlw_wcsci
#> 287     北京 2022    位次SCI      1    位 v4_cg_gwlw_wcsci
#> 288     天津 2022    位次SCI     14    位 v4_cg_gwlw_wcsci
#> 289     河北 2022    位次SCI     19    位 v4_cg_gwlw_wcsci
#> 290     山西 2022    位次SCI     24    位 v4_cg_gwlw_wcsci
#> 291   内蒙古 2022    位次SCI     27    位 v4_cg_gwlw_wcsci
#> 292     辽宁 2022    位次SCI     11    位 v4_cg_gwlw_wcsci
#> 293     吉林 2022    位次SCI     18    位 v4_cg_gwlw_wcsci
#> 294   黑龙江 2022    位次SCI     15    位 v4_cg_gwlw_wcsci
#> 295     上海 2022    位次SCI      4    位 v4_cg_gwlw_wcsci
#> 296     江苏 2022    位次SCI      2    位 v4_cg_gwlw_wcsci
#> 297     浙江 2022    位次SCI      6    位 v4_cg_gwlw_wcsci
#> 298     安徽 2022    位次SCI     13    位 v4_cg_gwlw_wcsci
#> 299     福建 2022    位次SCI     17    位 v4_cg_gwlw_wcsci
#> 300     江西 2022    位次SCI     21    位 v4_cg_gwlw_wcsci
#> 301     山东 2022    位次SCI      5    位 v4_cg_gwlw_wcsci
#> 302     河南 2022    位次SCI     12    位 v4_cg_gwlw_wcsci
#> 303     湖北 2022    位次SCI      7    位 v4_cg_gwlw_wcsci
#> 304     湖南 2022    位次SCI     10    位 v4_cg_gwlw_wcsci
#> 305     广东 2022    位次SCI      3    位 v4_cg_gwlw_wcsci
#> 306     广西 2022    位次SCI     22    位 v4_cg_gwlw_wcsci
#> 307     海南 2022    位次SCI     28    位 v4_cg_gwlw_wcsci
#> 308     重庆 2022    位次SCI     16    位 v4_cg_gwlw_wcsci
#> 309     四川 2022    位次SCI      9    位 v4_cg_gwlw_wcsci
#> 310     贵州 2022    位次SCI     25    位 v4_cg_gwlw_wcsci
#> 311     云南 2022    位次SCI     23    位 v4_cg_gwlw_wcsci
#> 312     西藏 2022    位次SCI     31    位 v4_cg_gwlw_wcsci
#> 313     陕西 2022    位次SCI      8    位 v4_cg_gwlw_wcsci
#> 314     甘肃 2022    位次SCI     20    位 v4_cg_gwlw_wcsci
#> 315     青海 2022    位次SCI     30    位 v4_cg_gwlw_wcsci
#> 316     宁夏 2022    位次SCI     29    位 v4_cg_gwlw_wcsci
#> 317     新疆 2022    位次SCI     26    位 v4_cg_gwlw_wcsci
```
