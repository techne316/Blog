+++
title = "Data manipulate"
date = "Jan 2, 2006"
description = ""
tags = ["R", "basic"]
categories = ["Basic R"]
author = "Techne316"
+++


# 1. Data import 

dataframe 구조로 된 데이터를 다루는데 필요한 package중에서 제일 많이 사용하는 dplyr에 대해 설명해보려고 합니다. 기본적으로 dataframe을 다룰 수 있는 경우 dplyr과 tidyr 사용하면 더 간편하게 dataframe을 사용할 수 있습니다. 다만, 데이터를 index하거나 이름을 지정하는것, 불러오는 등 기본적인 방법을 다루지는 않고 package의 함수를 다루므로 기초가 없다면 약간 어려울 수도 있습니다.

데이터를 직접 다루는 것이 좋기 때문에, 예시로 공공데이터 포털(https://www.data.go.kr) 에서 2017년 건강검진 정보 데이터를 사용하도록 하겠습니다. 


**건강검진정보(2017)**  
* 등록일 : 2019-05-21  
* URL : https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001524257&fileDetailSn=1&publicDataDetailPk=uddi:af2e59b7-9f3a-4624-94ae-9ac9d785b62b  
* 설명 : 2017년 건강검진 수검자 100만명의 검진내역 및 문진 항목  
* 항목에 대한 설명은 함께 제공되는 hwp파일을 참고


먼저, 저장될 폴더를 지정해주거나 만들어준 이후에 사용할 데이터를 다운받아 unzip을 해줍니다.

```r
# data이 저장될 directory 생성
dir.create("./NHIS_2017")

#data_url이라는 변수에 2017년도 건강검진정보를 다운 받을 수 있는 url 주소를 저장
data_url <- c("https://www.data.go.kr/dataset/fileDownload.do?atchFileId=FILE_000000001524257&fileDetailSn=1&publicDataDetailPk=uddi:af2e59b7-9f3a-4624-94ae-9ac9d785b62b")

# data_url의 데이터가 저장될 파일의 이름 지정 (앞서 생성된 dir의 안에 저장됨)
zipfile <- c("./NHIS_2017/NHIS_OPEN_2017.zip")

# download.file()을 통해 url주소에 있는 data를 dest_dir인 zipfile에 저장
download.file(data_url, destfile = zipfile, mode="wb")
unzip(zipfile, exdir = "./NHIS_2017/") #zip file 풀기
list.files("./NHIS_2017/")
```
여기까지 진행을 했다면, 지정된 directory안에 원본 파일인 "zip"파일과 NHIS_OPEN_GJ_2017.CSV"라는 파일이 unzip되어 존재할 것입니다. (혹시 여기까지 파일을 다운받아서 압축을 푸는 과정이 어렵다면, 일반적으로 파일을 다운받아서 알집을 풀어도 괜찮습니다)

이번엔, 해당 파일을 `data2017`이라는 변수로 지정하여, data를 불러오도록 하겠습니다.
파일을 읽는데, 한글로 된 문자열을 인식하기 어려운 부분이 있어서 열의 이름은 hwp의 개방항목 설명을 토대로 영문으로 새로 지정하여 사용하도록 하겠습니다.

```r
target <- list.files("./NHIS_2017/")[2]; 
#target <- c(C:/Documents/download/NHIS_OPEN_GJ_2017.CSV") /로 folder가 구분되는 path ( \는 안됨)
column_name <- c("HCHK_YEAR", "IDV_ID", "SEX", "AGE_GROUP", "SIDO",
                 "HEIGHT", "WEIGHT", "WAIST", "SIGHT_LEFT", "SIGHT_RIGHT",
                 "HEAR_LEFT", "HEAR_RIGHT", "BP_HIGH", "BP_LWST", "BLDS",
                 "TOT_CHOLE", "TRIGLYCERIDE", "HDL_CHOLE", "LDL_CHOLE","HMG",
                 "OLIG_PROTE_CD", "CREATININE", "SGOT_AST", "SGPT_ALT", "GAMMA_GTP",
                 "SMK_STAT_TYPE_CD", "DRK_YN", "HCHK_OE_INSPEC_YN", "CRS_YN", "TTH_MSS_YN",
                 "ODT_TRN_YN", "WSDM_DIS_YN", "TTR_YN", "DATA_STD_DT")
data2017 <- read.csv(target,skip= 1,header=FALSE, col.names = column_name)
dim(data2017)
```

```
## [1] 1000000      34
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>NHIS_2017 data</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HCHK_YEAR </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> IDV_ID </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SIDO </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SIGHT_LEFT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SIGHT_RIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEAR_LEFT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEAR_RIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HMG </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> OLIG_PROTE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> CREATININE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HCHK_OE_INSPEC_YN </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> CRS_YN </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> TTH_MSS_YN </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> ODT_TRN_YN </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> WSDM_DIS_YN </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TTR_YN </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DATA_STD_DT </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 91.0 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 178 </td>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 15.9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 73.4 </td>
   <td style="text-align:right;"> 1.2 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 255 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 176 </td>
   <td style="text-align:right;"> 10.7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.9 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 94.0 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 0.8 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 211 </td>
   <td style="text-align:right;"> 271 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 16.1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.1 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 136 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 67.5 </td>
   <td style="text-align:right;"> 0.9 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 13.4 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.6 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 1.5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 253 </td>
   <td style="text-align:right;"> 182 </td>
   <td style="text-align:right;"> 47 </td>
   <td style="text-align:right;"> 169 </td>
   <td style="text-align:right;"> 16.1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.1 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 84.8 </td>
   <td style="text-align:right;"> 1.2 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 210 </td>
   <td style="text-align:right;"> 139 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 136 </td>
   <td style="text-align:right;"> 17.1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.9 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 111.5 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 104 </td>
   <td style="text-align:right;"> 257 </td>
   <td style="text-align:right;"> 126 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 174 </td>
   <td style="text-align:right;"> 16.6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 78.0 </td>
   <td style="text-align:right;"> 0.8 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 264 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> 13.9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> NA </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 0.9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 73 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 185 </td>
   <td style="text-align:right;"> 32 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 14.3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 31 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2017 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 86.0 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1.0 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 189 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 123 </td>
   <td style="text-align:right;"> 14.7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0.7 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 46 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;"> 20181126 </td>
  </tr>
</tbody>
</table></div>

`dim(2017)`을 통해 확인해 본 결과, data2017에는 총 1,000,000명의 대상자의 34개의 검진항목 결과가 나와있는 것을 알 수있습니다.

1,000,000의 데이터를 모두 사용하는 경우 연산 처리에 오래 걸리므로, 대상자를 5000명으로 랜덤하게 뽑고 성별, 연령대, 키, 체중, 허리둘레, 혈압, 혈당, 혈액검사 결과, 흡연상태, 음주여부로만 이뤄진 dataset1을 생성하도록 하겠습니다.  


```r
# data2017의 행 갯수에서 random하게 5000 개의 숫자를 출력해서 해당 값을 행으로 출력
index <- sample(1:dim(data2017)[1], 5000)

# 5000명의 대상자로 이뤄진 행과, 성별, 연령대, 키, 체중, 허리둘레, 혈압, 혈당, 혈액검사 결과, 흡연상태, 음주여부의 열으로만 이뤄진 dataset
dataset <-data2017[index,c(3,4,6,7,8,13:19,23:27)] 
rownames(dataset) <- data2017[index,"IDV_ID"]
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>dataset</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 188286 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 284219 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 88.0 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 830328 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 62.0 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 188 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 395427 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 79.0 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 239 </td>
   <td style="text-align:right;"> 282 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 606785 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 76.0 </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 212 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 515834 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 65.0 </td>
   <td style="text-align:right;"> 112 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 161 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 751556 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 72.5 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 673065 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 79.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 238 </td>
   <td style="text-align:right;"> 127 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 153 </td>
   <td style="text-align:right;"> 39 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 780775 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 72.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 97 </td>
   <td style="text-align:right;"> 231 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 154 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 280055 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 71.0 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 218 </td>
   <td style="text-align:right;"> 200 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table></div>

\

각 변수에 대한 설명은 데이터와 함께 제공되는 "국민건강정보데이터 건강검진정보 사용자 메뉴얼_20171027.hwp"에 제공된 데이터 설명을 참고하였습니다

> **성별코드(SEX)** : 남자(1), 여자(2)  
**연령대코드(AGE_GROUP)** : 20~84세까지 5세 단위로, 85세 이상은 하나의 단위로 그룹화   
**신장(HEIGHT)** : 검진자의 키는 5cm단위로 내림 (100~404cm -> 100cm, N/cm).  
**체중(WEIGHT)** : 검진자의 몸무게 5kg단위로 내림(25~29kg->25kg).  
**허리둘레(WAIST)** : 검진자의 허리둘레(N/cm).  
**수축기혈압(BP_HIGH)** : 검진자의 최고혈압으로 심장이 수축해서 강한 힘으로 혈액을 동맥에 보낼 떄의 혈관 내압(N/mmHg).  
**이완기혈압(BP_LWST)** : 검진자의 최저 혈압으로 심장의 완기시의 혈압(N/mmHg).  
**식전혈당.공복혈당(BLDS)** : 검진자 식사 전 혈당(N/mg/dL).    
**총콜레스테롤(TOT_CHOLE)** : 혈청중의 콜레스테롤의 합(N/mg/dL 정상치 150-250mg/dL).  
**트리글리세라이드(TRIGLYCERIDE)** : 단순지질, 중성지질(N/mg/dL 정상치 30-135/dL).  
**HDL콜레스테롤(HDL_CHOLE)** : HDL에 포함되는 콜레스테롤(N/mg/dL 정상치 30-65/dL).   
**LDL콜레스테롤(LDL_CHOLE)** : LDL에 함유된 콜레스테롤(N/mg/dL, 170mg/dL이상인 경우 고LDL혈증).  
**혈청지오티.AST(SGOT_AST)** : 간 기능을 나타내는 혈액검사상의 수치, 간세포 이외에 심장, 신장, 뇌, 근육 등에도 존재하는 효소로 이러한 세포들이 손상을 받는 경우 농도가 증가함 (N/mg/dL, 정상치 0~40 IU/L).  
**혈청지오티.ALT(SGPT_ALT)** : 간 기능을 나타내는 혈액검사상의 수치, ALT는 주로 간세포 안에 존재하는 효소로 간세포들이 손상을 받는 경우 농도가 증가함 (N/IU/L, 정상치 0~40 IU/L).  
**감마지티피(GAMMA_GTP)** : 간 기능을 나타내는 혈액검사상의 수치, 간 내의 쓸개관에 존재하는 효소로 글루타민산을 외부에 펩티드나 아미노산 등으로 옮기는 작용을 함, 쓸개즙 배설장애, 간세포 장애 발생 시 혈중에 증가하게 됨 (N/IU/L, 정상치 남성 11~63IU/L, 여성 8~35IU/L).  
**흡연상태(SMK_STAT_TYPE_CD)** : 해당수검자의 흡연상태 여부, 피우지 않는다(0), 이전에 피웠으나 끊었다(2), 현재 피우고 있다(3).  
**음주여부(DRK_YN)** : 해당수검자의 음주상태 여부, 마시지 않는다(0), 마신다(1).  

\
dataset의 특징을 다시 살펴보자면, 
데이터는 총 5000개의 샘플데이터를 가지고 있으며, 17개의 항목에 대한 값으로 구성되어 있고,
아래와 같은 형식으로 구성되어 있음을 대략적으로 알 수 있습니다.

```r
str(dataset) #data2017  column별 데이터 형태
```

```
## 'data.frame':	5000 obs. of  17 variables:
##  $ SEX             : int  1 1 2 2 2 2 1 2 2 2 ...
##  $ AGE_GROUP       : int  15 12 7 15 12 9 6 13 12 11 ...
##  $ HEIGHT          : int  170 170 160 150 160 150 165 150 160 155 ...
##  $ WEIGHT          : int  60 70 45 50 60 40 50 50 50 50 ...
##  $ WAIST           : num  83 88 62 79 76 65 72.5 79 72 71 ...
##  $ BP_HIGH         : int  122 125 100 130 113 112 102 122 120 98 ...
##  $ BP_LWST         : int  70 77 70 80 69 80 60 80 70 74 ...
##  $ BLDS            : int  110 107 82 98 71 75 94 98 97 87 ...
##  $ TOT_CHOLE       : int  128 202 188 239 212 161 151 238 231 218 ...
##  $ TRIGLYCERIDE    : int  67 207 49 282 58 76 61 127 53 200 ...
##  $ HDL_CHOLE       : int  52 37 60 61 60 52 49 60 66 68 ...
##  $ LDL_CHOLE       : int  63 124 118 121 140 93 89 153 154 110 ...
##  $ SGOT_AST        : int  25 25 19 42 21 23 21 39 23 25 ...
##  $ SGPT_ALT        : int  29 28 16 35 12 16 11 25 15 16 ...
##  $ GAMMA_GTP       : int  13 59 20 66 10 11 37 10 10 16 ...
##  $ SMK_STAT_TYPE_CD: int  2 3 3 1 1 1 3 1 1 1 ...
##  $ DRK_YN          : int  0 1 1 0 0 0 1 0 0 1 ...
```
\

이렇게 생성된 dataset을 이용하여 가장 많이 사용되는 dplyr, tidyr package를 통해 dataframe을 다루는 방법을 설명해보도록 하겠습니다.

------------------------

# 2. dplyr, tidyr package 
먼저 `dplyr`과 `tidyr`을 library를 통해 로딩해주도록 하겠습니다. 만약, 처음 package를 사용하시는 분이시라면, `install.packages(c("dplyr", "tidyr"), repos = "http://cran.us.r-project.org")`를 통해 먼저 설치를 해준 이후에 `library()`를 통해 로딩하시면 됩니다.


```r
library(dplyr)
library(tidyr)
```

먼저, %>% 연산자는 dplyr에 있는 함수로서 활용도가 매우 많으므로 본격적인 data다루기에 앞서 설명하려고 합니다. \

**[참고] %>%  연산자 (chain)**\

%>% 연산자는 간단하게 연산을 연속해서 적용할 때 사용할 수 있는 연산자입니다. 

R에서 함수를 사용하기 위해서는 `colnames()`과 같이 기본적으로 왼쪽에 함수를 사용하고 데이터를 넣게 되어 있습니다. 따라서 두 개 이상의 함수를 연속해서 사용하고 싶은 경우에는 함수가 왼쪽에 위치해야 하므로 커서를 다시 왼쪽으로 위치하여 함수를 사용해줘야 합니다(`head(colnames())`). 따라서, 연산이 복잡해 질 수록 명령어가 왼쪽으로 붙게 되어 이를 직관적으로 이해하기 어려워집니다.

dplyr에서는 이를 해결하는 방법을 chain 연산자인 %>% 을 이용해서 연산을 일렬로 풀어낼 수 있습니다. 

%>% 연산자에 익숙해지면 연속적인 연산을 할 때에 커서의 위치를 왼쪽이 아닌, 오른쪽에 두고 연속적으로 명령어를 이어나갈 수 있기 때문에 이해하기도 쉽습니다. 앞서 설명한 `head(colnames())`의 경우 체인 연산자를 사용하면 `colnames() %>% head()`로 풀어쓸 수 있습니다. 


```r
head(colnames(dataset))
colnames(dataset) %>% head()
```

----

# 3. Data manipulate
데이터를 다루는 기본적인 명령어는 R에서 기본적으로 제공하는 index나 연산의 개념을 활용해도 충분히 데이터를 다룰 수 있지만, dplyr이나 tidyr의 함수를 사용하면 더 간편하게 사용할 수 있습니다. 따라서 기본적인 개념에 대한 이해 없이 패키지에 포함된 함수를 바로 설명하면 어려움이 있을 수 있으므로 간단한 개념들에 대해서는 기본 함수를 이용해 먼저 설명하고, 이를 간편하게 만들어 주는 dplyr이나 tidyr의 함수를 설명해보도록 하겠습니다.

### 3.1 Filter()
데이터를 다루는 데 있어서 가장 많이 사용되는 연산으로는 filter를 통해서 관심있는 데이터에 해당하는 값들만 출력해주는 것입니다.
예로 들어, 남자로만 이뤄진 dataset을 만들고 싶다거나 (SEX = 1), 술을 마시는 사람들로만 이뤄진 dataset(DRK_YN = 1) 을 만들어주고 싶을 때, 혹은 앞선 두가지의 조건에 모두 부합하는 술을 마시는 남자(SEX = 1 & DRK_YN =1) 로만 이뤄지는 dataset을 만들고 싶을 때 사용할 수 있습니다.


먼저, 남자로만 이뤄진 dataframe을 만들어보려고 합니다. 기준이 되는 `dataset$SEX`를 살펴볼 때 남자는 1, 여자는 2로 이뤄진 범주형 데이터로 구성이 되어 있습니다. 따라서 남자인 데이터를 받기 위해서는`dataset$SEX`에서 1로 구성된 데이터만 불러와야 하므로 `datset$SEX ==1`이라는 연산을 이용하여 가져오도록 하겠습니다.


```r
SEX <- dataset$SEX == 1
M_dataset <- dataset[SEX,]
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>dataset$SEX = 1</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">   </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 188286 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 284219 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 88.0 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 751556 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 72.5 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 407980 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 80.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 443840 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 82.0 </td>
   <td style="text-align:right;"> 180 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 186 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 18 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 864640 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 86129 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 88.0 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 159 </td>
   <td style="text-align:right;"> 265 </td>
   <td style="text-align:right;"> 36 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 38 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 487045 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 85.0 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 201 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 214031 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 72.0 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 582182 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 81.0 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table></div>


\

이번엔 술을 마시는 대상자만으로 구성된 dataset (DRK_YN = 1)을 기본적인 연산자를 이용하여 `dataset[dataset$DRK_YN ==1,]`으로 구할 수도 있지만,  dplyr의 `filter()`를 이용해보려고 합니다. 명령어는 `filter(data, filter할 연산)`으로 구성되기 때문에 DRK_YN= 1로 필터링한 데이터는 `filter(dataset, DRK_YN == 1)`을 통해서 구할 수 있습니다. 


```r
# filter를 통해서 가져오는 방법1
DRK_dataset2 <- filter(dataset, DRK_YN == 1)

# filter와 %>%을 통해서 가져오는 방법
DRK_dataset3 <- dataset %>% filter(DRK_YN==1)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>DRK_YN = 1</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 88.0 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 62.0 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 188 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 72.5 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 71.0 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 74 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 218 </td>
   <td style="text-align:right;"> 200 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 80.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 64.0 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 84 </td>
   <td style="text-align:right;"> 149 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 85.0 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 201 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 78.0 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 99 </td>
   <td style="text-align:right;"> 220 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 81.0 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
</tbody>
</table></div>


\
다음은 좀 더 복잡하게 앞서서 설명한 술을 마시는 남성인 대상자만으로 구성된 dataset을 구성해보고자 합니다.
먼저 남성 (SEX =1)과 술을 마시는 대상자(DRK_YN=1)는 and연산자인 & 으로 묶어서 해당하는 값만을 구하면 됩니다.


```r
# manual한 방법
M.DRK_dataset1 <- dataset[dataset$SEX ==1 & dataset$DRK_YN ==1,] 

# fiter1
M.DRK_dataset2 <- filter(dataset, SEX==1 & DRK_YN ==1)

# filter2, 그 전과 같이 and 연산자를 사용하는 방법
M.DRK_dataset3 <- dataset %>% filter(SEX==1 & DRK_YN ==1)

# filter3, pipe연산자를 사용해서 표현하는 방법
M.DRK_dataset4 <- dataset %>% filter(SEX ==1) %>% filter(DRK_YN ==1)
```


<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>SEX =1 그리고 DRK_YN =1</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 88.0 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 6 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 72.5 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 151 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 16 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 80.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 14 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 156 </td>
   <td style="text-align:right;"> 33 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 85.0 </td>
   <td style="text-align:right;"> 143 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 201 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 109 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 81 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 6 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 81.0 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 208 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 108 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 23 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 14 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 79.0 </td>
   <td style="text-align:right;"> 119 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 142 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 43 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 44 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 12 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 95 </td>
   <td style="text-align:right;"> 99.0 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 358 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 27 </td>
   <td style="text-align:right;"> 24 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 10 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 93.2 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 294 </td>
   <td style="text-align:right;"> 226 </td>
   <td style="text-align:right;"> 51 </td>
   <td style="text-align:right;"> 197 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 11 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:right;"> 107.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 91 </td>
   <td style="text-align:right;"> 256 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> 22 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 41 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 1 </td>
  </tr>
</tbody>
</table></div>


\
### 3.3 mutate()
Data를 다루다보면 새로 열을 추가해서 dataframe을 만들어야 하는 경우가 있습니다. 예로 들어, 대상자의 키와 몸무게를 알고 있다면 이를 이용하여 BMI라는 새로운 열을 추가할 수도 있습니다. 이를 수행하기 위해서 R에서 제공하는 기본함수를 사용하여 `BMI`라는 새로운 변수를 만들어 `cbind()`로 간단하게 data.frame의 마지막에 연결할 수도 있습니다. 하지만, `dplyr::mutate()`를 사용하면 조금 더 쉽고 가ㄴ편하게 이를 수행 할 수 있습니다.


```r
BMI <- dataset$WEIGHT / ((dataset$HEIGHT*0.01)^2)
BMI_dataset1 <- cbind(dataset, BMI)
```

위의 수식과 동일한 계산을 `muatate()`로 수행해보도록 하겠습니다. dplyr의 파이프연산자를 이용하거나 첫번째 자리에 사용할 데이의 이름을 넣어준 후, 새로 추가할 열의 이름(`BMI`)을 지정한 후에, 데이터안에 열의 이름을 이용하여 수식을 정해주면 됩니다.


```r
BMI_dataset2 <- mutate(dataset, BMI = WEIGHT/((HEIGHT*0.01)^2))
BMI_dataset3 <- dataset %>% mutate(BMI = WEIGHT/((HEIGHT*0.01)^2))
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>새로 추가된 BMI</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BMI </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 83 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 67 </td>
   <td style="text-align:right;"> 52 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 29 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 20.76125 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:right;"> 125 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 202 </td>
   <td style="text-align:right;"> 207 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:right;"> 124 </td>
   <td style="text-align:right;"> 25 </td>
   <td style="text-align:right;"> 28 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 24.22145 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 82 </td>
   <td style="text-align:right;"> 188 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 118 </td>
   <td style="text-align:right;"> 19 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 17.57812 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 50 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:right;"> 239 </td>
   <td style="text-align:right;"> 282 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> 42 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 66 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 22.22222 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 113 </td>
   <td style="text-align:right;"> 69 </td>
   <td style="text-align:right;"> 71 </td>
   <td style="text-align:right;"> 212 </td>
   <td style="text-align:right;"> 58 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 140 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 23.43750 </td>
  </tr>
</tbody>
</table></div>

\
### 3.4 arrange()
`arrange()`는 특정 데이터를 기준으로 해서 데이터 행의 순서를 변경하고 싶을 때 매우 유용한 방법입니다.예로 들어, 앞에서 계산한 BMI를 이용하여, BMI 지수가 높은 순으로 전체 dataset의 순서를 변경하고 싶을 때에 사용할 수 있습니다.

이는 R의 기본 함수들인`order()`를 이용하여 계산해 낼 수도 있고, `dplyr::arrange()`을 이용하여 나타낼 수도 있습니다.

```r
BMI_dataset3.1 <- BMI_dataset3[order(BMI_dataset3$BMI),]
BMI_dataset3.2 <- BMI_dataset3 %>% arrange(BMI)
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:3in; overflow-x: scroll; width:9in; "><table class="table table-striped" style="width: auto !important; ">
<caption>새로 추가된 BMI</caption>
 <thead>
  <tr>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SEX </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> AGE_GROUP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WEIGHT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> WAIST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_HIGH </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BP_LWST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BLDS </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TOT_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> TRIGLYCERIDE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> HDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> LDL_CHOLE </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGOT_AST </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SGPT_ALT </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> GAMMA_GTP </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> SMK_STAT_TYPE_CD </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> DRK_YN </th>
   <th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;"> BMI </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 61.5 </td>
   <td style="text-align:right;"> 103 </td>
   <td style="text-align:right;"> 64 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:right;"> 164 </td>
   <td style="text-align:right;"> 76 </td>
   <td style="text-align:right;"> 59 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:right;"> 21 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 13.33333 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 160 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 61.0 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 222 </td>
   <td style="text-align:right;"> 53 </td>
   <td style="text-align:right;"> 106 </td>
   <td style="text-align:right;"> 105 </td>
   <td style="text-align:right;"> 34 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 11 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 13.67188 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 17 </td>
   <td style="text-align:right;"> 145 </td>
   <td style="text-align:right;"> 30 </td>
   <td style="text-align:right;"> 62.0 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 100 </td>
   <td style="text-align:right;"> 96 </td>
   <td style="text-align:right;"> 137 </td>
   <td style="text-align:right;"> 121 </td>
   <td style="text-align:right;"> 49 </td>
   <td style="text-align:right;"> 63 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 14.26873 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 35 </td>
   <td style="text-align:right;"> 56.0 </td>
   <td style="text-align:right;"> 120 </td>
   <td style="text-align:right;"> 72 </td>
   <td style="text-align:right;"> 94 </td>
   <td style="text-align:right;"> 174 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 93 </td>
   <td style="text-align:right;"> 15 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 14 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 14.56816 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 165 </td>
   <td style="text-align:right;"> 40 </td>
   <td style="text-align:right;"> 66.2 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 60 </td>
   <td style="text-align:right;"> 77 </td>
   <td style="text-align:right;"> 186 </td>
   <td style="text-align:right;"> 68 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 107 </td>
   <td style="text-align:right;"> 20 </td>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 16 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:right;font-weight: bold;color: white !important;background-color: #AFAFAF !important;"> 14.69238 </td>
  </tr>
</tbody>
</table></div>

\
### 3.5 slice()
`slice()`는 필요한 행만큼을 출력해주는 함수로서, `slice(데이터 프레임, 1:5)`를 이용하여 1:5까지의 행을 출력할 수 있습니다. 


```r
dataset %>% slice(1:5)
```

```
##   SEX AGE_GROUP HEIGHT WEIGHT WAIST BP_HIGH BP_LWST BLDS TOT_CHOLE
## 1   1        15    170     60    83     122      70  110       128
## 2   1        12    170     70    88     125      77  107       202
## 3   2         7    160     45    62     100      70   82       188
## 4   2        15    150     50    79     130      80   98       239
## 5   2        12    160     60    76     113      69   71       212
##   TRIGLYCERIDE HDL_CHOLE LDL_CHOLE SGOT_AST SGPT_ALT GAMMA_GTP
## 1           67        52        63       25       29        13
## 2          207        37       124       25       28        59
## 3           49        60       118       19       16        20
## 4          282        61       121       42       35        66
## 5           58        60       140       21       12        10
##   SMK_STAT_TYPE_CD DRK_YN
## 1                2      0
## 2                3      1
## 3                3      1
## 4                1      0
## 5                1      0
```

이는 dataset[1:5,]와 동일하지만 %>%를 이용하여 연산을 진행 할 수 있다는 점에서 장점을 가지고 있습니다. 가령 앞서 설명한 `mutate()`, `arrange()`, `slice()`를 모두 사용하여 BMI라는 열을 만들어 이를 기준으로 해서 BMI가 낮은 1~5등까지의 데이터를 알고 싶다면 아래와 같이 연속해서 사용해주면 됩니다. 아래와 같은 연속연산자를 사용한 경우에는 `[ ]`를 사용할 수 없으므로 이런 경우에 `slice()`를 사용하는 것이 좀 더 편리합니다.


```r
dataset %>% mutate(BMI = WEIGHT/((HEIGHT*0.01)^2)) %>%
  arrange(BMI) %>% slice(1:5)
```

```
##   SEX AGE_GROUP HEIGHT WEIGHT WAIST BP_HIGH BP_LWST BLDS TOT_CHOLE
## 1   2         6    150     30  61.5     103      64   87       164
## 2   2         9    160     35  61.0     100      79   93       222
## 3   2        17    145     30  62.0     130     100   96       137
## 4   2         7    155     35  56.0     120      72   94       174
## 5   2         9    165     40  66.2     110      60   77       186
##   TRIGLYCERIDE HDL_CHOLE LDL_CHOLE SGOT_AST SGPT_ALT GAMMA_GTP
## 1           76        59        89       21       13        15
## 2           53       106       105       34       15        11
## 3          121        49        63       14        8        16
## 4           65        68        93       15       14        14
## 5           68        65       107       20        9        16
##   SMK_STAT_TYPE_CD DRK_YN      BMI
## 1                1      1 13.33333
## 2                1      0 13.67187
## 3                1      0 14.26873
## 4                1      0 14.56816
## 5                1      0 14.69238
```
 
### 3.6 gather( )
R에서 시각화를 할때 가장 많이 사용되는 ggplot인 경우 long format 형태를 input으로 받아 값을 출력합니다. 기존에 가지고 있는 dataset은 5000*21로 long format을 이해하는데 너무 복잡하므로 이를 간단하게 5명의 대상자로, SEX, AGE_GROUP으로만 이뤄진 데이터로 다시 나누어서 표현해보겠습니다.



추후 분석에 용이할 수 있도록 선별해서 data를 가져오려고 하는데 AGE_GROUP이 11인 대상자 3명 (일련번호가 78072, 167817, 189299)과, 5 (20-24세)에 해당하는 대상자 2명 (일련번호가 898517, 593105)을 추출해서 dataset2로 가져오도록 하겠습니다.

따라서 아래와 같이 일련식별번호가 78072, 167817, 189299, 898517, 593105 의 ID를 가진 대상자 5명의 성별과 나이를 포함한 `dataset2 (5\*2)`가 생성되었습니다. 

<table class="table table-striped" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:right;"> SEX </th>
   <th style="text-align:right;"> AGE_GROUP </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 78072 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 167817 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 189299 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 898517 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 593105 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>
\

위의 5\*2 구조의 데이터에서 성별(SEX), 나이(AGE_GROUP)에 해당하는 열을 행으로 바꾼 10\*1 구조의 길게 나열된 데이터형태(long format)는 아래와 같습니다.
<table class="table table-striped" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> idx </th>
   <th style="text-align:left;"> key </th>
   <th style="text-align:right;"> value </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 78072 </td>
   <td style="text-align:left;"> SEX </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 167817 </td>
   <td style="text-align:left;"> SEX </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 189299 </td>
   <td style="text-align:left;"> SEX </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 898517 </td>
   <td style="text-align:left;"> SEX </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 593105 </td>
   <td style="text-align:left;"> SEX </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 78072 </td>
   <td style="text-align:left;"> AGE_GROUP </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 167817 </td>
   <td style="text-align:left;"> AGE_GROUP </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 189299 </td>
   <td style="text-align:left;"> AGE_GROUP </td>
   <td style="text-align:right;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 898517 </td>
   <td style="text-align:left;"> AGE_GROUP </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 593105 </td>
   <td style="text-align:left;"> AGE_GROUP </td>
   <td style="text-align:right;"> 5 </td>
  </tr>
</tbody>
</table>

위의 데이터와 같이 long format으로 변환해주기 위해 사용하는 것이 `gather()` 입니다. 
`gather(data, key, value, list)`함수는 아래와 같은 argument로 구성됩니다.\

* data : 사용할 original data  
* key : original data의 column 값들이 row로 들어갈 때 새로 생성될 열의 명칭  
* value : original data의 column이 row로 들어갈 때, 열로 들어 갈 값  
* list : 변환될 list  


따라서 위와 같은 longdata format을 만들기 위해서는 dataset2를 이용하고, SEX:AGE_GROUP을 key라는 열로 모으고 value라는 열에 그 값을 저장할 예정이므로, `gather(dataset2, key, value, SEX:AGE_GROUP)` 와 같은 명령어를 사용하면 됩니다.

```r
gather(dataset2, key, value, SEX:AGE_GROUP)
```

```
##          key value
## 1        SEX     2
## 2        SEX     1
## 3        SEX     2
## 4        SEX     2
## 5        SEX     1
## 6  AGE_GROUP    11
## 7  AGE_GROUP    11
## 8  AGE_GROUP    11
## 9  AGE_GROUP     5
## 10 AGE_GROUP     5
```

하지만, 이 경우에는 기존의 dataset2에서 존재하던 index가 사라짐으로 이를 고려해서 rowname이 포함된 열 (idx)을 포함하여 dataframe을 하나 만들어주고, 그 이후에 gather함수를 이용하여 만들어주면 됩니다.


```r
dataset3 <- cbind(idx = rownames(dataset2), dataset2)
gather(dataset3, key, value, SEX:AGE_GROUP)
```

```
##       idx       key value
## 1   78072       SEX     2
## 2  167817       SEX     1
## 3  189299       SEX     2
## 4  898517       SEX     2
## 5  593105       SEX     1
## 6   78072 AGE_GROUP    11
## 7  167817 AGE_GROUP    11
## 8  189299 AGE_GROUP    11
## 9  898517 AGE_GROUP     5
## 10 593105 AGE_GROUP     5
```