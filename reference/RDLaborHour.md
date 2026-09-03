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
#> 'data.frame':    2400 obs. of  6 variables:
#>  $ province  : chr  "全国" "全国" "全国" "全国" ...
#>  $ year      : chr  "2024" "2024" "2024" "2024" ...
#>  $ chn_block4: chr  "合计" "研究人员" "基础研究" "应用研究" ...
#>  $ value     : num  7568818 3179806 596971 892483 6079377 ...
#>  $ units     : chr  "人年" "人年" "人年" "人年" ...
#>  $ variables : chr  "v4_zh_qsdl_hj" "v4_zh_qsdl_yjry" "v4_zh_qsdl_jcyj" "v4_zh_qsdl_yyyj" ...
# Filter data for a specific year
RDLaborHour[RDLaborHour$year == 2020, ]
#>     province year chn_block4   value units       variables
#> 641     全国 2020       合计 5234508  人年   v4_zh_qsdl_hj
#> 642     全国 2020   研究人员 2281134  人年 v4_zh_qsdl_yjry
#> 643     全国 2020   基础研究  426772  人年 v4_zh_qsdl_jcyj
#> 644     全国 2020   应用研究  643130  人年 v4_zh_qsdl_yyyj
#> 645     全国 2020   试验发展 4164620  人年 v4_zh_qsdl_syfz
#> 646     北京 2020       合计  336280  人年   v4_zh_qsdl_hj
#> 647     北京 2020   研究人员  226005  人年 v4_zh_qsdl_yjry
#> 648     北京 2020   基础研究   75082  人年 v4_zh_qsdl_jcyj
#> 649     北京 2020   应用研究   95186  人年 v4_zh_qsdl_yyyj
#> 650     北京 2020   试验发展  166014  人年 v4_zh_qsdl_syfz
#> 651     天津 2020       合计   90640  人年   v4_zh_qsdl_hj
#> 652     天津 2020   研究人员   48371  人年 v4_zh_qsdl_yjry
#> 653     天津 2020   基础研究    9196  人年 v4_zh_qsdl_jcyj
#> 654     天津 2020   应用研究   13676  人年 v4_zh_qsdl_yyyj
#> 655     天津 2020   试验发展   67768  人年 v4_zh_qsdl_syfz
#> 656     河北 2020       合计  125058  人年   v4_zh_qsdl_hj
#> 657     河北 2020   研究人员   55320  人年 v4_zh_qsdl_yjry
#> 658     河北 2020   基础研究    8293  人年 v4_zh_qsdl_jcyj
#> 659     河北 2020   应用研究   19083  人年 v4_zh_qsdl_yyyj
#> 660     河北 2020   试验发展   97682  人年 v4_zh_qsdl_syfz
#> 661     山西 2020       合计   52394  人年   v4_zh_qsdl_hj
#> 662     山西 2020   研究人员   23880  人年 v4_zh_qsdl_yjry
#> 663     山西 2020   基础研究    7667  人年 v4_zh_qsdl_jcyj
#> 664     山西 2020   应用研究   10019  人年 v4_zh_qsdl_yyyj
#> 665     山西 2020   试验发展   34709  人年 v4_zh_qsdl_syfz
#> 666   内蒙古 2020       合计   27914  人年   v4_zh_qsdl_hj
#> 667   内蒙古 2020   研究人员   13789  人年 v4_zh_qsdl_yjry
#> 668   内蒙古 2020   基础研究    2062  人年 v4_zh_qsdl_jcyj
#> 669   内蒙古 2020   应用研究    5143  人年 v4_zh_qsdl_yyyj
#> 670   内蒙古 2020   试验发展   20708  人年 v4_zh_qsdl_syfz
#> 671     辽宁 2020       合计  111931  人年   v4_zh_qsdl_hj
#> 672     辽宁 2020   研究人员   61459  人年 v4_zh_qsdl_yjry
#> 673     辽宁 2020   基础研究   14898  人年 v4_zh_qsdl_jcyj
#> 674     辽宁 2020   应用研究   21097  人年 v4_zh_qsdl_yyyj
#> 675     辽宁 2020   试验发展   75937  人年 v4_zh_qsdl_syfz
#> 676     吉林 2020       合计   44472  人年   v4_zh_qsdl_hj
#> 677     吉林 2020   研究人员   30712  人年 v4_zh_qsdl_yjry
#> 678     吉林 2020   基础研究   15879  人年 v4_zh_qsdl_jcyj
#> 679     吉林 2020   应用研究   13945  人年 v4_zh_qsdl_yyyj
#> 680     吉林 2020   试验发展   14649  人年 v4_zh_qsdl_syfz
#> 681   黑龙江 2020       合计   44205  人年   v4_zh_qsdl_hj
#> 682   黑龙江 2020   研究人员   31834  人年 v4_zh_qsdl_yjry
#> 683   黑龙江 2020   基础研究   12279  人年 v4_zh_qsdl_jcyj
#> 684   黑龙江 2020   应用研究   13843  人年 v4_zh_qsdl_yyyj
#> 685   黑龙江 2020   试验发展   18082  人年 v4_zh_qsdl_syfz
#> 686     上海 2020       合计  228621  人年   v4_zh_qsdl_hj
#> 687     上海 2020   研究人员  128355  人年 v4_zh_qsdl_yjry
#> 688     上海 2020   基础研究   32966  人年 v4_zh_qsdl_jcyj
#> 689     上海 2020   应用研究   34943  人年 v4_zh_qsdl_yyyj
#> 690     上海 2020   试验发展  160715  人年 v4_zh_qsdl_syfz
#> 691     江苏 2020       合计  669084  人年   v4_zh_qsdl_hj
#> 692     江苏 2020   研究人员  262406  人年 v4_zh_qsdl_yjry
#> 693     江苏 2020   基础研究   25979  人年 v4_zh_qsdl_jcyj
#> 694     江苏 2020   应用研究   42112  人年 v4_zh_qsdl_yyyj
#> 695     江苏 2020   试验发展  600994  人年 v4_zh_qsdl_syfz
#> 696     浙江 2020       合计  582981  人年   v4_zh_qsdl_hj
#> 697     浙江 2020   研究人员  172119  人年 v4_zh_qsdl_yjry
#> 698     浙江 2020   基础研究   15839  人年 v4_zh_qsdl_jcyj
#> 699     浙江 2020   应用研究   29465  人年 v4_zh_qsdl_yyyj
#> 700     浙江 2020   试验发展  537679  人年 v4_zh_qsdl_syfz
#> 701     安徽 2020       合计  194688  人年   v4_zh_qsdl_hj
#> 702     安徽 2020   研究人员   84818  人年 v4_zh_qsdl_yjry
#> 703     安徽 2020   基础研究   16411  人年 v4_zh_qsdl_jcyj
#> 704     安徽 2020   应用研究   23578  人年 v4_zh_qsdl_yyyj
#> 705     安徽 2020   试验发展  154698  人年 v4_zh_qsdl_syfz
#> 706     福建 2020       合计  185622  人年   v4_zh_qsdl_hj
#> 707     福建 2020   研究人员   72535  人年 v4_zh_qsdl_yjry
#> 708     福建 2020   基础研究    6613  人年 v4_zh_qsdl_jcyj
#> 709     福建 2020   应用研究   19183  人年 v4_zh_qsdl_yyyj
#> 710     福建 2020   试验发展  159826  人年 v4_zh_qsdl_syfz
#> 711     江西 2020       合计  124326  人年   v4_zh_qsdl_hj
#> 712     江西 2020   研究人员   43360  人年 v4_zh_qsdl_yjry
#> 713     江西 2020   基础研究    6229  人年 v4_zh_qsdl_jcyj
#> 714     江西 2020   应用研究    8716  人年 v4_zh_qsdl_yyyj
#> 715     江西 2020   试验发展  109381  人年 v4_zh_qsdl_syfz
#> 716     山东 2020       合计  341159  人年   v4_zh_qsdl_hj
#> 717     山东 2020   研究人员  141786  人年 v4_zh_qsdl_yjry
#> 718     山东 2020   基础研究   23105  人年 v4_zh_qsdl_jcyj
#> 719     山东 2020   应用研究   34857  人年 v4_zh_qsdl_yyyj
#> 720     山东 2020   试验发展  283197  人年 v4_zh_qsdl_syfz
#> 721     河南 2020       合计  203080  人年   v4_zh_qsdl_hj
#> 722     河南 2020   研究人员   80815  人年 v4_zh_qsdl_yjry
#> 723     河南 2020   基础研究    7488  人年 v4_zh_qsdl_jcyj
#> 724     河南 2020   应用研究   21681  人年 v4_zh_qsdl_yyyj
#> 725     河南 2020   试验发展  173914  人年 v4_zh_qsdl_syfz
#> 726     湖北 2020       合计  192168  人年   v4_zh_qsdl_hj
#> 727     湖北 2020   研究人员   89997  人年 v4_zh_qsdl_yjry
#> 728     湖北 2020   基础研究   13265  人年 v4_zh_qsdl_jcyj
#> 729     湖北 2020   应用研究   27170  人年 v4_zh_qsdl_yyyj
#> 730     湖北 2020   试验发展  151732  人年 v4_zh_qsdl_syfz
#> 731     湖南 2020       合计  177561  人年   v4_zh_qsdl_hj
#> 732     湖南 2020   研究人员   80254  人年 v4_zh_qsdl_yjry
#> 733     湖南 2020   基础研究   13127  人年 v4_zh_qsdl_jcyj
#> 734     湖南 2020   应用研究   24777  人年 v4_zh_qsdl_yyyj
#> 735     湖南 2020   试验发展  139660  人年 v4_zh_qsdl_syfz
#> 736     广东 2020       合计  872238  人年   v4_zh_qsdl_hj
#> 737     广东 2020   研究人员  295901  人年 v4_zh_qsdl_yjry
#> 738     广东 2020   基础研究   38655  人年 v4_zh_qsdl_jcyj
#> 739     广东 2020   应用研究   69225  人年 v4_zh_qsdl_yyyj
#> 740     广东 2020   试验发展  764360  人年 v4_zh_qsdl_syfz
#> 741     广西 2020       合计   45821  人年   v4_zh_qsdl_hj
#> 742     广西 2020   研究人员   25981  人年 v4_zh_qsdl_yjry
#> 743     广西 2020   基础研究    8404  人年 v4_zh_qsdl_jcyj
#> 744     广西 2020   应用研究    9385  人年 v4_zh_qsdl_yyyj
#> 745     广西 2020   试验发展   28031  人年 v4_zh_qsdl_syfz
#> 746     海南 2020       合计    8961  人年   v4_zh_qsdl_hj
#> 747     海南 2020   研究人员    4927  人年 v4_zh_qsdl_yjry
#> 748     海南 2020   基础研究    2077  人年 v4_zh_qsdl_jcyj
#> 749     海南 2020   应用研究    1774  人年 v4_zh_qsdl_yyyj
#> 750     海南 2020   试验发展    5110  人年 v4_zh_qsdl_syfz
#> 751     重庆 2020       合计  105712  人年   v4_zh_qsdl_hj
#> 752     重庆 2020   研究人员   47445  人年 v4_zh_qsdl_yjry
#> 753     重庆 2020   基础研究    7525  人年 v4_zh_qsdl_jcyj
#> 754     重庆 2020   应用研究   17411  人年 v4_zh_qsdl_yyyj
#> 755     重庆 2020   试验发展   80777  人年 v4_zh_qsdl_syfz
#> 756     四川 2020       合计  189829  人年   v4_zh_qsdl_hj
#> 757     四川 2020   研究人员   99173  人年 v4_zh_qsdl_yjry
#> 758     四川 2020   基础研究   16372  人年 v4_zh_qsdl_jcyj
#> 759     四川 2020   应用研究   32414  人年 v4_zh_qsdl_yyyj
#> 760     四川 2020   试验发展  141044  人年 v4_zh_qsdl_syfz
#> 761     贵州 2020       合计   41496  人年   v4_zh_qsdl_hj
#> 762     贵州 2020   研究人员   19198  人年 v4_zh_qsdl_yjry
#> 763     贵州 2020   基础研究    6068  人年 v4_zh_qsdl_jcyj
#> 764     贵州 2020   应用研究    7234  人年 v4_zh_qsdl_yyyj
#> 765     贵州 2020   试验发展   28194  人年 v4_zh_qsdl_syfz
#> 766     云南 2020       合计   60369  人年   v4_zh_qsdl_hj
#> 767     云南 2020   研究人员   29204  人年 v4_zh_qsdl_yjry
#> 768     云南 2020   基础研究   10895  人年 v4_zh_qsdl_jcyj
#> 769     云南 2020   应用研究    9712  人年 v4_zh_qsdl_yyyj
#> 770     云南 2020   试验发展   39762  人年 v4_zh_qsdl_syfz
#> 771     西藏 2020       合计    1579  人年   v4_zh_qsdl_hj
#> 772     西藏 2020   研究人员    1175  人年 v4_zh_qsdl_yjry
#> 773     西藏 2020   基础研究     481  人年 v4_zh_qsdl_jcyj
#> 774     西藏 2020   应用研究     501  人年 v4_zh_qsdl_yyyj
#> 775     西藏 2020   试验发展     597  人年 v4_zh_qsdl_syfz
#> 776     陕西 2020       合计  118807  人年   v4_zh_qsdl_hj
#> 777     陕西 2020   研究人员   74459  人年 v4_zh_qsdl_yjry
#> 778     陕西 2020   基础研究   17664  人年 v4_zh_qsdl_jcyj
#> 779     陕西 2020   应用研究   23573  人年 v4_zh_qsdl_yyyj
#> 780     陕西 2020   试验发展   77571  人年 v4_zh_qsdl_syfz
#> 781     甘肃 2020       合计   26814  人年   v4_zh_qsdl_hj
#> 782     甘肃 2020   研究人员   18533  人年 v4_zh_qsdl_yjry
#> 783     甘肃 2020   基础研究    6652  人年 v4_zh_qsdl_jcyj
#> 784     甘肃 2020   应用研究    7178  人年 v4_zh_qsdl_yyyj
#> 785     甘肃 2020   试验发展   12983  人年 v4_zh_qsdl_syfz
#> 786     青海 2020       合计    4423  人年   v4_zh_qsdl_hj
#> 787     青海 2020   研究人员    2399  人年 v4_zh_qsdl_yjry
#> 788     青海 2020   基础研究     721  人年 v4_zh_qsdl_jcyj
#> 789     青海 2020   应用研究    1069  人年 v4_zh_qsdl_yyyj
#> 790     青海 2020   试验发展    2634  人年 v4_zh_qsdl_syfz
#> 791     宁夏 2020       合计   12169  人年   v4_zh_qsdl_hj
#> 792     宁夏 2020   研究人员    5483  人年 v4_zh_qsdl_yjry
#> 793     宁夏 2020   基础研究    1311  人年 v4_zh_qsdl_jcyj
#> 794     宁夏 2020   应用研究    1450  人年 v4_zh_qsdl_yyyj
#> 795     宁夏 2020   试验发展    9409  人年 v4_zh_qsdl_syfz
#> 796     新疆 2020       合计   14109  人年   v4_zh_qsdl_hj
#> 797     新疆 2020   研究人员    9443  人年 v4_zh_qsdl_yjry
#> 798     新疆 2020   基础研究    3573  人年 v4_zh_qsdl_jcyj
#> 799     新疆 2020   应用研究    3730  人年 v4_zh_qsdl_yyyj
#> 800     新疆 2020   试验发展    6806  人年 v4_zh_qsdl_syfz
```
