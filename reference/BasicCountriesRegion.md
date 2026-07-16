# Data Set of Countries and Regions

A data set containing ISO-3166 countries coding and UNSD m49 standard，
which include both useful informations such as 'country_name_full_eng',
'country_name_full_chn','country_code_iso_d3', and 'country_name_alias'.
It is a long format dataset.

## Usage

``` r
BasicCountriesRegion
```

## Format

A data frame:

- name:

  full country name (eng)

- alpha2:

  shortname of country with only 2 Letters

- alpha3:

  shortname of country with only 3 Letters

- countryCode:

  country code in iso-3166 with digits 3

- iso3166_2:

  iso3166_2 engcoding

- region:

  region (eng)

- subRegion:

  sub Region (eng)

- intermediateRegion:

  intermediate Region (eng)

- regionCode:

  region Code

- subRegionCode:

  sub Region Code

- intermediateRegionCode:

  intermediate Region Code

- region_name:

  region name (chn)

- sub_region_name:

  subregion name (chn)

- intermediate_region_name:

  intermediate Region name (chn)

- country_or_area:

  country or area name (full chn)

- countries:

  country or area name (alias chn)

- iso_alpha2_code:

  shortname of country with only 2 Letters

- iso_alpha3_code:

  shortname of country with only 3 Letters

- least_developed_countries_ldc:

  indicator variable, least developed countries(LDCs)

- land_locked_developing_countries_lldc:

  indicator variable, land-locked developing countries LLDCs

- small_island_developing_states_sids:

  indicator variable, small island developing states(SIDs)

- developed_developing_countries:

  indicator variable, developed or developing countries

## Source

<https://www.huhuaping.com/>
