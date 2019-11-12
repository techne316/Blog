+++
title = "affy"
description = ""
tags = ["R", "affy"]
categories = ["Bioinformatics"]
author = "Techne316"
+++


The *affy* package designed to analyze and explore data of Affymetrix
oligonucleotide arrary probe level data. Also, the package includes
several plotting function to evaluate quality of array or probe level
intensity.

-   probe oligonucleotides of 25 base pair length used to probe RNA
    targets.
-   perfect match probes intended to match perfectly the target
    sequence.
-   PM intensity value read from the perfect matches. mismatch the
    probes having one base mismatch with the target sequence intended to
    account for non-speciﬁc binding.
-   MM intensity value read from the mis-matches.
-   probe pair a unit composed of a perfect match and its mismatch.
-   aﬀyID an identiﬁcation for a probe set (which can be a gene or a
    fraction of a gene) represented on the array.
-   probe pair set PMs and MMs related to a common aﬀyID.

First of all, we will introduce some pre-processing method that affy
package supported using an example data. The example data set is
downloaded in the affydata package.

    library(affydata)
    data(Dilution)

<a href="https://www.bioconductor.org/packages/release/bioc/vignettes/affy/inst/doc/builtinMethods.pdf" class="uri">https://www.bioconductor.org/packages/release/bioc/vignettes/affy/inst/doc/builtinMethods.pdf</a>


### 1.1 rma()

    #eset1 <- rma()

### 1.2 justRMA

    #eset2 <- justRMA(celfile.path = H_dir)

### 1.3 mas5()

    #eset3 <- mas5(Data)

### 1.4 expresso()

    #eset4 <- expresso(Dilution,
    #                  bgcorrect.method="none",
    #                 normalize.method="constant",                      pmcorrect.method="pmonly",
    # summary.method="liwong")

    MAplot(Dilution, pairs = TRUE, plot.method = "smoothScatter")


![](/img/191014_2_files/figure-html/MAplot-1.png)

     par(mfrow=c(2,2))
    image(Dilution)

![](/img/191014_2_files/figure-html/image-1.png)

    boxplot(Dilution, col=c(2,3,4,5))

![](/img/191014_2_files/figure-html/boxplot-1.png)

#### RNA degradation plots

    degradation <- AffyRNAdeg(Dilution)
    summaryAffyRNAdeg(degradation)

    ##            20A    20B    10A    10B
    ## slope  -0.0239 0.0363 0.0273 0.0849
    ## pvalue  0.8920 0.8400 0.8750 0.6160

    plotAffyRNAdeg(degradation)

![](/img/191014_2_files/figure-html/RNAdeg-1.png)

2. Background correction
------------------------

In affy package, there are 4 different background correction methods :
bg.correct, mas, none, rma

    eset1 <- expresso(Dilution,
                      bgcorrect.method="none",
                      normalize.method="quantiles",
                      pmcorrect.method="pmonly",
                      summary.method="medianpolish")
    eset2 <- expresso(Dilution,
                      bgcorrect.method="rma",
                      normalize.method="quantiles",
                      pmcorrect.method="pmonly",
                      summary.method="medianpolish") #rma() default

### 2.1 none

If you choose “none” option in background correction parameter, it
returns original values as it is. `bgcorrect.method = "none"`

    bkg1 <- bg.correct.none(Dilution) %>% exprs()

Boxplot  

![](/img/191014_2_files/figure-html/unnamed-chunk-1-1.png)

### 2.2 rma

These are background adjustment implementations for the rma method
Irizarry et al. (2003). They diﬀer only in how they estimate a set of
parameters (generally you should use rma in preference to rma2. In both
cases PM probe intensities are corrected by using a global model for the
distribution of probe intensities. The model is suggested by looking at
plots of the empirical distribution of probe intensities. In particular
the observed PM probes are modeled as the sum of a normal noise
component N (Normal with mean µ and variance σ2) and a exponential
signal component S (exponential with mean α). To avoid any possibility
of negatives, the normal is truncated at zero. Given we have O the
observed intensity, this then leads to an adjustment.  
E (s|O = o) = a + b φa b−φo−a b Φ a b+ Φo−a b −1where a = s−µ−σ2α
and b = σ. Note that φ and Φ are the standard normal distribution
density and distribution functions respectively. Note that MM probe
intensities are not corrected by either of these routines.

    bkg2 <- bg.correct.rma(Dilution) %>% exprs()

Boxplot  

![](/img/Basic_R_1.1_files/figure-html/continuous2-1.png)<!-- -->

![](/img/191014_2_files/figure-html/unnamed-chunk-2-1.png)

![](/img/191014_2_files/figure-html/unnamed-chunk-3-1.png)

### 2.3 mas

This is an implementation of the background correction method outlined
in the Statistical Algorithms Description Document Aﬀymetrix (2002). The
chip is broken into a grid of 16 rectangular regions. For each region
the lowest 2% of probe intensities are used to compute a background
value for that grid. Each probe is then adjusted based upon a weighted
average of the backgrounds for each of the regions. The weights are
based on the distances between the location of the probe and the
centriods of 16 diﬀerent regions. Note this method corrects both PM and
MM probes.

    bkg3 <- bg.correct.mas(Dilution) %>% exprs()

Boxplot  

![](191014_2_files/unnamed-chunk-4-1.png)

![](191014_2_files/unnamed-chunk-5-1.png)

------------------------------------------------------------------------

### **SUMMARY**

![](/img//img/191014_2_files/figure-html/unnamed-chunk-6-1.png)

![](/img/191014_2_files/figure-html/unnamed-chunk-7-1.png)

3. Normalization
----------------

constant, contrasts, invariantset, loess, methods, qspline, quantiles,
quantiles.robust constant, contrasts, invariantset, loess, methods,
qspline, quantiles, quantiles.robust

First of all, original data set might be like this :
![](/img/191014_2_files/figure-html/unnamed-chunk-8-1.png)

However, affy package support 8 different normalization methods, such as
`r normalize.AffyBatch.methods()[c(1:4,6:8)]`

To check difference between methods,

![](/img/191014_2_files/figure-html/unnamed-chunk-9-1.png)

![](/img/191014_2_files/figure-html/unnamed-chunk-10-1.png)

4. Probe specific background correction
---------------------------------------
