# Spatial Statistics Analysis of Life Expectancy in Indonesia

This project applies spatial statistics and spatial regression methods to analyze the distribution of life expectancy across provinces in Indonesia.

The analysis focuses on **Life Expectancy at Birth (Umur Harapan Hidup Saat Lahir / UHH)** and examines its relationship with **Per Capita Expenditure** and **Population Size**, while considering spatial dependence between provinces.

## Authors

- **Asyifa Izzatil Isma**
- **M. Aufa Mumtaza Ibadillah**

Bina Nusantara University  
School of Computer Science

---

## Overview

Spatial analysis is used to investigate whether observations from neighboring regions are spatially related.

In this project, the main variable of interest is:

- **Y**: Life Expectancy at Birth (UHH)

The explanatory variables are:

- **X1**: Per Capita Expenditure (Thousand Rupiah/Person/Year)
- **X2**: Population (Thousand People)

The analysis examines the spatial distribution of UHH across 38 provinces in Indonesia and evaluates whether neighboring provinces tend to have similar UHH values.

---

## Dataset

The dataset contains observations from **38 provinces in Indonesia**.

| Variable | Description |
|---|---|
| `Provinsi` | Province name |
| `Y` | Life Expectancy at Birth (UHH) |
| `X1` | Per Capita Expenditure (Thousand Rupiah/Person/Year) |
| `X2` | Population (Thousand People) |
| `latitude` | Latitude coordinate |
| `longitude` | Longitude coordinate |

The geographical coordinates are used to construct spatial relationships between provinces.

---

## Methodology

The analysis consists of several stages:

```text
Data Preparation
       ↓
Spatial Distribution Analysis
       ↓
Spatial Weight Matrix Construction
       ↓
Global Moran's I
       ↓
Local Moran's I (LISA)
       ↓
OLS Regression
       ↓
OLS Assumption Tests
       ↓
Lagrange Multiplier Tests
       ↓
Spatial Regression Models
       ↓
Model Comparison using AIC
```

---

## 1. Spatial Distribution of Life Expectancy

The geographical distribution of Life Expectancy at Birth (UHH) was visualized across the 38 provinces of Indonesia.

The visualization shows differences in UHH between provinces. Provinces in Java generally show relatively higher UHH values, while several provinces in eastern Indonesia, particularly in Papua and surrounding regions, show relatively lower UHH values.

The visualization also provides an initial indication that provinces with similar UHH values tend to be geographically close to one another.

This initial spatial pattern motivates further investigation using spatial autocorrelation analysis.

---

## 2. Spatial Weight Matrix Construction

A spatial weight matrix was constructed to represent the geographical relationships between provinces.

The spatial relationships were defined using the **K-Nearest Neighbors (KNN)** approach based on the geographical coordinates of each province.

The spatial weight matrix was constructed using:

- Number of nearest neighbors (`k`) = 4
- Number of provinces = 38
- Total non-zero links = 152
- Weight style = Row-standardized (`W`)

The resulting spatial weights define which provinces are considered spatially related based on geographical proximity.

This spatial weight matrix is subsequently used in the Global Moran's I, Local Moran's I, Lagrange Multiplier tests, and spatial regression models.

---

## 3. Global Moran's I

Global Moran's I was used to determine whether UHH values exhibit spatial autocorrelation across Indonesian provinces.

The results were:

| Statistic | Value |
|---|---:|
| Moran's I | 0.5704 |
| p-value | < 0.001 |

The Moran's I statistic is positive and statistically significant.

This indicates the presence of **positive spatial autocorrelation** in UHH. In other words, provinces with relatively similar UHH values tend to be located near one another rather than being distributed randomly across Indonesia.

The result provides statistical evidence that spatial dependence should be considered when analyzing provincial-level UHH.

---

## 4. Local Moran's I (LISA)

While Global Moran's I provides an overall measure of spatial autocorrelation, **Local Moran's I**, also known as **Local Indicators of Spatial Association (LISA)**, was used to identify specific provinces that form significant spatial clusters.

The analysis identified significant High-High and Low-Low clusters.

### High-High Clusters

The significant High-High cluster consists of:

- DKI Jakarta
- Jawa Barat
- Jawa Tengah
- DI Yogyakarta
- Jawa Timur

These provinces represent areas with relatively high UHH values surrounded by provinces with similarly high UHH values.

### Low-Low Clusters

The significant Low-Low cluster consists of:

- Maluku
- Papua Barat
- Papua Barat Daya
- Papua
- Papua Selatan
- Papua Tengah
- Papua Pegunungan

These provinces represent areas with relatively low UHH values surrounded by provinces with similarly low UHH values.

The LISA analysis therefore provides more detailed information about the geographical location of significant UHH clusters.

---

## 5. Ordinary Least Squares (OLS)

An **Ordinary Least Squares (OLS)** regression model was first estimated to examine the relationship between UHH and the explanatory variables.

The model specification was:

```text
Y = β₀ + β₁X₁ + β₂X₂ + ε
```

where:

- `Y` = Life Expectancy at Birth
- `X1` = Per Capita Expenditure
- `X2` = Population
- `ε` = Error term

The estimated OLS model achieved the following results:

| Metric | Value |
|---|---:|
| R² | 0.6002 |
| Adjusted R² | 0.5774 |
| F-statistic | 26.28 |
| F-test p-value | < 0.001 |

The estimated coefficients were:

| Variable | Coefficient | p-value |
|---|---:|---:|
| Intercept | 62.04 | < 0.001 |
| X1 | 0.0006850 | < 0.001 |
| X2 | 0.0000721 | 0.00715 |

The coefficients for both X1 and X2 are positive and statistically significant in the OLS model.

This indicates positive estimated associations between per capita expenditure, population, and life expectancy at birth.

---

## 6. OLS Assumption Tests

Several diagnostic tests were performed to evaluate the OLS model.

### Shapiro-Wilk Test

The Shapiro-Wilk test was used to assess the normality of the OLS residuals.

The result was:

| Statistic | Value |
|---|---:|
| W | 0.9739 |
| p-value | 0.5062 |

The p-value is greater than 0.05, indicating no evidence against the normality assumption of the residuals.

### Breusch-Pagan Test

The Breusch-Pagan test was performed to assess heteroskedasticity.

The result was:

| Statistic | Value |
|---|---:|
| BP | 2.6905 |
| p-value | 0.2605 |

The p-value is greater than 0.05, indicating no evidence of heteroskedasticity in the OLS residuals.

### Durbin-Watson Test

The Durbin-Watson test was used to assess residual autocorrelation.

The result was:

| Statistic | Value |
|---|---:|
| DW | 1.4143 |
| p-value | 0.02228 |

The p-value is below 0.05, indicating evidence of residual autocorrelation.

This result suggests that the OLS model may not fully account for dependence among observations and motivates further investigation using spatial regression models.

---

## 7. Lagrange Multiplier Tests

Lagrange Multiplier (LM) diagnostics were conducted to investigate the presence and type of spatial dependence in the regression model.

The tests considered spatial lag and spatial error dependence.

The main results were:

| Test | p-value |
|---|---:|
| Robust Spatial Lag | 0.1453 |
| Robust Spatial Error | 0.8951 |
| Adjusted Robust Spatial Error | 0.1071 |
| Adjusted Robust Spatial Lag | 0.0302 |

The adjusted robust spatial lag test was statistically significant at the 5% significance level.

This provides evidence supporting the consideration of a spatial lag specification in the subsequent spatial regression analysis.

---

## 8. Spatial Regression Models

To account for spatial dependence, three spatial regression models were estimated:

1. Spatial Autoregressive Model (SAR)
2. Spatial Error Model (SEM)
3. Spatial Autoregressive Moving Average Model (SARMA)

### 8.1 Spatial Autoregressive Model (SAR)

The SAR model incorporates spatial dependence through a spatially lagged dependent variable.

The main results were:

| Parameter | Estimate | p-value |
|---|---:|---:|
| X1 | 0.0005607 | < 0.001 |
| X2 | 0.0000489 | 0.0651 |
| Rho | 0.2679 | 0.0802 |

The SAR model has an AIC of:

```text
152.6051
```

The coefficient of X1 remains statistically significant, while X2 is not statistically significant at the 5% significance level.

The spatial lag parameter rho is positive, although its Wald test p-value is above 0.05.

---

### 8.2 Spatial Error Model (SEM)

The SEM model accounts for spatial dependence through the error structure.

The main results were:

| Parameter | Estimate | p-value |
|---|---:|---:|
| X1 | 0.00070198 | < 0.001 |
| X2 | 0.00007213 | 0.00248 |
| Lambda | -0.06287 | 0.8020 |

The SEM model has an AIC of:

```text
154.9697
```

The lambda parameter is not statistically significant, indicating that there is no strong evidence of spatial dependence in the error component of the SEM model.

---

### 8.3 SARMA Model

The SARMA model incorporates both spatial lag and spatial error components.

The main results were:

| Parameter | Estimate | p-value |
|---|---:|---:|
| X1 | 0.0005580 | < 0.001 |
| X2 | 0.0000347 | 0.1872 |
| Rho | 0.3769 | 0.0487 |
| Lambda | -0.4807 | 0.2213 |

The SARMA model has an AIC of:

```text
152.8826
```

The spatial lag parameter rho is statistically significant, while the spatial error parameter lambda is not statistically significant.

---

## 9. Model Comparison

The OLS, SAR, SEM, and SARMA models were compared using the **Akaike Information Criterion (AIC)**.

| Model | AIC |
|---|---:|
| SAR | 152.6051 |
| SARMA | 152.8826 |
| OLS | 153.0036 |
| SEM | 154.9697 |

A lower AIC indicates a better trade-off between model fit and model complexity among the evaluated models.

Based on the AIC comparison, the SAR model has the lowest AIC value among the four models.

Therefore, the SAR model was selected as the final model for describing the relationship between UHH, per capita expenditure, population, and spatial dependence across Indonesian provinces.

---

## Key Findings

The main findings from the analysis are:

1. Life expectancy varies across the 38 provinces of Indonesia.
2. The spatial distribution of UHH shows noticeable geographical patterns.
3. Global Moran's I indicates significant positive spatial autocorrelation in UHH.
4. Significant High-High clusters are concentrated in several provinces on Java.
5. Significant Low-Low clusters are identified in several provinces in Maluku and Papua.
6. Per capita expenditure and population have positive estimated associations with UHH in the OLS model.
7. OLS diagnostics provide evidence of residual autocorrelation.
8. Spatial diagnostic testing supports consideration of a spatial lag specification.
9. SAR, SEM, and SARMA models were estimated to account for spatial dependence.
10. The SAR model has the lowest AIC among the evaluated models.

---

## Tools & Libraries

The analysis was conducted using R.

### Libraries

- `readxl`
- `spdep`
- `sf`
- `ggplot2`
- `maps`
- `ggrepel`
- `lmtest`
- `spatialreg`

---

## Repository Structure

```text
spatial-statistics-indonesia-life-expectancy/
│
├── code.Rmd
├── code.R
├── data_spatial.xlsx
└── README.md
```

---

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/your-username/spatial-statistics-indonesia-life-expectancy.git
cd spatial-statistics-indonesia-life-expectancy
```

### 2. Install the required R packages

Open R or RStudio and run:

```r
install.packages(c(
  "readxl",
  "spdep",
  "sf",
  "ggplot2",
  "maps",
  "ggrepel",
  "lmtest",
  "spatialreg"
))
```

### 3. Open the project

The main analysis output is available in:

```text
code.R
```

The dataset used in the analysis is:

```text
data_spatial.xlsx
```

---

## Conclusion

This project demonstrates the application of spatial statistics and spatial regression methods to analyze life expectancy across Indonesian provinces.

The analysis combines spatial visualization, spatial weight matrix construction, Global Moran's I, Local Moran's I (LISA), OLS regression, OLS diagnostic tests, Lagrange Multiplier tests, and spatial regression models.

The results indicate that UHH exhibits significant positive spatial autocorrelation across Indonesian provinces. The LISA analysis further identifies High-High clusters mainly in Java and Low-Low clusters across several provinces in Maluku and Papua.

The regression analysis shows positive estimated associations between UHH and both per capita expenditure and population in the OLS model. However, the presence of residual dependence motivates the use of spatial regression models.

Among the evaluated models, the SAR model produces the lowest AIC and is therefore selected as the final model in this analysis.
