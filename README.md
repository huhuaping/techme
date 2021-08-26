
<!-- README.md is generated from README.Rmd. Please edit that file -->

# techme

<!-- badges: start -->
<!-- badges: end -->

The goal of techme is to supply basic data sets and toolsets to generate
research report.

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
#> 载入需要的程辑包：techme
data("varsList")
head(varsList)
#>        variables   chn_full_name short_chn short_eng  units block1 block2
#> 1  v1_sc_bzmj_dd   播种面积_大豆      <NA>      <NA> 千公顷     v1     sc
#> 2  v1_sc_bzmj_dg   播种面积_稻谷      <NA>      <NA> 千公顷     v1     sc
#> 3  v1_sc_bzmj_dl   播种面积_豆类      <NA>      <NA> 千公顷     v1     sc
#> 4  v1_sc_bzmj_dm   播种面积_大麦      <NA>      <NA> 千公顷     v1     sc
#> 5 v1_sc_bzmj_ggl 播种面积_瓜果类      <NA>      <NA> 千公顷     v1     sc
#> 6  v1_sc_bzmj_gl   播种面积_高粱      <NA>      <NA> 千公顷     v1     sc
#>   block3 block4 chn_block1 chn_block2 chn_block3 chn_block4
#> 1   bzmj     dd       农业       生产   播种面积       大豆
#> 2   bzmj     dg       农业       生产   播种面积       稻谷
#> 3   bzmj     dl       农业       生产   播种面积       豆类
#> 4   bzmj     dm       农业       生产   播种面积       大麦
#> 5   bzmj    ggl       农业       生产   播种面积     瓜果类
#> 6   bzmj     gl       农业       生产   播种面积       高粱
#>                    chn_full    flag source
#> 1   农业;生产;播种面积;大豆 v2018.6   <NA>
#> 2   农业;生产;播种面积;稻谷 v2018.6   <NA>
#> 3   农业;生产;播种面积;豆类 v2018.6   <NA>
#> 4   农业;生产;播种面积;大麦 v2018.6   <NA>
#> 5 农业;生产;播种面积;瓜果类 v2018.6   <NA>
#> 6   农业;生产;播种面积;高粱 v2018.6   <NA>
```

## Data set list and source

### Basic

**`varsList`**：A data set containing all variables and additional
information, such as unit, chn\_name, eng\_name etc., with wide data
format.

-   Totally 16 columns including: variables, chn\_full\_name,
    short\_chn, short\_eng, units, block1, block2, block3, block4,
    chn\_block1, chn\_block2, chn\_block3, chn\_block4, chn\_full, flag,
    source。

-   Totally 586 rows。

**`BasicProvince`**：A data set containing basic information of province
and its region, with wide data format.

-   Totally 3 columns including: id, province, region\_pro。

-   Totally 32 rows。

**`ProvinceCity`**：A data set containing Province and City of china.

-   Totally 6 columns including: index, province, city, id,
    province\_clean, city\_clean。

-   Totally 342 rows。

**`queryTianyan`**：A data set containing basic info of institution
enrolled in officer administrator.

-   Totally 9 columns including: index, name\_origin, name\_search,
    address, tel, url, province, city, province\_raw。

-   Totally 441 rows。

### Yearbook

#### Data from Rural Yearbook

**`AgriMachine`**：A **long format** data set containing Agricultural
Machine statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 4384 rows。

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyjx\_dztlj,
    v7\_sctj\_nyjx\_dztlj\_pt, v7\_sctj\_nyjx\_jbmj,
    v7\_sctj\_nyjx\_jdtlj, v7\_sctj\_nyjx\_jgmj, v7\_sctj\_nyjx\_jsgg,
    v7\_sctj\_nyjx\_jsmj, v7\_sctj\_nyjx\_lhshj, v7\_sctj\_nyjx\_nysb,
    v7\_sctj\_nyjx\_pgcyj, v7\_sctj\_nyjx\_pgddj, v7\_sctj\_nyjx\_xtlj,
    v7\_sctj\_nyjx\_xtlj\_pt, v7\_sctj\_nyjx\_zdl

**`AgriFertilizer`**：A **long format** data set containing Agricultural
Fertilizer statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 448 rows。

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nyhf\_df, v7\_sctj\_nyhf\_fhf,
    v7\_sctj\_nyhf\_hj, v7\_sctj\_nyhf\_jf, v7\_sctj\_nyhf\_lf

**`AgriPlastic`**：A **long format** data set containing Agricultural
Plastic statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 960 rows。

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_nybm\_bmsy, v7\_sctj\_nybm\_dmfg,
    v7\_sctj\_nybm\_dmsy

**`AgriPesticide`**：A **long format** data set containing Agricultural
Pesticide statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 352 rows。

-   Years range from 2010 to 2019

-   Variables including: v7\_sctj\_cyny\_cysy, v7\_sctj\_cyny\_nysy

#### Data from Sci-Tech Yearbook

**`RDIntense`**：A **long format** data set containing R&D Intense
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 576 rows。

-   Years range from 2011 to 2019

-   Variables including: v4\_ztr\_jf\_RD, v4\_ztr\_qd\_RD

**`RDActivity`**：A **long format** data set containing R&D Activity
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 1280 rows。

-   Years range from 2010 to 2019

-   Variables including: v4\_zh\_nbzc\_hj, v4\_zh\_nbzc\_jcyj,
    v4\_zh\_nbzc\_syfz, v4\_zh\_nbzc\_yyyj

**`IndustryOperation`**：A **long format** data set containing Industry
Operation statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 384 rows。

-   Years range from 2015 to 2019

-   Variables including: v4\_cy\_scjy\_lrze, v4\_cy\_scjy\_qys,
    v4\_cy\_scjy\_zyyw

**`IndustryRD`**：A **long format** data set containing Industry R&D
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 2176 rows。

-   Years range from 2016 to 2019

-   Variables including: v4\_cy\_cytz\_gdzc, v4\_cy\_cytz\_jcxm,
    v4\_cy\_cytz\_kgxm, v4\_cy\_cytz\_sgxm, v4\_cy\_cytz\_tzze,
    v4\_cy\_jsgz\_gmzc, v4\_cy\_jsgz\_gzzc, v4\_cy\_jsgz\_xszc,
    v4\_cy\_jsgz\_yjzc, v4\_cy\_qyzl\_fms, v4\_cy\_qyzl\_sqs,
    v4\_cy\_qyzl\_yxs, v4\_cy\_RDhd\_nbzc, v4\_cy\_RDhd\_qsdl,
    v4\_cy\_RDhd\_xmjf, v4\_cy\_RDhd\_xmsl, v4\_cy\_RDhd\_yfjgs,
    v4\_cy\_xcp\_ck, v4\_cy\_xcp\_kfjf, v4\_cy\_xcp\_kfxm,
    v4\_cy\_xcp\_xssr

**`IndustryTrade`**：A **long format** data set containing Industry
Trade statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 288 rows。

-   Years range from 2016 to 2018

-   Variables including: v4\_cy\_my\_ck, v4\_cy\_my\_jck, v4\_cy\_my\_jk

**`MarketPull`**：A **long format** data set containing Tech Market Pull
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 704 rows。

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssr\_ht, v4\_cg\_jssr\_je

**`MarketPush`**：A **long format** data set containing Tech Market Push
statistics .

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 704 rows。

-   Years range from 2000 to 2019

-   Variables including: v4\_cg\_jssc\_ht, v4\_cg\_jssc\_je

#### Data from China National Yearbook

**`PublicBudget`**：A **long format** data set containing Public Budget
statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 1244 rows。

-   Years range from 2010 to 2019

-   Variables including: v6\_cz\_yszc\_hj, v6\_cz\_yszc\_jy,
    v6\_cz\_yszc\_kxjs, v6\_cz\_yszc\_nls

#### Data from Livestock Yearbook

**`LivestockBreeding`**：A **long format** data set containing Livestock
Breeding statistics.

-   Totally 6 columns including: province, year, chn\_block4, value,
    units, variables。

-   Totally 20672 rows。

-   Years range from 2011 to 2017

-   Variables including: v8\_t1\_zcqc\_zhnc, v8\_t1\_zcqc\_zmc,
    v8\_t1\_zcqc\_zmsyc, v8\_t1\_zcqc\_zmyc, v8\_t1\_zcqc\_znc,
    v8\_t1\_zcqc\_znnc1, v8\_t1\_zcqc\_znnc2, v8\_t1\_zcqc\_zrnc,
    v8\_t1\_zcqc\_zs, v8\_t1\_zcqc\_zsnc, v8\_t1\_zcqc\_zsyc,
    v8\_t1\_zcqc\_zxmyc, v8\_t1\_zcqc\_zyc, v8\_t1\_zcqc\_zzc,
    v8\_t2\_zcqc\_fmddjc, v8\_t2\_zcqc\_fmdrjc, v8\_t2\_zcqc\_qt,
    v8\_t2\_zcqc\_zdjc, v8\_t2\_zcqc\_zdjysdjc,
    v8\_t2\_zcqc\_zdjysrjc（top 20 of totally 98 variables）

### Public site

#### Data from MOST

Several data set sources from Ministry of Sci-Tech (MOST).

**`PubNKRDP`**：A **wide format** data set containing Details of
National Key R&D Plans(NKRDP) statistics.

-   Totally 17 columns including: year, date, NO, index, title,
    institution, chairman, funds, type, duration, NO\_head, NO\_year,
    NO\_mark, NO\_num, NO\_num\_p1, NO\_num\_p2, NO\_tail。

-   Totally 2579 rows。

-   Years range from 2018 to 2020

**`PubAgriParkList`**：A **wide format** data set containing Details of
Approved List of National Agricultural Sci-tech Park.

-   Totally 4 columns including: index, batch, name, province。

-   Totally 233 rows。

-   Years (Batch) range from 01 to 09

**`PubAgriParkEval`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Park.

-   Totally 5 columns including: year, index, name, result, province。

-   Totally 162 rows。

-   Years range from 2019 to 2020

#### Data from MOA or MOE

Several data set sources from Ministry of Agriculture (MOA) or Ministry
of Education (MOE).

**`PubObsStation`**：A **wide format** data set containing Details of
Evaluation result of National Agricultural Sci-tech Details list of
Observe Stations of MOA and MOE.

-   Totally 6 columns including: officer, year, index, name,
    institution, province。

-   Totally 158 rows。

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
    province\_func, province\_researcher。

-   Totally 1691 rows。

-   Years range from 2011 to 2021
