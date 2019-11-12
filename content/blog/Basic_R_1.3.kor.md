+++
title = "Data structure II"
date = "Jan 2, 2006"
description = ""
tags = ["R", "basic"]
categories = ["Basic R"]
author = "Techne316"
+++

---

### 1) 배열array
벡터와는 달리 행row과 열column이 있으며 일반적으로 행\*열과 같은 형식으로 데이터의 dimension을 표현할 수 있는 데이터 구조입니다. 배열과 행렬은 비슷한 듯 보이지만, 배열은 다차원의 구조(3D, 4D)를 다룰 수 있다는 점에서 행렬과는 차이가 있습니다. 
\
다차원 구조는 간단하게는 [행,열,차원1]로 나타낼 수 있으며 같은 행과 열을 가지는 데이터를 여러개 표현하고자 할때 유용하게 쓰입니다. `dim()`를 이용하여 배열의 구조를 쉽게 구할 수 있습니다. 
\
예로 들어, 최근 많이 사용하고 있는 이미지 파일을 수치화 한다고 할 때, array type의 데이터를 사용하여 가로 세로 32개의 픽셀로 이뤄진 데이터 형태  (32*32)의 흑백이미지 5장을 하나의 variable로 만들어 사용하는 것이 편리할 것입니다.
\
여기서는 rnorm()를 이용하여 1024개의 랜덤 값을 받아서 사용하도록 하겠습니다. 

```r
value <- rnorm(1024) #32*32 = 1024, 1024개의 random변수 생성기
array1 <- array(value, c(32,32,5)) #행 32개, 열 32개의, 2차원 행렬 5개
dim(array1)
```

```
## [1] 32 32  5
```
\
array에서 원소로 접근하기 위해서는 index를 잘 사용해야 합니다. 
array의 dimension은 [row, col, 3D]로 이뤄져 있으므로 5개의 이미지 중 3번째의 이미지에 접근하려면 array1[,,3]을 통해 접근 할 수 있습니다. 
\
혹은 3번째 이미지에서 가장 중앙에 있는 값(가로, 세로에서 16번째 픽셀의 값)이 궁금하다면 array1[16,16,3]을 통해서도 특정 값에 접근할 수도 있습니다.
\

```r
dim(array1[,,3]) 
```

```
## [1] 32 32
```

```r
array1[16,16,3]
```

```
## [1] -1.475534
```
\
만약, 흑백이미지가 아닌 컬러이미지를 이용한다면, (32,32,5,3)으로 가로 세로 32pixel의 이미지가 5개 있고 3개의 channel로서 (R,G,B)로 되어 있다고 생각하면 됩니다. 이렇게 4개의 차원으로 이뤄진 데이터를 4D라고 하며 array 형태를 가장 잘 표현해 줄 수 있습니다. 
\
\


### 2) 행렬 matrix
행렬은 2차원구조를 가진 데이터 구조로서 행row과 열column으로 이뤄져 있습니다. 일반적으로 행렬의 구조는 배열과 동일하게 `dim()`을 통해 구할 수 있습니다.
\
행렬matrix은 `matrix(value, nrow, ncol)`방식으로 생성되며, 각 행과 열의 이름은 index 순서로 지정되며 수정이 불가능합니다.
\
예로 들어,  1,2,3으로 구성된 value로 3개의 행과 2개의 열로 구성된 행렬을 만든다고 했을 때,

```r
value <- c(1,3,2,1,2,3)
mat1 <- matrix(value, nrow =3, ncol=2)
mat1
```

```
##      [,1] [,2]
## [1,]    1    1
## [2,]    3    2
## [3,]    2    3
```
다음과 같이 열을 기준으로 순서대로 원소가 배치되는 것을 알 수 있습니다.
\
또한 행렬에서 각 원소에 접근하는 방법으로는 `[row index, col index]`와 같이 index를 사용할 수 있습니다. \
예로들어, `mat1` 행렬의 2번째 행, 1번째 열에 해당하는 원소 값은 `mat1[2,1]`를 통해 알 수 있습니다. 또한 첫번째 행에 해당하는 모든 원소 값을 알고 싶다면 `mat1[1,]`, 두번째 열에 해당하는 값을 알고 싶다면 `mat1[,2]`을 통해 하나의 원소 값 뿐만 아니라 해당되는 행과 열의 전체 값 또한 알 수 있습니다.

```r
mat1[2,1]
```

```
## [1] 3
```

```r
mat1[1,]
```

```
## [1] 1 1
```

```r
mat1[,2]
```

```
## [1] 1 2 3
```
\
앞서 list에서 설명한 variable들인 을 이용하여 행렬을 만든다고 한다면, `name`에해당하는 원소의 갯수가 6개 이므로 열 순서로 값이 지정될 수 있도록, 3\*6 구성의 행렬로 하는 것 보다는 6\*3 구성의 행렬이 더 적합하게 사용할 수 있습니다.
\

```r
name <- c("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")
height <- c(156,178,165,168,164,159)
logic <- c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)

mat2 <- matrix(c(name, height, logic), nrow=3, ncol=6)
mat2
```

```
##      [,1]     [,2]     [,3]  [,4]  [,5]   [,6]   
## [1,] "Jane"   "James"  "156" "168" "TRUE" "TRUE" 
## [2,] "Mike"   "Mikael" "178" "164" "TRUE" "FALSE"
## [3,] "Rachel" "Lisa"   "165" "159" "TRUE" "FALSE"
```

```r
mat3 <- matrix(c(name, height, logic), nrow=6, ncol=3)
mat3
```

```
##      [,1]     [,2]  [,3]   
## [1,] "Jane"   "156" "TRUE" 
## [2,] "Mike"   "178" "TRUE" 
## [3,] "Rachel" "165" "TRUE" 
## [4,] "James"  "168" "TRUE" 
## [5,] "Mikael" "164" "FALSE"
## [6,] "Lisa"   "159" "FALSE"
```

\
matrix에서 값을 받는 value는 벡터 하나를 받게 되있기 때문에, 위의 예시와 같이 문자, 숫자, 논리와 같은 다양한 형식이 존재하는 경우 하나의 형식으로 통일되어 그 값을 출력하게 됩니다. 따라서 `mat3`의 경우에는 모든 데이터가 문자로 통일되어 있습니다. 

만약, list에서 사용한 것 처럼 각각의 vector값의 형식을 유지하면서 2차원구조의 데이터를 만들고 싶다면 data.frame을 통해 만들어 주는 것이 매우 유용합니다.
\

### 3) 데이터프레임 data.frame
데이터프레임 dataframe은 가장 많이 사용되고 있는 데이터 구조로서 행렬과 유사하지만 다양한 형식(문자, 숫자, 논리)를 가질 수도 있다는 점에서 가장 큰 장점을 가지고 있습니다. 

먼저 list에서 설명한 variable들을 이용하여 열의 이름이 Name, Height, Logic인 데이터 프레임을 만들어 보겠습니다.

```r
name <- c("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")
height <- c(156,178,165,168,164,159)
logic <- c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)

dataframe1 <- data.frame(Name = name,
                         Height = height,
                         Logic = logic)
dataframe1
```

```
##     Name Height Logic
## 1   Jane    156  TRUE
## 2   Mike    178  TRUE
## 3 Rachel    165  TRUE
## 4  James    168  TRUE
## 5 Mikael    164 FALSE
## 6   Lisa    159 FALSE
```

```r
str(dataframe1)
```

```
## 'data.frame':	6 obs. of  3 variables:
##  $ Name  : Factor w/ 6 levels "James","Jane",..: 2 5 6 1 4 3
##  $ Height: num  156 178 165 168 164 159
##  $ Logic : logi  TRUE TRUE TRUE TRUE FALSE FALSE
```
\
다음과 같이 각 열에 Name, Height, Logic이라는 열의 이름을 가진 것을 볼 수 있으며, 데이터의 형태도 Name은 factor, Height는 numeric, Logic에는 logical 로 형태도 유지하며 데이터프레임이 형성된 것을 알 수 있습니다. 여기서 자세히 살펴보시면 character였던 `name`이 data.frame에 Name이라는 열로 지정되면서 Factor형식으로 입력된 것을 확인 할 수 있습니다. 이는 `data.frame()`에 기본적으로 저장되어 있는 argument 중에서  `stringAsFactors=T`라는 명령어가 기본(default)로 저장되어 있기 때문인데 string 즉 문자형식은 자동으로 Factor 형식으로 입력되어 data.frame으로 저장하라는 명령어입니다. 따라서 data.frame은 문자열을 자동으로 Factor로 인식하여 범주형 데이터를 처리하기에도 매우 용이합니다.
\

데이터 프레임의 원소에 접근하는 방법은 index를 통해서도 할 수 있으며, 각 행과 열의 이름으로도 접근 할 수도 있습니다. 앞서 행렬과 같이 행과 열의 인덱스를 통해서도 값을 추출해 낼 수 있으며, dataframe의 열 이름을 통해서도 열을 추출할 수 있습니다.


```r
# index 
dataframe1[,1]
```

```
## [1] Jane   Mike   Rachel James  Mikael Lisa  
## Levels: James Jane Lisa Mikael Mike Rachel
```

```r
dataframe1[,"Name"]
```

```
## [1] Jane   Mike   Rachel James  Mikael Lisa  
## Levels: James Jane Lisa Mikael Mike Rachel
```

\
\