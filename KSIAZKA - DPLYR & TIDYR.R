
# dplyr -------------------------------------------------------------------

#WLASCIWOSCI
#Niestandardowe przetwarzanie - nazwy kolumn bez cudzyslowow
#Dplyr usuwa nazwy wierszy z ramki danych aby je zapisac trzeba je przypisac do zmiennej: mutate(zbior,nowakolumna = rownames(zbior))

library(dplyr)
library(pscl)
#dplyr,tidyr i ggplot sa elementami tidyverse. wystarczy zainstalowac to ostanie.

#bedziemy analizowac zbior presidental elections - pakiet pscl

pscl::presidentialElections
#south - czy stan nalezal do konfederacji w czasie wojny secesyjnej

#WYBIERANIE - SELECT
glosy <- select(presidentialElections,demVote,year)
plot(glosy)
#inny zapis - to samo zwraca
select(presidentialElections,state:year)
select(presidentialElections,-south)
#zwracana wartosc jest ramka danych - aby wyciagnac konkretne kolumny trzeba uzyc PULL

#FILTROWANIE - FILTER
Kolorado_glosy <- filter(presidentialElections,state == "Colorado", year == 2008)

#DODAWANIE KOLUMNY - MUTATE
presidentialElections <- mutate(presidentialElections,
                                other_parties_vote = 100 - demVote,
                                abs_diff = demVote - other_parties_vote)

#SORTOWANIE - ARRANGE
presidentialElections <- arrange(presidentialElections,-year,demVote)

#AGREGACJA - PODSUMOWYWANIE
agregat <- summarise(presidentialElections,
                     mean_dem = mean(demVote),
                     mean_rep = mean(other_parties_vote))
agregat %>% pull(mean_dem)
#mozna tworzyc wlasne funkcje agregujace
far_from_50 <- function(wektor){
  how_far_from_50 <- wektor-50
  wektor[abs(how_far_from_50)==max(abs(how_far_from_50))]
}

summarise(presidentialElections,
          biggest_diff = far_from_50(demVote))


# SEKWENCJE - OPERATOR POTOKU ---------------------------------------------

#1
stan_2008 <- filter(presidentialElections,year == 2008)
dem_2008 <- filter(stan_2008,demVote == max(demVote))
state <- select(dem_2008,state)

#2 - zmienne anonimowe
state2 <- select(filter(filter(presidentialElections,year == 2008),demVote == max(demVote)),state)

#3 - potok. Wynik jednej funkcji uzywany jako argument kolejnej funkcji
#pochodzi z pakietu magittr - zaleznosc z pakietu dplyr
state3 <- filter(presidentialElections,year == 2008) %>% 
  filter(demVote == max(demVote)) %>% 
  select(state)


# GRUPOWANIE --------------------------------------------------------------

grouped_data <- group_by(presidentialElections,state)
#zwraca krotke - specjalny rodzaj data frame,sledzi podzbiory w ramach jednej zmiennej
state_voting <- presidentialElections %>% 
  group_by(state) %>% 
  summarise(srednia_demokracji = mean(demVote),
            srednia_republikanie = mean(other_parties_vote))


# PRAKTYCZNY PRZYK£AD -----------------------------------------------------

install.packages("nycflights13")
library(nycflights13)

?flights
dim(flights)
colnames(flights)
View(flights)

#Ktore linie maja najwieksza liczbe opoznioncyh lotow
Opoznienia <- flights %>% 
  filter(dep_delay > 0) %>% 
  group_by(carrier) %>% 
  summarise(Liczba_opoznien = n()) %>% 
  filter(Liczba_opoznien == max(Liczba_opoznien)) %>% 
  select(carrier) %>% 
  left_join(airlines,by = "carrier")

airlines

#Ktore lotnisko cechuje sie srednio najwczesniejszymi przylotami wzgledem planowanego czasu?

flights
najwczesniej <- flights %>% 
  group_by(dest) %>% 
  summarise(srednie_opoznienie = mean(arr_delay,na.rm = TRUE)) %>% 
  filter(srednie_opoznienie == min(srednie_opoznienie,na.rm = TRUE)) %>% 
  select(dest, srednie_opoznienie) %>% 
  left_join(airports,by = c("dest" = "faa")) %>% 
  select(name, srednie_opoznienie)

airports

#W ktorym miesiacu loty maja najwieksze opoznienia

miesiac <- flights %>% 
  group_by(month) %>% 
  summarise(srednie_op = mean(arr_delay,na.rm = TRUE)) %>% 
  filter(srednie_op == max(srednie_op)) %>% 
  select(month)

miesiac2 <- flights %>% 
  group_by(month) %>% 
  summarise(srednie_op = mean(arr_delay,na.rm = TRUE)) %>% 
  select(srednie_op) %>% 
  mutate(month = month.name)

library(ggplot2)
miesiac2 %>% ggplot() +
  geom_point(aes(x = srednie_op, y = month), color = "green", size = 4, alpha = 0.5) +
  geom_vline(xintercept = 0) +
  xlim(c(-18,18)) +
  scale_y_discrete(limits = rev(miesiac2$month)) +
  labs(title = "Opoznienie a miesiac")


# TIDYR -------------------------------------------------------------------

library(tidyr)
?gather
#zlaczanie i rozdzielanie kolumn
?unit
?separate


























