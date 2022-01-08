#GGPLOT - zbudowany na podstawie gramatyki grafiki
#gramatyka - prezentowane dane, obiekty geometryczne, aspekty estetyczne, dostosowanie pozycji, 
#skala, system wspólrzednych, grupy danych
#ggplot porzadkuje komponenty w warstwy
library(ggplot2)
library(tidyr)
library(dplyr)
?midwest

ggplot(midwest) #przekazane na podstawie pozycji ale mo¿na te¿ na podstawie nazwy i napisac name = 
#puste plotno na ktore mozna nakladac kolejne warstwy
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty))
#dodanie warstwy geom - okreslenie rodzaju rysowanego obiektu
# w funkcji geom trzeba podac odwzorowania aspektow estetycznych - aes - jak dane z ramki zostana odwzorowane
#na wizualne aspekty obiektow geometrycznych
#jesli nazwa zmiennej uzywanej w aes jest przypisana do innej zmiennej mozna sie zastanowic nad uzyciem aes_string

#Funkcja do szybkiego tworzenia domylnych wykresów - brak cutomizacji
?qplot
qplot(percollege, percadultpoverty, data = midwest)

#mozna nakladac kilka warstw na siebie. Jesli uzywaja tego samego mappingu to:
ggplot(midwest, mapping = aes(x = percollege, y = percadultpoverty))+
  geom_point()+
  geom_smooth()+
  geom_point(aes(y = percchildbelowpovert))
#atrybuty wprowadzone w ggplot sa uzywane dla wszystkich warstw chyba ze zostaly pozniej zastapione w kolejnych wywolaniach

#odwzorowania estetyczne. Dwa podejscia
#ustawienie jednej wlasciwosci dla wszystkich obiektów. Color poza aes - wszystko w jednej barwie
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty), color = "orange", alpha = 0.5)
#Uzaleznienie koloru od stanu
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = state))

#dostosowanie pozycji - wyznaczanie pozycji roznych komponentow wzgledem siebie
#color - obrys ksztatu, fill - wypelnienie
midwest %>% select(state,popwhite,popblack,popasian,popamerindian,popother) %>% 
  gather(key = race, value = population, -state) %>% 
  ggplot() +
  geom_col(aes(x=state, y = population, fill = race),position = "identity")

#skale
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = state)) +
  scale_x_continuous(limits = range(midwest$percollege)) +
  scale_y_continuous() +
  scale_color_discrete()
#do skali kolorow najczesciej uzywa sie scale_color_brewer
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = state))+
  scale_color_brewer(palette = "Set1")

#system wspolrzednych - organizowanie obiektow geomtrycznych. Z przedrostkiem coord_
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = state)) 
  #coord_cartesian() #domyslny
  #coord_flip() #zmiana osi
  #coord_fixed() #kartezjanski ze stalym formatem obrazu
  #coord_polar() #wykresy kolowe - biegunowy uklad wspolrzednych
  #coord_quickmap() #do map
  
#Fasety
fasety <- midwest %>% mutate(location = if_else(inmetro == 0, "Wies", "Miasto"))
ggplot(fasety) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = location)) +
  facet_wrap(~state)
  #facet_grid(~state)
  #facet_null(~state)
# zapis z tylda z przodu - powstaje formula. Tylda to "funkcja dla"

#ETYKIETY I UWAGI
ggplot(midwest) +
  geom_point(aes(x = percollege, y = percadultpoverty, color = state))+
  labs(title = "Test", x = "Per college", y = "Perc Adult Poverty", color = "Stan")

#dodawanie etykiet bezposrednio na wykres
library(ggrepel)
bieda <- midwest %>% group_by(state) %>% top_n(1, wt = percadultpoverty) %>% unite(county_state, county, state, sep = ", ")
subtitle <- "hrabstwa o najwyzszym wskazniku"
ggplot(fasety, mapping = aes(x = percollege, y = percadultpoverty)) +
  geom_point(aes(color = location), alpha = 0.7) +
  geom_label_repel(data = bieda,
                   mapping = aes(label = county_state),
                   alpha = 0.6) +
  scale_x_continuous(limits = c(0,55))


#tworzenie map

state_shape <- map_data("state")
ggplot(state_shape) + 
  geom_polygon(aes(x = long, y = lat, group = group), color = "white", size = 0.5)

# z funkcja theme()
ggplot(state_shape) + 
  geom_polygon(aes(x = long, y = lat, group = group), color = "white", size = 0.5) +
  theme(axis.line = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        axis.title = element_blank(),
        plot.background = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank())

#wykres punktowy na mapie
miasta <- data.frame(city = c("Seattle","Denver"),
                     lat = c(47.6062,39.7392),
                     long = c(-122.3321,-104.9903))
ggplot(state_shape) + 
  geom_polygon(aes(x = long, y = lat, group = group)) +
  geom_point(data = miasta, aes(x = long, y = lat), color = "green")




# PLOTLY BOKEH
install.packages(c("plotly","rbokeh","leaflet"))
library(ggplot2)
library(plotly)
library(rbokeh)
library(leaflet)

#PLOTLY - DWIE OPCJE. PRZEKAZANIE OBIEKTU GGPLOT DO FUNKCJI GGPLOTLY
flow_plot <- ggplot(iris) + geom_point(aes(x = Sepal.Width, y = Petal.Width, color = Species))
ggplotly(flow_plot)

#Dwa- wykorzystanie interfejsu API plotly poprzez wywolanie jego funkcji
plot_ly(iris,
        x = ~Sepal.Width,
        y = ~Petal.Width, #odwzorowania aspektow estetycznych wyswietlane przy uzyciu wzoru
        color = ~Species,
        type = "scatter",
        mode = "markers")

#dopasowanie wygladu - funkcja layout
plot_ly(iris,
        x = ~Sepal.Width,
        y = ~Petal.Width, #odwzorowania aspektow estetycznych wyswietlane przy uzyciu wzoru
        color = ~Species,
        type = "scatter",
        mode = "markers") %>% 
  layout(title = "Platki (Petal) a Kielichy(Sepal)",
         xaxis= list(title = "Szerokosc",ticksuffix = "cm"),)


#BOKEH
#podobnie jak w ggplot i plotly - dodawanie nowych warstw przy u¿yciu funkcji (POTOKOWO przekazywanych)
figure(iris,
       title = "Wizualka z Bokeh") %>% 
  ly_points(x = Sepal.Width, y = Petal.Width, color = Species) %>% 
  x_axis(label = "Szerokosc Kielicha", format = "%s cm", number_formatter = "printf") #formatowanie podzialki mniej intuicyjne

#LEAFLET
pozycje <- data.frame(label = c("Uni1","Uni2"), latitude = c(46,47), longitude = c(-122,-122))
leaflet(pozycje) %>% 
#najwazniejsza warstwa do dodania to kafelki
addProviderTiles("CartoDB.Positron") %>% 
  setView(lng = -122, lat = 47, zoom = 4) %>% 
  addCircles(lat = ~latitude,
             lng = ~longitude,
             label = ~label,#po najechaniu sie wyswietli tekst
             popup = ~label, #po kliknieciu sie wyswietli tekst
             radius = 3000,
             stroke = TRUE)









