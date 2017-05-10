#importation des packages et des librairies
library(sp)
library(cartography)
library(RColorBrewer)
install.packages("maptools")
library(classInt)
library(maptools)
library(rgdal)

#nettoyage de l'espace de travail
rm(list=ls())
#Arborescence du fichier contenant toutes les données
setwd("C:/Users/acottais/Documents/Etudes/Votes_1tour")

## Import du support carte
#load(url("http://wukan.ums-riate.fr/r2016/data/Occitanie.RData"))
DEP<- readShapeSpatial("DEPARTEMENT")


#--------------------------------------1ER TOUR PRSDTIEL 2017-----------------------------------------------

#Lecture de la table résultats présidentiels
PSDT<-read.csv("Presidentielles1.csv", sep=";", header=TRUE, dec=",")

#-------------------CANDIDAT SORTANT-------------
DEP@data<-merge(DEP@data,PSDT[,c(1,34)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

#discrétisation en 4 classes 
#DEP@data$CANDIDAT_SORTANT2017<-as.numeric(paste(DEP@data$CANDIDAT_SORTANT2017))
distr <- c(0.5,1.5,2.5,3.5,4.5)

#classIntervals(DEP$CANDIDAT_SORTANT2017,4,style="fixed")$brks
#Choix des couleurs
colours <- c("orange", "orchid4", "pink2", "firebrick1")
#attribution des couleurs aux régions
colMap <- colours[(findInterval(DEP$CANDIDAT_SORTANT2017,distr,all.inside=TRUE))]

png(file = "CANDIDAT_SORTANT_2017", width = 800, height = 700)
plot(DEP,col=colMap)
legend("bottomleft", legend=c("Macron","Le Pen","Fillon","Mélenchon"),
fill=colours, bty="n",
title="Candidat \nsortant gagnant\ndans chaque\ndépartement")
dev.off()

#bty : encadré de la légende

#--------------------------------------2E TOUR PRSDTIEL 2017-----------------------------------------------

#Lecture de la table résultats présidentiels
PSDT2<-read.csv("Presidentielles2.csv", sep=";", header=TRUE, dec=",")

#-------------------CANDIDAT SORTANT-------------
DEP@data<-merge(DEP@data,PSDT2[,c(1,11)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

#discrétisation en 2 classes 

DEP@data$CANDIDAT_SORTANT2_2017<-as.numeric(paste(DEP@data$CANDIDAT_SORTANT2_2017))
distr <- classIntervals(DEP$CANDIDAT_SORTANT2_2017,2,style="fixed")$brks
#Choix des couleurs
colours <- c("orange", "orchid4")
#attribution des couleurs aux régions
colMap <- colours[(findInterval(DEP$CANDIDAT_SORTANT2_2017,distr,all.inside=TRUE))]

png(file = "CANDIDAT_SORTANT_2_2017", width = 800, height = 700)
plot(DEP,col=colMap)
legend("bottomleft", legend=c("Macron","Le Pen"),
fill=colours, bty="n",
title="Candidat \nsortant gagnant\ndans chaque\ndépartement")
dev.off()


#--------------------------------------1ER TOUR PRSDTIEL 2002-----------------------------------------------


PSDT_2002<-read.csv("Presidentielles1_2002.csv", sep=";", header=TRUE, dec=",")


#--------------------CANDIDAT SORTANT-------
DEP@data<-merge(DEP@data,PSDT_2002[,c(1,30)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)


#discrétisation en 3 classes
DEP@data$CANDIDAT_SORTANT2002<-as.numeric(paste(DEP@data$CANDIDAT_SORTANT2002))
distr <- classIntervals(DEP$CANDIDAT_SORTANT2002,3,style="fixed")$brks
#Choix des couleurs
colours <- c("steelblue1","orchid4","palevioletred1")
#attribution des couleurs aux régions
colMap <- colours[(findInterval(DEP$CANDIDAT_SORTANT2002,distr,all.inside=TRUE))]


png(file = "CANDIDAT_SORTANT_2002", width = 800, height = 700)
plot(DEP,col=colMap)
legend("bottomleft", legend=c("Chirac","Le Pen","Jospin"),
fill=colours, bty="n",
title="Candidat\nsortant gagnant \ndans chaque \ndépartement")
dev.off()

#--------------------------------------2E TOUR PRSDTIEL 2002-----------------------------------------------

png(file = "CANDIDAT_SORTANT2_2002", width = 800, height = 700)
plot(DEP, col="steelblue1")
legend("bottomleft", legend=c("Chirac", "Le Pen"),
fill=c("steelblue1","orchid4"), bty="n",
title="Candidat\nsortant gagnant \ndans chaque \ndépartement") 
dev.off()

#--------------------------------------CATEGORIE SOCIO-PRO----------------------------------------



CSP<-read.csv("CSP.csv", sep=";", header=TRUE, dec=",")

#-------------------AGRICULTEURS----------

DEP@data<-merge(DEP@data,CSP[,c(1,4)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)


png(file = "3-Agriculteurs.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Agriculteurs", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Agriculteurs \nen % de population active")
dev.off()

#-------------------ARTISANS,COMM,CHEFE----------

DEP@data<-merge(DEP@data,CSP[,c(1,6)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "3-Artisans_Commercants_ChefE.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Artis_Com_Centr", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Artisans, commerçants,\nchefs d'entreprise \nen % de population active")
dev.off()

#-------------------CADRES PROFESSIONS INTELLECT SUP----------

DEP@data<-merge(DEP@data,CSP[,c(1,8)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "3-Cadres_Professions_intellectuelles_sup.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Cadres", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Cadres et professions\nintellectuelles supérieures \nen % de population active")
dev.off()

#-------------------PROFESSIONS INTERMEDIAIRES----------

DEP@data<-merge(DEP@data,CSP[,c(1,10)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "3-Professions_intermediaires.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Pro_interm", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Professions intermédiaires \nen % de population active")
dev.off()

#-------------------EMPLOYES----------

DEP@data<-merge(DEP@data,CSP[,c(1,12)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "3-Employés.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Emp", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Employés \nen % de population active")
dev.off()

#-------------------OUVRIERS----------

DEP@data<-merge(DEP@data,CSP[,c(1,14)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "3-Ouvriers.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_Ouvriers", border = TRUE, 
    col = carto.pal("orange.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Ouvriers \nen % de population active")
dev.off()



#--------------------------------------DIPLOMES----------------------------------------


DIPL<-read.csv("niv_diplome.csv", sep=";", header=TRUE, dec=",")


#-------------------AUCUNS----------

DEP@data<-merge(DEP@data,DIPL[,c(1,3)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)


png(file = "4-Sans_diplome.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_AUCUNS", border = TRUE, 
    col = carto.pal("green.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Non diplomés\nen % de population \nde 16 ans et +")
dev.off()

#-------------------BEP_CAP----------

DEP@data<-merge(DEP@data,DIPL[,c(1,5)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "4-BEP_CAP.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_CAP_BEP", border = TRUE, 
    col = carto.pal("green.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Diplomés de \nCAP ou BEP \nen % de population \nde 16 ans et +")
dev.off()

#-------------------BAC----------

DEP@data<-merge(DEP@data,DIPL[,c(1,7)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "4-BAC.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_BAC", border = TRUE, 
    col = carto.pal("green.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Diplomés du \nbaccalauréat \nen % de population \nde 16 ans et +")
dev.off()

#-------------------ETUDES SUP----------

DEP@data<-merge(DEP@data,DIPL[,c(1,9)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "4-SUPERIEUR.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "PER_SUP", border = TRUE, 
    col = carto.pal("green.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Diplomés d'études \nsupérieures \nen % de population \nde 16 ans et +")
dev.off()


#--------------------------------------AGE MOYEN----------------------------------------



#-------------------2016----------

POP2017<-read.csv("Population.csv", sep=";", header=TRUE, dec=",")
DEP@data<-merge(DEP@data,POP2017[,c(1,63)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "AGE_MOYEN2017.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "AGE_MOYEN2017", border = TRUE, 
    col = carto.pal("blue.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Âge moyen \nde la population")
dev.off()

#-------------------2002----------

POP2002<-read.csv("Population2002.csv", sep=";", header=TRUE, dec=",")
DEP@data<-merge(DEP@data,POP2002[,c(1,63)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "AGE_MOYEN2002.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "AGE_MOYEN2002", border = TRUE, 
    col = carto.pal("blue.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Âge moyen \nde la population")
dev.off()

#--------------------------------------TAUX CHOMAGE----------------------------------------

CHOM<-read.csv("taux_chomage.csv", sep=";", header=TRUE, dec=",")

#-------------------2016----------

DEP@data<-merge(DEP@data,CHOM[,c(1,141)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "taux_chom2016.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "TRIM3_2016", border = TRUE, 
    col = carto.pal("kaki.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Taux de chômage\nen %")
dev.off()

#-------------------2002----------

DEP@data<-merge(DEP@data,CHOM[,c(1,83)], by="CODE_DEPT",all.x=TRUE, sort=FALSE)

png(file = "taux_chom2002.png", width = 800, height = 700)
choroLayer(spdf = DEP, df = DEP@data, spdfid = "CODE_DEPT", 
    dfid = "CODE_DEPT", var = "TRIM1_2002", border = TRUE, 
    col = carto.pal("kaki.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "Taux de chômage\nen %")
dev.off()


#--------------------------------------PIB----------------------------------------
REG<- readShapeSpatial("REG")
REG<-REG[REG@data$code_insee!="06" & REG@data$code_insee!="04" & REG@data$code_insee!="02" & REG@data$code_insee!="01" & REG@data$code_insee!="03",]

PIB<-read.csv("PIB.csv", sep=";", header=TRUE, dec=",")

#-------------------2002----------

REG@data<-merge(REG@data,PIB[,c(1,15)], by.x="code_insee",by.y="CODE_INSEE",all.x=TRUE, sort=FALSE)

REG@data$PIB_2002<-as.numeric(gsub("[[:space:]]","",REG@data$PIB_2002))

png(file = "PIB_2002.png", width = 800, height = 700)
choroLayer(spdf = REG, df = REG@data, spdfid = "code_insee", 
    dfid = "code_insee", var = "PIB_2002", border = TRUE, 
    col = carto.pal("blue.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "PIB généré par habitant \npar département en 2002")
dev.off()

#-------------------2016----------
REG@data<-merge(REG@data,PIB[,c(1,27)], by.x="code_insee",by.y="CODE_INSEE",all.x=TRUE, sort=FALSE)

REG@data$PIB_2014<-as.numeric(gsub("[[:space:]]","",REG@data$PIB_2014))

png(file = "PIB_2014.png", width = 800, height = 700)
choroLayer(spdf = REG, df = REG@data, spdfid = "code_insee", 
    dfid = "code_insee", var = "PIB_2014", border = TRUE, 
    col = carto.pal("red.pal", 8), legend.pos = "bottomleft", 
    method = "geom", nclass = 8, legend.title.txt = "PIB généré par habitant\npar département en 2014")
dev.off()
