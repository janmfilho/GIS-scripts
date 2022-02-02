# Set all code chunks as echo = T

knitr::opts_chunk$set(echo = TRUE)

# Clear workspace

rm(list = ls()) 

# Load packages for spatial analysis

library(sp)
library(rgdal)
library(rgeos)
library(ggmap)                 
library(leaflet)
library(spatstat)
library(gstat)
library(maptools)
library(ggplot2)
library(sf)
library(dplyr)

# 1. Load shapefiles

Shapefiles must be combined with other type of files in its folder. 

# Let´s set the working directory

setwd("C:/Users/jose_/OneDrive/Área de Trabalho/Spatial Test")

# Load Municipality shapefiles

br_mun <- read_sf('./shapefiles','br_municipios')

# Load Municipality shapefiles

br_est <- read_sf('./shapefiles','br_estados')

# 2. Plot shapefiles

# Plot Municipality shapefiles

plot(br_mun)

head(br_mun)

# PLot State shapefiles

plot(br_est)

head(br_est)

# 3. Setting our Classification

# Set population density classes

br_mun$DensClass <- cut(br_mun$DensPop,breaks=c(0,5,50,500,5000,Inf),
                        labels=c('< 5','5-50','50-500','500-5.000','> 5.000'))

# Plot Municipality graph

ggplot()+
  geom_sf(data=br_mun)

# Plot Municipality graph with classification filter

ggplot()+
  geom_sf(aes(fill=DensClass), data=br_mun)

# Removing borders of municipalities and include state borders

ggplot()+
  geom_sf(aes(fill=DensClass), color = 'transparent', data=br_mun)+
  geom_sf(fill= 'transparent', color = 'white', data=br_est)

# Change palette of colors and labels

ggplot()+
  geom_sf(aes(fill=DensClass), color = 'transparent', data=br_mun)+
  geom_sf(fill= 'transparent', color = 'white', data=br_est)+
  scale_fill_viridis_d(name='Inhab/km²')+
  labs(title="Brazil's demographics",
       subtitle='Population density',
       caption=c('Source: IBGE - Censo demográfico, 2010'))

# Setting a clean theme and legend position to the bottom

ggplot()+
  geom_sf(aes(fill=DensClass), color = 'transparent', data=br_mun)+
  geom_sf(fill= 'transparent', color = 'white', data=br_est)+
  scale_fill_viridis_d(name='Inhab/km²')+
  labs(title="Brazil's demographics",
       subtitle='Population density',
       caption=c('Source: IBGE - Censo demográfico, 2010'))+
  theme_void()+
  theme(title=element_text(face='bold'),
        legend.position = 'bottom')

# End
