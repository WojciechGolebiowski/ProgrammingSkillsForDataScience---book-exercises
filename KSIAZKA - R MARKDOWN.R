#install.packages(c("rmarkdown","knitr"))
library(rmarkdown) #przetwarza znaczniki Markdown na dane wyjsciowe
library(knitr) #uruchamia kod R i tworzy dane wyjsciowe

#pliki powinny byc zapisane w formacie Rmd aby R wiedzial ze zawartosc jest w takim formacie
#Plik rmd zawiera: naglowek, porcje kodu R, porcje kodu Markdown

#R studio - wlasny interfejs do kompilowania kodu zrodlowego - wykonuje to pakiet knitr
#dobra praktyka programistyczna - pisanie kodu w innym skrypcie i wywlywanie go przez source z poziomu R markdown