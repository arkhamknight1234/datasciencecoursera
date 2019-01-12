Developing Data Products Shiny App assignment
========================================================
author: Sheetal
date: 12th January 2019
autosize: true

Introduction
========================================================

I have followed the tutoriral on https://deanattali.com/blog/building-shiny-apps-tutorial/ 
to build my first Shiny application.
The data has been taken from OpenData BC
My shiny app is abvailable here https://arkhamknight1235.shinyapps.io/firstshinyapp/


Data
========================================================
  The dataset is based on the products sold in BS Liqour stores. Below is a summary of the dataset


```r
bcl <- read.csv("bcl-data.csv", stringsAsFactors = FALSE)
summary(bcl)
```

```
     Type             Subtype            Country         
 Length:6132        Length:6132        Length:6132       
 Class :character   Class :character   Class :character  
 Mode  :character   Mode  :character   Mode  :character  
                                                         
                                                         
                                                         
                                                         
     Name           Alcohol_Content     Price            Sweetness      
 Length:6132        Min.   : 2.50   Min.   :    1.99   Min.   : 0.0000  
 Class :character   1st Qu.:12.50   1st Qu.:   14.99   1st Qu.: 0.0000  
 Mode  :character   Median :13.50   Median :   24.99   Median : 0.0000  
                    Mean   :17.17   Mean   :  141.49   Mean   : 0.6659  
                    3rd Qu.:14.50   3rd Qu.:   62.99   3rd Qu.: 0.0000  
                    Max.   :75.50   Max.   :30250.00   Max.   :10.0000  
                                    NA's   :1          NA's   :1804     
```

Plot
========================================================
Below is a plot of the price and alcholol

![plot of chunk unnamed-chunk-2](shinyapp-figure/unnamed-chunk-2-1.png)

Thanks
========================================================
Thanks for viewing my simple attempt at Shiny and the presentation, I have definetely learnt a lot on in the process/
