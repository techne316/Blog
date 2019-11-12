+++
title = "Data structure"
date = "Jan 2, 2006"
description = ""
tags = ["R", "basic"]
categories = ["Basic R"]
author = "Techne316"
+++
---

# 1.2 데이터의 구조
\
데이터의 구조는 간단하게는 벡터vector, 리스트list, 배열array/행렬matrix, 데이터 프레임dataframe이 있습니다. 

* 벡터 vector : 가장 기본적인 데이터 구조로서 여러개의 수치값이 순차적으로 이뤄진 데이터 구조\
* 리스트 list : 벡터와 비슷한 형태로 여러 값이 순차적으로 이뤄져 있지만, 이 때 값이 값 하나를 가진 수치값일 수도 있고 여러개의 수치가 포함된 벡터 혹은 행렬 형태의 값을 받을 수도 있습니다.\
* 배열array : 행과 열로 이뤄진 데이터 구조로서 다차원구조를 표현가능합니다.\
* 행렬 matrix : 행과 열로 이뤄진 2차원 벡터입니다.\
* 데이터프레임 dataframe : 가장 많이 쓰이는 데이터 구조로서 행렬과 비슷하지만, 더 쉽게 데이터에 접근할 수 있다는 장점이 있습니다.\ 
\
따라서, 데이터의 구조에 따라 특정 데이터의 원소에 접근할 수 있는 방법이 다르므로 이를 유의해서 각 구조의 특징을 파악하는 것이 중요합니다.
\
\


### 1) 벡터 vector
벡터는 일렬로 나열된 형태를 의미하며 벡터의 형태로는 앞서 설명한 숫자값, 논리값, 문자값 중 단 하나의 형태만을 가지며, 변수variable에 값을 저장하는데 가장 기본적으로 사용됩니다. 

`변수`를 정해주고 대입연산자인 `<-` 로 값을 입력해주는 형식으로 값을 저장할 수 있습니다.
\
`name`이라는 variable에 "Jane", "Mike", "Rachel", "James", "Mikael", "Lisa"이라는 각각의 이름을 원소로 가지는 값을 벡터로 넣기 위해서는 `name <- c("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")`와 같이 `c()`라는 괄호 안에 값을 넣어줘야 합니다. 특히 Jane, Mike와 같이 문자로 된 경우에는 단어의 양 끝에 `" "`를 넣어 구분해야 벡터에서 인식 할 수 있습니다. 
\


```r
# 문자로 이뤄진 'name' 변수
name <- c("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")
name
```


```
## [1] "Jane"   "Mike"   "Rachel" "James"  "Mikael" "Lisa"
```


\
이와 달리 숫자로 이뤄진 벡터의 경우에는 숫자 자체를 바로 넣어줄 수 있습니다.  `height`라는 변수에 6명의 키의 값을 저장한다면,  `height <- c(156,178,165,168,164,159)` 와 같은 방법으로 넣어줄 수 있습니다.  



```r
# 숫자로 이뤄진 'height' 변수
height <- c(156,178,165,168,164,159)
height
```


```
## [1] 156 178 165 168 164 159
```
\


여기에서, 키가 160cm가 넘어가는 친구들을 TRUE, 이하인 친구를 FALSE라는 논리값을 계산해본다고 할때, 첫번째 Jane의 경우 160 이하이므로 FALSE, 두 번째 Mike의 경우 178cm로 160cm 초과이므로 TRUE라는 값을 받습니다. 이를 `height`에 하나씩 계산해 본다고 하면 FALSE  TRUE  TRUE  TRUE  TRUE FALSE과 같은 값이 나오게 됩니다. 따라서 이를 `logic`이라는 변수에 저장 한다면, `logic <- c(FALSE,TRUE,TRUE,TRUE,TRUE,FALSE)`과 같이 저장할 수 있습니다. 이때 TRUE, FALSE는 문자열이 아니므로 `" "`을 붙이지 않아야 합니다. 
\


```r
# 논리값으로 이뤄진 'logic'변수
logic <- c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)
logic
```


```
## [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE
```
\

벡터의 값은 자동으로 index가 지정되어 첫번째 오는 원소를 1, 두번째 오는 원소를 2로 순서대로 값이 지정됩니다. 따라서 `name`이라는 변수에서 3번째로 저장되 있는 Rachel을 불러주기 위해서는 `name[3]`을 통해 Rachel을 불러올 수 있습니다. 이렇게 지정된 index는 통해 값을 불러오는 방법은 이후에 **2.6 벡터의 원소 선택하기** 에서 더 자세하게 설명하도록 하겠습니다. 
\
또한, 벡터에는 이름을 정해줄 수도 있습니다. 예로 들어 두번째 `height` 라는 변수 안에 저장된 156이라는 값에 Jane이라는 이름을 붙여줄 수도 있습니다. 벡터에 값을 지정해 줄 때에는 `height <- c()`라고 값을 입력했다면, height에 이름을 넣어주고 싶을 때에는 `names()`을 이용하여 `names(height) <- c()`을 통해 벡터의 이름을 지정해 줄 수도 있습니다.
\


```r
#기존의 height
height
```

```
## [1] 156 178 165 168 164 159
```

```r
# 이름을 name변수로 지정해준 height
names(height) <- name
height
```

```
##   Jane   Mike Rachel  James Mikael   Lisa 
##    156    178    165    168    164    159
```
\


---------
  



### 2) 리스트 list


리스트는 단일 원소 뿐만 아니라, 벡터 (문자, 숫자, 논리값) 혹은 데이터프레임 등을 모든 데이터를 형태에 구애받지 않고 저장할 수 있다는 장점이 있습니다. 따라서 다양한 형태의 값을 하나의 변수에 저장하고 싶을 때 사용할 수 있습니다.
\
앞서 벡터에서 지정한 것 처럼 "Jane", "Mike", "Rachel", "James", "Mikael", "Lisa" 6명의 이름을 이번에는 `list()`함수를 이용하여 저장해보도록 하겠습니다.

```r
lst_name <- list("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")
lst_name
```

```
## [[1]]
## [1] "Jane"
## 
## [[2]]
## [1] "Mike"
## 
## [[3]]
## [1] "Rachel"
## 
## [[4]]
## [1] "James"
## 
## [[5]]
## [1] "Mikael"
## 
## [[6]]
## [1] "Lisa"
```
벡터와는 달리 리스트의 index는 `[[ ]]`를 통해서 각 원소의 위치를 지정합니다. 따라서 `list_name`라는 리스트 변수에는  첫번째 위치에 Jane, 두번째 위치에는 Mike, 세번째에는 Rachel과 같이 각 값이 리스트의 위치에 저장되어 있습니다. 
\
그렇다면, 리스트에 하나의 원소가 아닌 여러개의 원소가 저장 된 벡터를 받아 리스트를 설정해보도록 하겠습니다.

```r
name <- c("Jane", "Mike", "Rachel", "James", "Mikael", "Lisa")
height <- c(156,178,165,168,164,159)
logic <- c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)

# list classA
lst_classA<- list(name, height,logic)
str(lst_classA)
```

```
## List of 3
##  $ : chr [1:6] "Jane" "Mike" "Rachel" "James" ...
##  $ : num [1:6] 156 178 165 168 164 159
##  $ : logi [1:6] TRUE TRUE TRUE TRUE FALSE FALSE
```
lst_classA 리스트는 3개의 원소로 이루졌으며, 첫번째 원소인 `lst_classA[[1]]`에는 6명의 학생이름이 들어간 name 변수가 문자형식으로 들어가 있고, 두번째 원소인 `lst_classA[[2]]`에는 6명의 키가 저장된 height가 숫자형태로, 세번째에는 논리값이 들어갔습니다.
\
`list()`에는 여러가지 형태가 고유한 형식이 유지되며 합쳐지는 것과 달리 벡터형태로 받게 되면 한가지 형식으로 통일됩니다.

```r
#vector classA
classA <- c(name, height, logic)
str(classA)
```

```
##  chr [1:18] "Jane" "Mike" "Rachel" "James" "Mikael" "Lisa" "156" "178" ...
```
따라서 이와 같이 벡터 형식을 받게 되면 숫자도 문자로 바뀌어 계산을 하거나, 논리를 이용하여 데이터를 분석할 수 없게 되므로 이를 유의해서 사용해야 합니다.

\
리스트 변수인`lst_classA`에서 특정 원소에 접근하고자 한다면, index를 사용해야 하는데 리스트의 index는 벡터와는 달리 [[]]를 사용해서 원소에 접근 할 수 있습니다. 
\
만일, classA라는 리스트변수의 첫번째 원소가 궁금하다면, `lst_classA[[1]]`을 통해서 1번째 원소에 저장된 값(Jane, Mike, Rachel, James, Mikael, Lisa)을 알 수 있습니다. 또한 리스트의 첫번째 원소에 저장된 벡터들을 구하고, 이 벡터에 존재하는 세 번째 원소가 궁금한 경우 에는 간단하게 `lst_classA[[1]][3]`과 같이 구해진 벡터에 `[3]`을 통해서 값을 구할 수 있습니다. 
\

```r
lst_classA[[1]] #name
```

```
## [1] "Jane"   "Mike"   "Rachel" "James"  "Mikael" "Lisa"
```

```r
lst_classA[[1]][3] #3rd index in name variable
```

```
## [1] "Rachel"
```
\
리스트 변수를 사용할 때 한가지 유의해야 할 점은 `lst_classA[1]`와 `lst_classA[[1]]`는 다르다는 점 입니다. 

```r
lst_classA[1] #name
```

```
## [[1]]
## [1] "Jane"   "Mike"   "Rachel" "James"  "Mikael" "Lisa"
```

```r
lst_classA[[1]] #3rd index in name variable
```

```
## [1] "Jane"   "Mike"   "Rachel" "James"  "Mikael" "Lisa"
```
\
위와 같이 `[ ]`을 사용하는 경우 리스트에 첫번째 원소라는 `[[1]]`가 포함되며, names에 직접적으로 접근하기 위해서는 `lst_classA[[1]][3]`과 같이 `[[ ]]`을 통해 원소에 접근 한 후에 그 안에 있는 원소를 불러올 수 있습니다.
\

```r
lst_classA[1][3] #name
```

```
## [[1]]
## NULL
```

```r
lst_classA[[1]][3] #3rd index in name variable
```

```
## [1] "Rachel"
```
\

