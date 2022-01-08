library(dplyr)
#KSIAZKOWE PRZYKLADY
#rodzaje danych
Integer <- 10L
Zespolony <- 10i
 
#install - wczytanie niezbdnego kodu pakietu do R - pojawia si wtedy w bibliotece
#library - wywolanie skryptu dla bieÅ¼acej sesji R
#wskazanie sciezki gdzie sa paczki przechowywane
.libPaths()



# SKÅADNIA FUNKCJI --------------------------------------------------------

#wg tidyverse powinna byÄ‡ notacja snake_case z uÅ¼yciem czasownikÃ³w

make_name <- function(name,surname){
  
  full_name <- paste(name,surname) %>% toupper()
  full_name
  
}

Moje_Imie <- make_name('Wojtek','Gie')
Moje_Imie


# INSTRUKCJA WARUNKOWA ----------------------------------------------------

Temp <- function (temp){
  if (temp > 120){
    print("Goraco")
  } else if (temp > 50) {
    print("Cieplo")
  } else if (temp > 15){
    print("umiarkowanie")
  } else {
    print("Zimno")
  }
}
Temp(51)

# WEKTORY -----------------------------------------------------------------

#ZASADY !!
#PONOWNE U¯YWANIE ELEMENTÓW W OPERACJACH
#PRAWIE WSZYSTKO W R JEST WEKTOREM
a <- 1:70
a
#PONOWNE U¯YWANIE ELEMENTOW
c <- c(1:2)
d <- c(1:7)
c+d #Jesli jeden wektor nie jest wielokrotnoscia drugiego to wyswietli komunikat ostrzegawczy ale nie przerwie dzialania akcji
c-d

#R zapisuje wszytskie wartosci liczbowe/logiczne/tekstowe jako wektory (nawet pojedyncze wartosci skalarne)
is.vector(18)
is.vector(FALSE)
is.vector(7)
#Dlatego te¿ w konsoli zawsze wyswietla [1] - oznacza to ¿e wyswietla wektor poczawszy od elementu 1
#Jako ze skalary sa wektorami (i dzialaja na nich funkcje) to te same funkcje dzialaja takze i na wektorach
#GDY WYWOLYWANA JEST FUNKCJA DLA WEKTORA, URUCHAMIANA ONA JEST DLA KAZDEGO ELEMENTU TEGO WEKTORA
#OGRANICZA TO KONIECZNOSC STOSOWANIA PETLI - KAZDY ELEMENT ZBIORU NIE MUSI BYC BEZPOSREDNIO POROWNYWANY (GDYZ ZACHODZI WEKTORYZACJA)
e <- a[71] #NA
f <- a[-2] #WSZYSTKIE ELEMENTY POZA DRUGIM ZWRACA
#DO WYBORU ELEMENTÓW WEKTORA MOZNA TAKZE UZYC WEKTORA WARTOSCI LOGICZNYCH
a[length(a) + 1] <- length(a) + 1 #dodanie nowego elementu do wektora
a[80] <- 80 #w przerwie miedzy elementami wrzucone bea 'na'
a <- c(a,81) #Inny sposob na dodanie ostatniego elementu
a <- c(0,a)
a[a > 79 & !(is.na(a))] <- 1000


# LISTY -------------------------------------------------------------------

#Pozwalaja przechowywac dane roznych typow
#POJEDYNCZY NAWIAS KWADRATOWY ZWRACA LISTE, PODWOJNY NAWIAS KWADRATOWY ZWRACA ELEMENT LISTY

person <- list(imie = "Ada", job = "programista",salary = 1000, in_union=FALSE,favorites = list(music= "pop" ,food = "pizza"))
names(person)
person
#po wyswietleniu zmiennej wszystkie etykiety poprzedzone sa symbolem dolara
#wyciaganie elementow z listy
person$favorites
person$favorites$music
person[[1]]
person[[2]] #wybranie konkretnego elementu
person[1] #wybieranie etykiet
person$favorites[1]
person$favorites[[1]]

#Modyfikowanie
person$age <- 40 #nowy elememet
person$age
person$job <- "senior programmer"
person$salary <- person$salary * 1.15 #modyfikacja
person$imie <- NULL #usuwanie
#NULL i NA - wartosci specjalne. NA oznacza luke w danych, NULL - wartosc niezdefiniowana
person[c("job","age")]
person[c(1,5)]
person[["age"]]

#WIEKSZOSC FUNKCJI DZIALA WEKTOROWO - JESLI CHCE SIE ZASTOSOWAC FUNKCJE DO KAZDEGO ELEMENTU LISTY POTRZEBA WIECEJ WYSILKU
#FUNKCJA LAPPLY - ARGUMENTY TO LISTA I FUNKCJA O ZASTOSOWANIA W KAZDYM ELEMENCIE LISTY (PLUS EWENTUALNIE ARGUMENTY TEJ FUNKCJI PO PRZECINKU)

ludzie <- list("cicho","ej","wezcie")
ludzie_up <- lapply(ludzie,toupper)
ludzie_up
ludzie_down <- lapply(ludzie,paste,"LUDZIEE")
ludzie_down
 #tekst z przodu
czesc <- function(item){
  paste("CZESC", item)
}

ludzie_hej <- lapply(ludzie,czesc)
ludzie_hej

#LAPPLY NALEZY DO RODZINY *APPLY - NP SAPPLY STOSOWANE DLA WEKTOROW. SAPPLY ZWROCI ZAWSZE WEKTOR A LAPPLY LISTE 
#(MIMO IZ LAPPLY MOZE BYC TAKZE STOSOWANY DLA WEKTOROW)




# RAMKI DANYCH ------------------------------------------------------------

#w rzeczywistosci to listy gdzie kazdy element jest wektorem tej samej dlugosci
imie <- c("Ola","Ala","Ida")
wzrost <- c(150,160,170)
waga <- c(50,60,70)
dane <- data.frame(imie,wzrost,waga,stringsAsFactors = FALSE)

#wyciaganie danych
dane$imie
dane[["imie"]] #poniewa¿ tabela jest lista to ta notacja tez jest dobra


nrow(dane)
ncol(dane)
dim(dane)
colnames(dane)
rownames(dane)
head(dane)
tail(dane)
View(dane)

#wybieranie
dane["2","waga"]
dane[2,3]
dane[1,"waga"]
dane[1,]
dane[,2] #pobierze jako wektor
dane["waga"] #pobierze jako ramke danych
class(dane[dane$wzrost > 160,])

#jesli zwrocona zostaje wiecej niz 1 kolumna to typ danych to data frame. jesli tylko 1 kolumna to wektor zwraca
#macierz - struktura dwuwymiarowa ale dane musza byc tego samego typu


#CSV - Excel to interfejs do formatowania tego typu danych. CSV nie zapisuje formatowania, zawiera wylacznie dane.
data() #dostepne zbiory danych
#read.csv()
#write.csv()

getwd() #zwraca biezacy katalog roboczy (jak pwd w wierszu polecen)
setwd() #zmiana katalogu roboczego

#lepsze rozwiazanie to wskazanie w Sessions -> Working Directory

#Faktory -> struktura danych sluzaca do optymalizowania zmiennych nominalnych (majacych skonczonych zbior mozliwosci wyboru)
#Optymalizacja przechowywania danych. Jesli bylby stringiem to kazde slowo przechowywane osobno(kazda litera to 1 bajt)

#Factor - dla ka¿dego POZIOMU wyboru generowana liczba opisujaca go (nadaje etykiety a R je zapamietuje). Kazda liczba przechowuje mniej bajtow niz wyraz
#factor nie jest wektorem dlatego prawie wszystkie operacje na wektorach nie zadzialaja dla faktorow
Faktor <- as.factor(c(1,2,3,4,5,3,4,1,3,5,2))
print(Faktor)
Faktor*2 #nie dziala dla faktora
Faktor[1] <- 5
Faktor
Faktor[2] <- 6 #nie dziala bo nie ma takiego poziomu
#W czasie tworzenia ramki danych gdy zaciagana kolumna jest stringiem R automatycznie potraktuje to jako faktor
#nalezy uzyc argumentu stringasfactors = FALSE

Cena <- c(12,13,15,14,15,15)
Rozmiar <- as.factor(c("L","M","M","M","M","L"))
Ramka <- data.frame(Cena,Rozmiar)
Ramka_test <- split(Ramka,Ramka$Rozmiar) #FUNKCJA SPLIT - DZIELI NA LISTE Z RAMKAMI DANYCH BAZUJAC NA FAKTORACH ZE ZBIORU
Ramka_test[["L"]]
Ramka_test["L"]
Ramka_test[2]
Ramka_test[[2]]

tapply(Ramka$Cena, Ramka$Rozmiar, sum) #pierwsze to to po czym ma liczyc, drugie to zmienna grupujaca i trzecie to funkcja





















