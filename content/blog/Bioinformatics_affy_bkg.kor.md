 +++
title = "affy::Background correction"
date = "Jan 2, 2006"
description = ""
tags = ["R", "affy"]
categories = ["Bioinformatics"]
author = "Techne316"
mathjax = true
+++
## Background correction
------------------------

	## setting
    library(affydata)
    data(Dilution)



Background correction은 microarray에서 signal을 읽는 과정에서 noise를
줄이고, 전체적인 background를 잡아주는 역할을 합니다.

`affy`에서 다루고 있는 background correction 방법에는 rma, mas으로 총
2가지 방법과 background correction이 없는 “none”옵션을 제시하고
있습니다.

<br><br>

### 2.1 none

어떠한 background correction없이 기존의 value 그대로를 이용하여
원본데이터를 사용하고자 할 때 선택할 수 있는 `none` 옵션입니다.

    bkg1 <- bg.correct.none(Dilution) %>% exprs()

Boxplot  

![](/img/bkg_correction_files/figure-markdown_strict/unnamed-chunk-1-1.png)

<br><br>

### 2.2 rma

`rma()`방법은 robust multi-array average의 약자로 [Irizarry et al. (2003)](https://academic.oup.com/biostatistics/article/4/2/249/245074)에 의해 고안된 방법입니다. 이 방법은  probe intensity의 empirical distribution에 의해 제안된 모델에 의해 PM(Perfect
Match) Probe의 intensity값을 조정합니다. 단, MM(Mis Match) probe들의
intensity는 조정되지 않습니다.

PM의 값은 normal noise component N(Normal with mean $\mu$ and variance $\sigma^2$)과 exponential signal component S(exponential with mean $\alpha$)을 따른다는 가정으로, 아래의 모델을 따라서 값이 조정됩니다.

$$ \mathsf{E}(s|O = 0) = a + b\dfrac{\phi(\dfrac{a}{b}) - \phi(\dfrac{o-a}{b}) }{\Phi(\dfrac{a}{b}) + \Phi(\dfrac{o-a}{b}) -1} $$

여기서, $\mathsf{a} = \mathsf{s}-\mu - \sigma^2$이고, $\mathsf{b} = \sigma$ 이며, $\phi$와 $\Phi$는 각각 standard normal distribution density와 distribution functions을 각각 의미합니다.

    bkg2 <- bg.correct.rma(Dilution) %>% exprs()

Boxplot  

![](/img/bkg_correction_files/figure-markdown_strict/unnamed-chunk-2-1.png)

<br><br>

### 2.3 mas

`mas()`방법은 Statistical Algorithms Description Document Aﬀymetrix
(2002)에서 고안된 방법으로서, 한 개의 chip을 16개의 구역으로 나누어 각
구역에서 lowest 2%의 probe intensities를 기준으로 해서 각 구역의
background correction을 진행하는 방법입니다. 따라서 이 방법은,
PM(Perfect Match)와 MM(Mis Match) probe의 intensity에 조정이 들어갑니다.

    bkg3 <- bg.correct.mas(Dilution) %>% exprs()

Boxplot  

![](/img/bkg_correction_files/figure-markdown_strict/unnamed-chunk-3-1.png)
<br>

------------------------------------------------------------------------

### **SUMMARY**

`rma()`방법과 `mas5()`방법 중에서 더 좋은 background correction인지에
대한 의견은 실험에 따라 다르므로 한쪽이 더 좋은 방법이다라고 말하기는
어렵습니다. 다만, MAS5는 각각의 sample에서 background correction을
진행하므로 독립적이고 MM값을 조정한다는 점이 특징적이라면, RMA는 각각의
sample을 한번에 고려한 통계치를 이용한다는 점과, MM을 사용하지 않는 다는
점이 특징적입니다.

![](/img/bkg_correction_files/figure-markdown_strict/unnamed-chunk-4-1.png)

![](/img/bkg_correction_files/figure-markdown_strict/unnamed-chunk-5-1.png)
