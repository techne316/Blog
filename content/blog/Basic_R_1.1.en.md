+++
title = "Data type"
description = ""
tags = ["R", "basic"]
categories = ["Basic R"]
author = "Techne316"
image = "img/blog/john-mark-arnold-WItJTJsW97w-unsplash1.jpg"

+++

# 1. 데이터의 기본적인 성질와 구조

## 1.1 데이터의 성질
일반적인 데이터의 성질은 크게 연속형(continuous)과 범주형(categorical) 데이터로 분류 할 수 있습니다. 이러한 데이터의 성질에 따라 앞으로 사용할 수 있는 통계의 분석방법, 혹은 시각화 할 때 사용할 수 있는 plot의 종류가 제한적일 수 있으므로 이를 유의하여 사용하는 것이 좋습니다. R에서 가장 기본적으로 데이터를 인식할때 수치형(numeric), 문자형(character), 논리형(logical) 여러 형식(mode)이 존재합니다.

* 수치형(numeric)이란 수의 형태로서 숫자를 다루는 데이터형식

* 문자형(character)이란 문자 그대로 "Mary", "James", "Red" 와 같이 문자를 받아드리는 형태로서 string을 인식하는 데이터 형식

* 논리형(logical)이란 TRUE/FALSE로서 간단하게는 논리적으로 참인지 거짓인지를 저장하는 데이터 형식

이러한 데이터의 형식은 R에서 새로운 데이터를 loading 할때 해당 데이터를 어떠한 형식(mode)으로 인식할지에 대한 문제입니다. 일반적으로 데이터를 불러올때 해당하는 데이터의 열에 형식은 자동으로 적절한 형식으로 불러오고 있지만, 데이터에 따라서 형식을 새로 지정해줘야 하는 경우도 있습니다. 이에 대해서는 데이터 불러오기를 다룰때 더 자세하게 다루도록 하겠습니다.

여기서는 공공데이터포털(https://www.data.go.kr)에서 제공하는 건강검진정보를 참고하여 각 데이터의 성질을 알아보고자 합니다. 건강검진 정보에는 많은 정보가 있지만 그 중에서 간단하게 대상자의 성별, 나이, 키, 허리둘레, 혈압, 음주여부에 해당하는 내용만을 살펴보고자 합니다. 
<table class="table table-striped" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> X </th>
   <th style="text-align:right;"> SEX </th>
   <th style="text-align:right;"> AGE_GROUP </th>
   <th style="text-align:right;"> HEIGHT </th>
   <th style="text-align:right;"> WEIGHT </th>
   <th style="text-align:right;"> WAIST </th>
   <th style="text-align:right;"> BP_HIGH </th>
   <th style="text-align:right;"> SMK_STAT_TYPE_CD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 91.0 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 73.4 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 94.0 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 67.5 </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 84.8 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 111.5 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 78.0 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 86.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>
\
\

------
  
### 1) 연속형 데이터 Continuous 
\
연속형 데이터는 연속된 숫자들로 이뤄져있어 수량화가 가능한 데이터 형태입니다. 예시로 든 데이터에서는 키, 체중,허리둘레와 같이 각 값의 평균값이나 분산 등으로 계산이 가능한 데이터 형태를 의미합니다. 연속형 데이터는 일반적으로 **수치형 형식**으로 데이터를 인식합니다. 

수치형 형식에는 수학의 정의에 따라 정수(integer), 실수(numeric), 복소수(complex)로 나뉠수는 있지만, 데이터를 다루는데 있어서 크게 영향은 주지 않습니다.   

* 정수(integer) : 소수점이 없는 숫자로서 양수, 음수, 0을 포함함.  
* 실수(numeric) : 소수점을 포함하는 숫자  
* 복소수(complex) : i 가 들어가는 숫자 형태 (i^2 = -1)

예시 데이터의 HEIGHT 값 인 170, 150, 175, 155, 175, 170, 175, 170, 170, 170 과 같이 연속되있는 숫자들로 이뤄져 있으며, 값들의 평균(`mean()`)과 표준편차(`sd()`)를 구하며 막대그래프 보다는 **분포 그래프**를 통해 데이터의 분포를 알아 볼 수 있습니다.

\

```r
# dataset$HEIGHT의 평균값
mean(dataset$HEIGHT)
```

```
## [1] 168
```

```r
# dataset$HEIGHT의 표준편차
sd(dataset$HEIGHT)
```

```
## [1] 8.563488
```

\

```r
plot(density(dataset$HEIGHT))
```

![](/img/Basic_R_1.1_files/figure-html/continuous2-1.png)<!-- -->


 \ 
  
---------

\

### 2) 범주형 데이터 Categorical
\
범주형 데이터는 앞서 설명한 연속형 데이터와 달리 평균값을 구하거나 분산등의 수량화를 할 수 없고 각 범주에 해당하는 갯수, 즉 빈도수만을 구할 수 있는 데이터 형식을 범주형데이터라고 합니다. 
\
<table class="table table-striped" style="width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:right;"> X </th>
   <th style="text-align:right;"> SEX </th>
   <th style="text-align:right;"> AGE_GROUP </th>
   <th style="text-align:right;"> HEIGHT </th>
   <th style="text-align:right;"> WEIGHT </th>
   <th style="text-align:right;"> WAIST </th>
   <th style="text-align:right;"> BP_HIGH </th>
   <th style="text-align:right;"> SMK_STAT_TYPE_CD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 13 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 65 </td>
   <td style="text-align:right;"> 91.0 </td>
   <td style="text-align:right;"> 158 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 150 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:right;"> 73.4 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 94.0 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 4 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 12 </td>
   <td style="text-align:right;"> 155 </td>
   <td style="text-align:right;"> 55 </td>
   <td style="text-align:right;"> 67.5 </td>
   <td style="text-align:right;"> 138 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 5 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 75 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 128 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 84.8 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 7 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 175 </td>
   <td style="text-align:right;"> 110 </td>
   <td style="text-align:right;"> 111.5 </td>
   <td style="text-align:right;"> 130 </td>
   <td style="text-align:right;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 78.0 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 9 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 80 </td>
   <td style="text-align:right;"> 93.0 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:right;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:right;"> 10 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 8 </td>
   <td style="text-align:right;"> 170 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:right;"> 86.0 </td>
   <td style="text-align:right;"> 122 </td>
   <td style="text-align:right;"> 1 </td>
  </tr>
</tbody>
</table>
\
예시데이터에서 성별(SEX)을 나타내는 열에 대한 주석을 살펴보면, 1은 남자를 2는 여자를 나타내는 숫자입니다.\
따라서 'SEX'열에서 비록 숫자로 나타내는 값으로 1, 2, 1, 2, 1, 1, 1, 2, 1, 1이 나왔다고 하더라도 이 값은 연속형 성질을 가지지 않고 범주형 성질을 가지고 있다는 것을 알 수 있습니다. 또한 여기에서 남성을 나타내는 숫자 1은 여성을 나타내는 숫자 2보다 더 적다고도, 많다고도 할 수 없이 그 값 만을 의미하고 있습니다. 단지, 예시 데이터에서의 남자(1)는 7명, 여자(2)는 3명으로 빈도를 알 수 있을 뿐, 이에 대한 어떠한 수량화, 즉 평균값이나 분산 등에 의미가 있지는 않습니다. 따라서 이에 대해서는 빈도를 간단하게 표현할 수 있는 `table()`를 통해 각 범주에 해당하는 갯수를 간단하게 계산해낼 수 있습니다.
\

```r
table(dataset$SEX)
```

```
## 
## 1 2 
## 7 3
```
\
또 이에 대한 **막대그래프**는 `barplot()`을 통해 각 범주에 해당하는 갯수를 간단하게 표시할 수도 있습니다.
\

```r
barplot(table(dataset$SEX))
```

![](/img/Basic_R_1.1_files/figure-html/category2-1.png)<!-- -->
\

####  - 요인형 Factor 
이와 같이 dataset$SEX에서는 성별에 대한 코드로 1,2를 사용함으로서 범주형 성질을 가지고 있는 데이터지만, 데이터를 처리하는 연산에서는 이러한 숫자를 범주형 데이터로 인식하기 보다는 연속형 데이터로 인식합니다. 따라서 1과 2와 같은 데이터를 연속형데이터에서 범주형 데이터로 인식할 수 있도록 그 속성을 `as.factor()`를 이용하여 바꿔주는 것이 중요합니다. 이는 이후에 혹시라도 모를 범주형 데이터의 연산을 막을 수 있어 매우 유용합니다. 
\

```r
# 비교를 위해 original_data인 dataset
str(dataset)
```

```
## 'data.frame':	10 obs. of  8 variables:
##  $ X               : int  1 2 3 4 5 6 7 8 9 10
##  $ SEX             : int  1 2 1 2 1 1 1 2 1 1
##  $ AGE_GROUP       : int  13 8 8 12 8 8 8 6 8 8
##  $ HEIGHT          : int  170 150 175 155 175 170 175 170 170 170
##  $ WEIGHT          : int  65 45 75 55 75 70 110 70 80 70
##  $ WAIST           : num  91 73.4 94 67.5 93 ...
##  $ BP_HIGH         : int  158 110 130 138 128 115 130 115 115 122
##  $ SMK_STAT_TYPE_CD: int  3 1 1 1 3 2 3 1 2 1
```

```r
# factor로 바뀐 dataset_fc
dataset_fc <- dataset
dataset_fc$SEX <- as.factor(dataset_fc$SEX)
str(dataset_fc)
```

```
## 'data.frame':	10 obs. of  8 variables:
##  $ X               : int  1 2 3 4 5 6 7 8 9 10
##  $ SEX             : Factor w/ 2 levels "1","2": 1 2 1 2 1 1 1 2 1 1
##  $ AGE_GROUP       : int  13 8 8 12 8 8 8 6 8 8
##  $ HEIGHT          : int  170 150 175 155 175 170 175 170 170 170
##  $ WEIGHT          : int  65 45 75 55 75 70 110 70 80 70
##  $ WAIST           : num  91 73.4 94 67.5 93 ...
##  $ BP_HIGH         : int  158 110 130 138 128 115 130 115 115 122
##  $ SMK_STAT_TYPE_CD: int  3 1 1 1 3 2 3 1 2 1
```
\

위의 형식을 보면 $SEX 열에 해당하는 형식이 기존의 number중에 하나였던 `int`에서 `Factor`로 바뀐 것을 확인 할 수있습니다.
이렇게 바뀐 Factor형식의 값은 기존에 더하거나 평균을 내는 등의 값으로 계산이 불가능 합니다.


```r
# original dataset에서 성별(SEX)를 평균 냄
mean(dataset$SEX)
```

```
## [1] 1.3
```

```r
# 성별을 factor 형식으로 바꾼 dataset_fc에서 성별을평균 냄
mean(dataset_fc$SEX)
```

```
## Warning in mean.default(dataset_fc$SEX): argument is not numeric or
## logical: returning NA
```

```
## [1] NA
```
\
따라서, 범주형 데이터를 다루는 요인형 변수 factor는 매우 중요하므로 이에 대한 데이터을 파악하기 위해 여러 함수들이 존재합니다.
범주에 갯수를 한눈에 파악하는 `nlevels()` 혹은 범주의 이름을 파악할 수 있는 `levels()`을 통해 쉽게 범주형 데이터를 파악할 수 있습니다.   
\
예시 데이터에서 마지막 열인 흡연상태(SMK_STAT_TYPE_CD)에는 해당수검자의 흡연상태 여부, 피우지 않는다(1), 이전에 피웠으나 끊었다(2), 현재 피우고 있다(3)에 따라서 각 값을 숫자 형태로 1,2,3으로 코딩했다고 적혀있습니다. 이를 확인하기 위해서 `dataset$SMK_STAT_TYPE_CD`라는 열에는 범주형 데이터로 어떤 값이 몇개나 범주를 설정하고 있는지 확인하고자 한다면 `nlevel(dataset$SMK_STAT_TYPE_CD)`을 통해 범주가 3개가 있다는 것을 확인하고, 그 범주에 대한 이름은 `levels(dataset$SMK_STAT_TYPE_CD)`을 통해 그 코딩된 이름이 1, 2, 3라는 것도 손 쉽게 알아낼 수 있습니다.
\


```r
dataset$SMK_STAT_TYPE_CD <- as.factor(dataset$SMK_STAT_TYPE_CD)
nlevels(dataset$SMK_STAT_TYPE_CD)
```

```
## [1] 3
```

```r
levels(dataset$SMK_STAT_TYPE_CD)
```

```
## [1] "1" "2" "3"
```
\
때때로, 연속형 성질의 값을 계산의 편리를 위해 범주형 성질의 데이터로 변환하는 경우가 있는데 예시데이터의 AGE_GROUP에 해당하는 값이 그 좋은 예시가 될 수 있습니다.
\
일반적으로 나이는 소수점으로 딱 떨어지지는 않지만 15살, 16살과 같이 1씩 차이가 나는 값들로만 이뤄져 있습니다.  하지만, AGE_GROUP에 대한 설명을 참고해보면 연령대코드(AGE_GROUP)는 20~84세까지 5세 단위로, 85세 이상은 하나의 단위로 그룹화하였다고 설명되어 있습니다. 0~4세까지는 1이라는 값으로, 5~9세는 2라는 값으로 그룹화를 하여 코딩한 것입니다. 
\
따라서 이러한 경우에는 기존에 나이라는 데이터는 비록 연속형 성질을 갖고 있더라도 그룹화를 함으로서 범주형데이터로서 데이터를 다루게 됩니다.  
\

#### - 논리형 logical 
논리형(logical variables)은 TRUE와 FALSE로만 이뤄져 있는 데이터 형태로서 T, F로도 간단하게 사용할 수 있습니다. TRUE/FALSE와 같은 값으로 변수가 구성되는데, 일반적으로는 논리에 부합하는지 못하는지에 따라 나뉘는데 사용되며 이를 이용하여 특정 값만을 추출하는데 사용할 수 있습니다. 
\
아래와 같이 3이 5보다 큰 값인지, 3이 1보다 큰 값인지를 구하는 논리의 참/거짓 유무를 TRUE, FALSE로 받아 출력합니다. 

```r
3>5 #FALSE
```

```
## [1] FALSE
```

```r
3>1 #TRUE
```

```
## [1] TRUE
```
\
예시 데이터에 존재하는 BP_HIGH는 수축기 혈압을 나타내는 용어로서 일반적으로 130mmHg 이상이면 고혈압으로 진단합니다. 따라서 예시 데이터에는 158, 110, 130, 138, 128, 115, 130, 115, 115, 122 의 값에서 130보다 높은 값을 TRUE, 그보다 낮으면 FALSE라고 논리형 값을 출력하고자 할 때, `dataset$BP_HIGH > 130` 라는 연산을 통해 그 값이 TRUE, FALSE, FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE 될 수 있음을 확인 할 수 있습니다.


```r
dataset$BP_HIGH > 130
```

```
##  [1]  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE
```




