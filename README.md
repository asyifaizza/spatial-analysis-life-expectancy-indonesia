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
