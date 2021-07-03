
[#Read textfile instead](https://docs.google.com/document/d/1WrrvFsWA7uIFNEHje52xQ6dRn_byJ0B1QBm3uoUevFc/edit?usp=sharing)


**<span style="text-decoration:underline;">Supervised classification of Land use/ Land cover map of Nepal 2020</span>**

**Github code link:  [https://github.com/Aaditya-327/LULC-icimod](https://github.com/Aaditya-327/LULC-icimod)**

**Download link:**



* **[LULC2020](https://github.com/Aaditya-327/LULC-icimod/blob/main/LULC2020.zip)**
* **[LULC2020_properClass](https://github.com/Aaditya-327/LULC-icimod/blob/main/LULC2020_properClass.zip)**
* **[QGIS styling file qml](https://github.com/Aaditya-327/LULC-icimod/blob/main/ICIMOD_colorCoding.qml)**

**Background**

**	**Since I've first been involved in GIS works, I have always used ICIMOD LULC data for Koshi basin and for Nepal as a whole, because it has good classification measures and always met my needs. But there is a slight problem that last LULC map was published in 2010. They have yet to publish any LULC map for the 2020s. Last week, Esri published a [land use land cover](https://www.arcgis.com/home/item.html?id=d6642f8a4f6d4685a24ae2dc0c73d4ac) map of the entire world at 10m resolution. Even if the resolution was great, the spatial information in the increased pixel numbers was unsatisfactory. It created a buffer around residential areas and was having problems differentiating between river banks and residential areas. 

So, I planned to make a LULC map of my own, taking reference to the 30m resolution 2010 LULC map of ICIMOD with the following categories.


                    **       {1: "Closed Forests",
                              2: "Open Forests",
                              3: "Bare slopes",
                              4: "Agriculture"
                              5: "Sandy Region",
                              6: "Water",
                              7: "Ice cover",
                              8: "Settlement"}

**Softwares used:**



* Google earth engine
* Python : sklearn for MultipleLogisticRegression and Random forest classifier
* Excel for data management
* QGIS for visualization

**Procedure**



1. **Data preparation**

Initially I planned to do it in QGIS or SNAP but the databases were massive and I would have to spend days just downloading and processing data, so I went forward with Google earth engine and GEEMAP ( a python library ) for the work.

Initially a logistic model had to be made, for classifying data based on the pixels of bands. So  “LANDSAT/LE07/C01/T1_SR” Landsat 7 images were downloaded which were available in 2010. The problem with Landsat 7 is its SLC grooves, which creates nodata segments in the middle of mosaics. Although no remedy to solve this problem was found at the time, it had to be used, due to lack of alternatives. So the images were loaded based on the time range of 2010-03-01 to 2010-09-30, which is non-winter months, and the snow cover was also minimum, so it was used, as recommended by Surface reflectance dataset. But the images with &lt;10% cloud cover were not available, so the date had to be extended to include some winter months. The image collection was then mosaic-ed to a single Image and was clipped to Nepal's new boundary. The image was a Landsat 7 which had following properties.

Landsat 7 which originally has 7 bands:



* Band 1 Visible (0.45 - 0.52 µm) 30 m
* Band 2 Visible (0.52 - 0.60 µm) 30 m
* Band 3 Visible (0.63 - 0.69 µm) 30 m
* Band 4 Near-Infrared (0.77 - 0.90 µm) 30 m
* Band 5 Short-wave Infrared (1.55 - 1.75 µm) 30 m
* Band 6 Thermal (10.40 - 12.50 µm) 60 m Low Gain / High Gain
* Band 7 Mid-Infrared (2.08 - 2.35 µm) 30 m

With an expectation of better results with processed bands like NDVI, NDWI, MNDWI, NDBI and elevation profile SRTM 30 was also added to the original image. These features would act as independent variables for detection of LULC. The Land cover map of ICIMOD 2010 was kept as a dependent variable for model training.

<span style="text-decoration:underline;">Processed Bands:</span>


    NDVI = (Band 4 – Band 3) / (Band 4 + Band 3)

    NDWI = (Band 4 – Band 5) / (Band 4 + Band 5)

    MNDWI = (Band 2 – Band 5) / (Band 2 + Band 5)

    NDBI = (Band 5 – Band 4) / (Band 5 + Band 4)
    
    **Link to code**
    
    [https://github.com/Aaditya-327/LULC-icimod/blob/main/Resample.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Resample.ipynb)



2. **Data extraction**

100,000 random points were generated within Nepal's vector layer. These layers were used to extract data from all bands at 100,000 locations within Nepal in a csv excel file. Since some points may have fallen within the Limpiyadhura area of western Nepal, where LULC data is not available or in SLC error regions within Nepal where bands’ information is not available, all NODATA rows were identified and removed. After this, about 98000 data points were left, with 12 independent X variables and 1 dependent discrete Y variable (classification).


    **Link to code**


    [https://github.com/Aaditya-327/LULC-icimod/blob/main/Resample.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Resample.ipynb)



3. **Data analysis and LULC preparation**

    **Link to code**


    [https://github.com/Aaditya-327/LULC-icimod/blob/main/Train%20models%20and%20save%20CSV.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Train%20models%20and%20save%20CSV.ipynb)


**<span style="text-decoration:underline;">LogisticRegression:</span>**

Multivariate logistic regression was tried to be performed in excel using XRealStats add-in, but due to long processing time, programming had to be used. 

X= ['ID', 'B1', 'B2', 'B3', 'B4', 'B5', 'B6', 'B7', 'NDWI', 'NDVI', 'MNDWI', 'NDBI', 'elevation']

Y = [‘LULC’]

All 98000 data was analysed using the “saga” method and to get a result fit score of 0.7283554128194835. 

72.8% of the score was not that good, so in search of an alternative method, Random forest classifier was used.

**<span style="text-decoration:underline;">Random forest classification:</span>**

This was also performed in Python using sklearn library. The resulting accuracy for all 98,000 data was an astounding 0.9412217315669744 for just 10 trees.

**94.12% **was more than enough for this work. 

As all things don't go as expected, Google earth engine refused to classify using large forests string file in their server so after being limited by the processing capacity, the analysis data rows was reduced from 98000 to 4200, for the tree to be accepted from google. The accuracy of forests drop down to 0.7479258664525625.

**Link to code:**

[https://github.com/Aaditya-327/LULC-icimod/blob/main/Try%20saved%20models%20LULC.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Try%20saved%20models%20LULC.ipynb)

So, a classification image was produced named **LULC2020.tif**

This image was classified, but there was a serious problem that this LULC map did not have any residential areas. The classifier confused residential areas to sandy areas due to some reasons.

After a brief check it was detected that LULC did not have enough data points of residential areas for classification. Since random 4200 data points were selected, only 20 of them were residential areas. 



**<span style="text-decoration:underline;">Retry of classification methods after rearrangement of input rows:</span>**

**Link to code:**

[https://github.com/Aaditya-327/LULC-icimod/blob/main/Train%20models%20and%20save%20CSV%20equal%20class%204200.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Train%20models%20and%20save%20CSV%20equal%20class%204200.ipynb)

The data points were then manually added randomly into the classifier such that they matched following number of data set for each classification:



Same methods were used for classification again and following results were obtained:

**<span style="text-decoration:underline;">LogisticRegression:</span>**

Number: 4200 (manually chosen)

Accuracy: **0.7283888665863776**

**<span style="text-decoration:underline;">Random forest classification:</span>**

Number: 4200 (manually chosen)

Accuracy: **0.7430081627191222** (same as before)

**Link to code:**

[https://github.com/Aaditya-327/LULC-icimod/blob/main/Try%20saved%20models%20LULC%20equal%20class%204200.ipynb](https://github.com/Aaditya-327/LULC-icimod/blob/main/Try%20saved%20models%20LULC%20equal%20class%204200.ipynb)

A LULC map was prepared for this as well named **“LULC2020_properClass.tif”. **Same error of little to none residential area was observed here as well.



4. **Limitations of my method:**
* Landsat 7 SLC error
* Landsat 7 surface reflectance non-winter images recommendation not followed
* Only 4200 sampling points were used due to lack of proper processing power **(Otherwise there was 94% accuracy if all data points were used.)**
