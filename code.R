# Insert Library
library(readxl)
library(spdep)
library(ggplot2)
library(maps)
library(ggrepel)
set.seed(123)

# Read Data
data <- read_excel("data_spatial.xlsx")
head(data)

world <- map_data("world")

ggplot() +
  geom_polygon(
    data = subset(world, region == "Indonesia"),
    aes(
      x = long,
      y = lat,
      group = group
    ),
    fill = "grey95",
    color = "grey60"
  ) +
  geom_point(
    data = data,
    aes(
      x = longitude,
      y = latitude,
      color = Y,
      size = Y
    ),
    alpha = 0.8
  ) +
  scale_color_gradient(
    low = "skyblue",
    high = "darkred"
  ) +
  labs(
    title = "Sebaran Umur Harapan Hidup Indonesia",
    color = "UHH",
    size = "UHH"
  ) +
  geom_text_repel(
    data = data,
    aes(
      longitude,
      latitude,
      label = Provinsi
    ),
    size = 3
  ) +
  theme_minimal()

# Koordinat
coords <- cbind(
  data$longitude,
  data$latitude
)
coords <- jitter(coords)

# K-Nearest Neighbor
knn <- knearneigh(coords, k = 4)

# Neighbor list
nb <- knn2nb(knn)
nb

# Membentuk Spatial Weight Matrix
listw <- nb2listw(nb, style="W")


## Global Moran's I pada Y

### H0 : tidak ada dependency spatial pada variable respon
### H1 : Ada dependecy spatial yang positif pada variable respon

global_moran <- moran.test(
  data$Y,
  listw
)
global_moran

# Local Moran's I (LISA) pada Y

## H0 : tidak ada dependency spatial pada variable respon
## H1 : Ada dependecy spatial yang positif pada variable respon

local_moran <- localmoran(
  data$Y,
  listw
)
local_moran

# Jadikan dataframe
hasil_lisa <- data.frame(
  Provinsi = data$Provinsi,
  P_Value = local_moran[,5],
  Cluster = attr(local_moran, "quadr")[,3]
)

# Ambil yang signifikan saja
dependensi_spasial <- subset(hasil_lisa, P_Value < 0.05)

dependensi_spasial

hasil_lisa$LISA <- "Not Significant"

hasil_lisa$LISA[
  hasil_lisa$P_Value < 0.05
] <- as.character(
  hasil_lisa$Cluster[
    hasil_lisa$P_Value < 0.05
  ]
)

map_lisa <- merge(
  data,
  hasil_lisa,
  by = "Provinsi"
)

ggplot() +
  geom_polygon(
    data = subset(world, region == "Indonesia"),
    aes(
      long,
      lat,
      group = group
    ),
    fill = "grey95",
    color = "grey60"
  ) +
  geom_point(
    data = map_lisa,
    aes(
      longitude,
      latitude,
      color = LISA
    ),
    size = 4
  ) +
  geom_text_repel(
    data = map_lisa,
    aes(
      longitude,
      latitude,
      label = Provinsi
    ),
    size = 3
  ) +
  labs(
    title = "LISA Cluster Map"
  ) +
  theme_minimal()

# Bikin Model OLS
model_ols <- lm(Y ~ X1 + X2, data = data)
summary(model_ols)

# Uji Asumsi
## 1. Normalitas Residual

### H0 : Residual Berdistribusi Normal
### H1 : Residual Tidak Berdistribusi Normal

shapiro.test(residuals(model_ols))


## 2. Homoskedastisitas

### H0 : Tidak Terjadi Heteroskedastisitas
### H1 : Terjadi Heteroskedastisitas

library(lmtest)
bptest(model_ols)

## 3. Autokorelasi

### H0: Tidak Terdapat Autokorelasi residual
### H1: Terdapat Autokorelasi residual

dwtest(model_ols)


# LM Test pada Regresi Spatial
rs_test <- lm.RStests(
  model_ols,
  listw,
  test = c("RSlag", "RSerr", "adjRSerr", "adjRSlag")
)
rs_test

rs_df <- data.frame(
  Test = names(rs_test),
  Statistic = sapply(rs_test, function(x) x$statistic),
  P_Value = sapply(rs_test, function(x) x$p.value)
)

rs_df

# Model SAR
library(spatialreg)
sar <- lagsarlm(
  Y ~ X1 + X2,
  data = data,
  listw = listw
)

summary(sar)

# Model SEM
sem <- errorsarlm(
  Y ~ X1 + X2,
  data = data,
  listw = listw
)

summary(sem)

# Model SARMA
library(spatialreg)

sarma <- sacsarlm(
  Y ~ X1 + X2,
  data = data,
  listw = listw
)

summary(sarma)

# Comparison Model
comparison <- data.frame(
  Model = c("OLS", "SAR", "SEM", "SARMA"),
  AIC = c(
    AIC(model_ols),
    AIC(sar),
    AIC(sem),
    AIC(sarma)
  )
)

comparison <- comparison[order(comparison$AIC), ]
comparison
















