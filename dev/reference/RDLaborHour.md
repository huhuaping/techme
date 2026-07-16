# RD Personnel Full-time Equivalent by Region

This dataset contains statistics on Research and Development (RD)
personnel full-time equivalent by region, measured in person-years. The
data is extracted from the China Statistical Yearbook on Science and
Technology, covering all provinces and regions in China.

## Usage

``` r
RDLaborHour
```

## Format

A data frame:

- province:

  character. Province name, including national total.

- year:

  integer. Year of the statistics, starting from 2010.

- chn_block4:

  character. Variable name in Chinese.

- value:

  numeric. The statistical value.

- units:

  character. Units of measurement (person-years).

- variables:

  character. Variable name in coded format.

## Source

China Statistical Yearbook on Science and Technology, National Bureau of
Statistics of China

## Details

- The dataset covers RD personnel full-time equivalent statistics by
  region from 2010 to the latest available year.

- Data is in long format for easy analysis and visualization.

- Full-time equivalent is measured in person-years, representing the
  equivalent of one person working full-time for one year.

## Examples

``` r
# View the structure of the dataset
str(RDLaborHour)
#> 'data.frame':    2240 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "全国" ...
#>  $ year      : chr  "2023" "2023" "2023" "2023" ...
#>  $ chn_block4: chr  "合计" "研究人员" "基础研究" "应用研究" ...
#>  $ value     : num  7240582 3001302 575033 776817 5888748 ...
#>  $ units     : chr  "人年" "人年" "人年" "人年" ...
#>  $ variables : chr  "v4_zh_qsdl_hj" "v4_zh_qsdl_yjry" "v4_zh_qsdl_jcyj" "v4_zh_qsdl_yyyj" ...
# Filter data for a specific year
RDLaborHour[RDLaborHour$year == 2020, ]
#>     province year chn_block4   value units       variables
#> 481     全国 2020       合计 5234508  人年   v4_zh_qsdl_hj
#> 482     全国 2020   研究人员 2281134  人年 v4_zh_qsdl_yjry
#> 483     全国 2020   基础研究  426772  人年 v4_zh_qsdl_jcyj
#> 484     全国 2020   应用研究  643130  人年 v4_zh_qsdl_yyyj
#> 485     全国 2020   试验发展 4164620  人年 v4_zh_qsdl_syfz
#> 486     北京 2020       合计  336280  人年   v4_zh_qsdl_hj
#> 487     北京 2020   研究人员  226005  人年 v4_zh_qsdl_yjry
#> 488     北京 2020   基础研究   75082  人年 v4_zh_qsdl_jcyj
#> 489     北京 2020   应用研究   95186  人年 v4_zh_qsdl_yyyj
#> 490     北京 2020   试验发展  166014  人年 v4_zh_qsdl_syfz
#> 491     天津 2020       合计   90640  人年   v4_zh_qsdl_hj
#> 492     天津 2020   研究人员   48371  人年 v4_zh_qsdl_yjry
#> 493     天津 2020   基础研究    9196  人年 v4_zh_qsdl_jcyj
#> 494     天津 2020   应用研究   13676  人年 v4_zh_qsdl_yyyj
#> 495     天津 2020   试验发展   67768  人年 v4_zh_qsdl_syfz
#> 496     河北 2020       合计  125058  人年   v4_zh_qsdl_hj
#> 497     河北 2020   研究人员   55320  人年 v4_zh_qsdl_yjry
#> 498     河北 2020   基础研究    8293  人年 v4_zh_qsdl_jcyj
#> 499     河北 2020   应用研究   19083  人年 v4_zh_qsdl_yyyj
#> 500     河北 2020   试验发展   97682  人年 v4_zh_qsdl_syfz
#> 501     山西 2020       合计   52394  人年   v4_zh_qsdl_hj
#> 502     山西 2020   研究人员   23880  人年 v4_zh_qsdl_yjry
#> 503     山西 2020   基础研究    7667  人年 v4_zh_qsdl_jcyj
#> 504     山西 2020   应用研究   10019  人年 v4_zh_qsdl_yyyj
#> 505     山西 2020   试验发展   34709  人年 v4_zh_qsdl_syfz
#> 506   内蒙古 2020       合计   27914  人年   v4_zh_qsdl_hj
#> 507   内蒙古 2020   研究人员   13789  人年 v4_zh_qsdl_yjry
#> 508   内蒙古 2020   基础研究    2062  人年 v4_zh_qsdl_jcyj
#> 509   内蒙古 2020   应用研究    5143  人年 v4_zh_qsdl_yyyj
#> 510   内蒙古 2020   试验发展   20708  人年 v4_zh_qsdl_syfz
#> 511     辽宁 2020       合计  111931  人年   v4_zh_qsdl_hj
#> 512     辽宁 2020   研究人员   61459  人年 v4_zh_qsdl_yjry
#> 513     辽宁 2020   基础研究   14898  人年 v4_zh_qsdl_jcyj
#> 514     辽宁 2020   应用研究   21097  人年 v4_zh_qsdl_yyyj
#> 515     辽宁 2020   试验发展   75937  人年 v4_zh_qsdl_syfz
#> 516     吉林 2020       合计   44472  人年   v4_zh_qsdl_hj
#> 517     吉林 2020   研究人员   30712  人年 v4_zh_qsdl_yjry
#> 518     吉林 2020   基础研究   15879  人年 v4_zh_qsdl_jcyj
#> 519     吉林 2020   应用研究   13945  人年 v4_zh_qsdl_yyyj
#> 520     吉林 2020   试验发展   14649  人年 v4_zh_qsdl_syfz
#> 521   黑龙江 2020       合计   44205  人年   v4_zh_qsdl_hj
#> 522   黑龙江 2020   研究人员   31834  人年 v4_zh_qsdl_yjry
#> 523   黑龙江 2020   基础研究   12279  人年 v4_zh_qsdl_jcyj
#> 524   黑龙江 2020   应用研究   13843  人年 v4_zh_qsdl_yyyj
#> 525   黑龙江 2020   试验发展   18082  人年 v4_zh_qsdl_syfz
#> 526     上海 2020       合计  228621  人年   v4_zh_qsdl_hj
#> 527     上海 2020   研究人员  128355  人年 v4_zh_qsdl_yjry
#> 528     上海 2020   基础研究   32966  人年 v4_zh_qsdl_jcyj
#> 529     上海 2020   应用研究   34943  人年 v4_zh_qsdl_yyyj
#> 530     上海 2020   试验发展  160715  人年 v4_zh_qsdl_syfz
#> 531     江苏 2020       合计  669084  人年   v4_zh_qsdl_hj
#> 532     江苏 2020   研究人员  262406  人年 v4_zh_qsdl_yjry
#> 533     江苏 2020   基础研究   25979  人年 v4_zh_qsdl_jcyj
#> 534     江苏 2020   应用研究   42112  人年 v4_zh_qsdl_yyyj
#> 535     江苏 2020   试验发展  600994  人年 v4_zh_qsdl_syfz
#> 536     浙江 2020       合计  582981  人年   v4_zh_qsdl_hj
#> 537     浙江 2020   研究人员  172119  人年 v4_zh_qsdl_yjry
#> 538     浙江 2020   基础研究   15839  人年 v4_zh_qsdl_jcyj
#> 539     浙江 2020   应用研究   29465  人年 v4_zh_qsdl_yyyj
#> 540     浙江 2020   试验发展  537679  人年 v4_zh_qsdl_syfz
#> 541     安徽 2020       合计  194688  人年   v4_zh_qsdl_hj
#> 542     安徽 2020   研究人员   84818  人年 v4_zh_qsdl_yjry
#> 543     安徽 2020   基础研究   16411  人年 v4_zh_qsdl_jcyj
#> 544     安徽 2020   应用研究   23578  人年 v4_zh_qsdl_yyyj
#> 545     安徽 2020   试验发展  154698  人年 v4_zh_qsdl_syfz
#> 546     福建 2020       合计  185622  人年   v4_zh_qsdl_hj
#> 547     福建 2020   研究人员   72535  人年 v4_zh_qsdl_yjry
#> 548     福建 2020   基础研究    6613  人年 v4_zh_qsdl_jcyj
#> 549     福建 2020   应用研究   19183  人年 v4_zh_qsdl_yyyj
#> 550     福建 2020   试验发展  159826  人年 v4_zh_qsdl_syfz
#> 551     江西 2020       合计  124326  人年   v4_zh_qsdl_hj
#> 552     江西 2020   研究人员   43360  人年 v4_zh_qsdl_yjry
#> 553     江西 2020   基础研究    6229  人年 v4_zh_qsdl_jcyj
#> 554     江西 2020   应用研究    8716  人年 v4_zh_qsdl_yyyj
#> 555     江西 2020   试验发展  109381  人年 v4_zh_qsdl_syfz
#> 556     山东 2020       合计  341159  人年   v4_zh_qsdl_hj
#> 557     山东 2020   研究人员  141786  人年 v4_zh_qsdl_yjry
#> 558     山东 2020   基础研究   23105  人年 v4_zh_qsdl_jcyj
#> 559     山东 2020   应用研究   34857  人年 v4_zh_qsdl_yyyj
#> 560     山东 2020   试验发展  283197  人年 v4_zh_qsdl_syfz
#> 561     河南 2020       合计  203080  人年   v4_zh_qsdl_hj
#> 562     河南 2020   研究人员   80815  人年 v4_zh_qsdl_yjry
#> 563     河南 2020   基础研究    7488  人年 v4_zh_qsdl_jcyj
#> 564     河南 2020   应用研究   21681  人年 v4_zh_qsdl_yyyj
#> 565     河南 2020   试验发展  173914  人年 v4_zh_qsdl_syfz
#> 566     湖北 2020       合计  192168  人年   v4_zh_qsdl_hj
#> 567     湖北 2020   研究人员   89997  人年 v4_zh_qsdl_yjry
#> 568     湖北 2020   基础研究   13265  人年 v4_zh_qsdl_jcyj
#> 569     湖北 2020   应用研究   27170  人年 v4_zh_qsdl_yyyj
#> 570     湖北 2020   试验发展  151732  人年 v4_zh_qsdl_syfz
#> 571     湖南 2020       合计  177561  人年   v4_zh_qsdl_hj
#> 572     湖南 2020   研究人员   80254  人年 v4_zh_qsdl_yjry
#> 573     湖南 2020   基础研究   13127  人年 v4_zh_qsdl_jcyj
#> 574     湖南 2020   应用研究   24777  人年 v4_zh_qsdl_yyyj
#> 575     湖南 2020   试验发展  139660  人年 v4_zh_qsdl_syfz
#> 576     广东 2020       合计  872238  人年   v4_zh_qsdl_hj
#> 577     广东 2020   研究人员  295901  人年 v4_zh_qsdl_yjry
#> 578     广东 2020   基础研究   38655  人年 v4_zh_qsdl_jcyj
#> 579     广东 2020   应用研究   69225  人年 v4_zh_qsdl_yyyj
#> 580     广东 2020   试验发展  764360  人年 v4_zh_qsdl_syfz
#> 581     广西 2020       合计   45821  人年   v4_zh_qsdl_hj
#> 582     广西 2020   研究人员   25981  人年 v4_zh_qsdl_yjry
#> 583     广西 2020   基础研究    8404  人年 v4_zh_qsdl_jcyj
#> 584     广西 2020   应用研究    9385  人年 v4_zh_qsdl_yyyj
#> 585     广西 2020   试验发展   28031  人年 v4_zh_qsdl_syfz
#> 586     海南 2020       合计    8961  人年   v4_zh_qsdl_hj
#> 587     海南 2020   研究人员    4927  人年 v4_zh_qsdl_yjry
#> 588     海南 2020   基础研究    2077  人年 v4_zh_qsdl_jcyj
#> 589     海南 2020   应用研究    1774  人年 v4_zh_qsdl_yyyj
#> 590     海南 2020   试验发展    5110  人年 v4_zh_qsdl_syfz
#> 591     重庆 2020       合计  105712  人年   v4_zh_qsdl_hj
#> 592     重庆 2020   研究人员   47445  人年 v4_zh_qsdl_yjry
#> 593     重庆 2020   基础研究    7525  人年 v4_zh_qsdl_jcyj
#> 594     重庆 2020   应用研究   17411  人年 v4_zh_qsdl_yyyj
#> 595     重庆 2020   试验发展   80777  人年 v4_zh_qsdl_syfz
#> 596     四川 2020       合计  189829  人年   v4_zh_qsdl_hj
#> 597     四川 2020   研究人员   99173  人年 v4_zh_qsdl_yjry
#> 598     四川 2020   基础研究   16372  人年 v4_zh_qsdl_jcyj
#> 599     四川 2020   应用研究   32414  人年 v4_zh_qsdl_yyyj
#> 600     四川 2020   试验发展  141044  人年 v4_zh_qsdl_syfz
#> 601     贵州 2020       合计   41496  人年   v4_zh_qsdl_hj
#> 602     贵州 2020   研究人员   19198  人年 v4_zh_qsdl_yjry
#> 603     贵州 2020   基础研究    6068  人年 v4_zh_qsdl_jcyj
#> 604     贵州 2020   应用研究    7234  人年 v4_zh_qsdl_yyyj
#> 605     贵州 2020   试验发展   28194  人年 v4_zh_qsdl_syfz
#> 606     云南 2020       合计   60369  人年   v4_zh_qsdl_hj
#> 607     云南 2020   研究人员   29204  人年 v4_zh_qsdl_yjry
#> 608     云南 2020   基础研究   10895  人年 v4_zh_qsdl_jcyj
#> 609     云南 2020   应用研究    9712  人年 v4_zh_qsdl_yyyj
#> 610     云南 2020   试验发展   39762  人年 v4_zh_qsdl_syfz
#> 611     西藏 2020       合计    1579  人年   v4_zh_qsdl_hj
#> 612     西藏 2020   研究人员    1175  人年 v4_zh_qsdl_yjry
#> 613     西藏 2020   基础研究     481  人年 v4_zh_qsdl_jcyj
#> 614     西藏 2020   应用研究     501  人年 v4_zh_qsdl_yyyj
#> 615     西藏 2020   试验发展     597  人年 v4_zh_qsdl_syfz
#> 616     陕西 2020       合计  118807  人年   v4_zh_qsdl_hj
#> 617     陕西 2020   研究人员   74459  人年 v4_zh_qsdl_yjry
#> 618     陕西 2020   基础研究   17664  人年 v4_zh_qsdl_jcyj
#> 619     陕西 2020   应用研究   23573  人年 v4_zh_qsdl_yyyj
#> 620     陕西 2020   试验发展   77571  人年 v4_zh_qsdl_syfz
#> 621     甘肃 2020       合计   26814  人年   v4_zh_qsdl_hj
#> 622     甘肃 2020   研究人员   18533  人年 v4_zh_qsdl_yjry
#> 623     甘肃 2020   基础研究    6652  人年 v4_zh_qsdl_jcyj
#> 624     甘肃 2020   应用研究    7178  人年 v4_zh_qsdl_yyyj
#> 625     甘肃 2020   试验发展   12983  人年 v4_zh_qsdl_syfz
#> 626     青海 2020       合计    4423  人年   v4_zh_qsdl_hj
#> 627     青海 2020   研究人员    2399  人年 v4_zh_qsdl_yjry
#> 628     青海 2020   基础研究     721  人年 v4_zh_qsdl_jcyj
#> 629     青海 2020   应用研究    1069  人年 v4_zh_qsdl_yyyj
#> 630     青海 2020   试验发展    2634  人年 v4_zh_qsdl_syfz
#> 631     宁夏 2020       合计   12169  人年   v4_zh_qsdl_hj
#> 632     宁夏 2020   研究人员    5483  人年 v4_zh_qsdl_yjry
#> 633     宁夏 2020   基础研究    1311  人年 v4_zh_qsdl_jcyj
#> 634     宁夏 2020   应用研究    1450  人年 v4_zh_qsdl_yyyj
#> 635     宁夏 2020   试验发展    9409  人年 v4_zh_qsdl_syfz
#> 636     新疆 2020       合计   14109  人年   v4_zh_qsdl_hj
#> 637     新疆 2020   研究人员    9443  人年 v4_zh_qsdl_yjry
#> 638     新疆 2020   基础研究    3573  人年 v4_zh_qsdl_jcyj
#> 639     新疆 2020   应用研究    3730  人年 v4_zh_qsdl_yyyj
#> 640     新疆 2020   试验发展    6806  人年 v4_zh_qsdl_syfz
```
