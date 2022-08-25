#mapa BR com distribuicao dos hospitais gerais por estado

library(geobr)
library(ggplot2)
library(sf)
library(dplyr)

#Download spatial data as sf objects
states <- read_state(year=2019)

#Mapa tematico - Distribui?ao de hospitais gerais pelos estados do BR
RESPOSTAS <- c ("RO", "AC", "AM", "RR", "PA", 
                "AP", "TO", "MA", "PI", "CE",
                "RN", "PB", "PE", "AL", "SE", 
                "BA", "MG", "ES", "RJ", "SP", 
                "PR", "SC", "RS", "MS", "MT", 
                "GO", "DF",
                3,   NA,   19,   1,  11,
                3,   3,   10,   8,  30,
                13,   3,   42,   9,  7,  
                137,   141,  20,  452,  440,
                34,   31,   53,  5,   9,
                16,   36)
RESPOSTAS <- matrix(RESPOSTAS, 27, 2,
              dimnames = list(c(),
                              c("Estado","RESPOSTAS")))
RESPOSTAS

class(RESPOSTAS) 
RESPOSTAS <- as.data.frame(RESPOSTAS)
RESPOSTAS$RESPOSTAS <- as.character(RESPOSTAS$RESPOSTAS)
RESPOSTAS$RESPOSTAS <- as.numeric(RESPOSTAS$RESPOSTAS)

# join the databases
states4 <- dplyr::left_join(states, RESPOSTAS, by = c("abbrev_state" = "Estado"))

# Remove plot axis
no_axis <- theme(axis.title=element_blank(),
                 axis.text=element_blank(),
                 axis.ticks=element_blank())

##plot map
library(RColorBrewer)
estados <- ggplot() +
  geom_sf(data=states4, aes(fill=RESPOSTAS), color= NA, size=.15) +
  labs(subtitle="Distribuiçao das respostas por estados do BR", size=8) +
  scale_fill_distiller(palette = "YlOrRd", direction = 1, name="RESPOSTAS", limits = c(min(states4$RESPOSTAS), max (states4$RESPOSTAS))) +
  theme_bw() +
  no_axis

estados

