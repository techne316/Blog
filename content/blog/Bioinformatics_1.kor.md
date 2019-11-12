+++
title = "Linear model"
description = ""
tags = ["R", "limma"]
categories = ["Bioinformatics"]
author = "Techne316"
+++

# Limma packages

### 2.1 **Linear models** for microarray data

To find out differential expressed genes in microarray, limma used gene-wise linear models. Here, I will explian how to design the matrix for linear model. 


There are two different types of array.  
1. Two color array  
2. single channel array 


\
#### 1) Two color array
This type of array uses two different dyes during the cDNA process. The expression value of each gene is calculated by log-ratios of dye intensity.So, it is important to label the dye type.
$$\text{y}_g = log_2(\text{Red intensity}_g)-log_2(\text{Green intensity})_g.$$ 
# 
Here, I will explain how to build a matrix design with several examples. The way to label the dyes usually use a arrow annotation as in Kerr and Churchill (2001). 
* Each array represents a microarray. 
* The arrow direction is head to the sample which is labelled red(cy5) from the sample which is labelled green(cy3).
* The symbols A, B and C means samples. 
* To apply linear model this information should be converted into matrix format
$$X = \tbinom{1}{-1}$$


For example, 

- $$\color{Red}A\rightarrow\color{ForestGreen}B $$
: one microarray experiment.
: A is lablled with red and B is labelled with green.
: the matrix of this array $\begin{align} X &  =(1) = \text{ y}_g \end{align}$ 

# 
- $$\color{Red}A\leftrightarrows\color{ForestGreen}B $$
: two microarray experiments
: **dye-swap experiment**
: the matrix of this array $\begin{align} X &  =\tbinom{1}{-1}  =  \binom{\text{y}_{g1}}{\text{y}_{g2}} \end{align}$ 
In this case, the expression level of each genes were calculated by log ratio of red and green. So, dye-swapped sample should be calculated opposite direction. 
Therefore, the above equation could be explain following matrix :$$$\text{A}\rightarrow\text{B} = (1)$$$ $$$\text{A}\leftarrow\text{B} = (-1)$$$ is represented to (1)

In limma packages, Swirl Zebrafish **(A single-Group Experiment)** is a good example case study to explain this concept.

The experiment was carried out using WT and MT model system in zebrafish to find BMP2 gene affects. The author designed experiment that two set of dye-swap experiments were performed (total 4 replicated hybridizaion) and each of microarrys compares RNA from swirl fish(mutant) with RNA form normal fish(wild type). The data used for this case study can be downloaded from http://bioinf.wehi.edu.au/limmaGUI/DataSets.html.  

|slide number|File name|Cy3(green)|Cy5(red)|Date|
|------------|---------|---|---|----|
|81|swirl.1.spot|swirl|wild type|2001/9/20|
|82|swirl.2.spot|wild type|swirl|2001/9/20|
|93|swirl.3.spot|swirl|wild type|2001/11/8|
|94|swirl.4.spot|wild type|swirl|2001/11/8|




In summary, 
* 2 set of dye-swap experiment [81,82] and [93,94]
* WT(wild type) vs MT(swirl)

This experiemnt design will be converted to
$$ X = \begin{pmatrix}
{-1}\\{ 1}\\{-1}\\{ 1}\end{pmatrix}$$
