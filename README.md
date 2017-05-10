# Elections2017
## "La Société française et les Elections Présidentielles 2002 et 2017": on vous dévoile notre script R !

Pour réaliser une cartographie des votes aux présidentielles de 2002 et 2017 et de la société française (===> mettre en lien), nous avons déployé un outil qu'affectionnent particulièrement les data scientist, le langage R.
Nous allons décrire les étapes par lesquelles nous sommes passés afin que vous puissiez reproduire nos cartographies.

##Librairies et packages


>>-sp

Fournit des classes et méthodes pour les données présentant des informations spatiales. 

>>-cartography 

Crée et intègre des cartes dans un espace de travail R.

>>-RColorBrewer

Fournit des palettes de couleurs pour cartes ou autres graphiques.

>>-maptools

Set d'outils permettant de manipuler et de lire des données géographiques (en particulier pour les formats ShapeFiles)

>>-classInt

Méthodes couramment utilisées afin de choisir et mettre en place des intervalles de classes pour des fins de cartographiques ou graphiques.

>>-rgdal

Importe de nombreux formats de données raster, spatiales et aussi vectorielles.


##Données géographiques 

Les données géographiques utilisées dans ce cas d'usage sont des données libres répertoriées sur internet.
Ainsi, nous avons importé les données départementales et des anciennes régions françaises que vous pouvez retrouver en suivant les liens : 
départements : http://professionnels.ign.fr/geofla
régions : https://www.arcgis.com/home/item.html?id=9ce5971171e449c19a70caa0127d924c
Les données des anciennes régions présentent également les représentations des DOM TOM. Il est donc nécessaire de les retirer.
En effet, dans un soucis d'uniformisation, face aux données à notre disposition, nous avons fait le choix de ne prendre en compte que la France métropolitaine.

##Description du code 
Avant toute utilisation du code, il est nécessaire de lire les avertissements et le point méthodologique lié à ces représentations.
Il est aussi important de fournir le chemin dans la procédure setwd qui correspondra au chemin menant aux données à importer et aux données exportées.
Les méthodes cartographiques utilisées ici sont inspirées du tutoriel disponible écrit par Thimothée Giraud. 
Les données géographiques importées sont organisées en deux data frames distincts.
D'une part on observe les données concernant les différents départements, de l'autres les informations nécessaires aux représentations graphiques.
En considérant que les données ont été importées dans l'objet DEP, il est possible d'appeler les données avec la procédure " DEP@data" et l'autre partie grâce à "DEP@polygons".
La partie "polygons" décrit un à un les 96 départements concernés.
Afin de réaliser les cartes nous nous intéresserons à la partie "données" et allons ignorer la partie polygone.
Pour représenter un nouveau caractère, il suffit de fusionner aux données déjà présentes une nouvelle colonne contenant les données à utiliser.
La fonction merge est cependant à utiliser avec précaution. En effet les données géographiques respectent un ordre particulier qu'il est important de garder.
Il est ainsi fortement conseillé d'utiliser l'argument "sort=FALSE" lors de la fusion.
De plus, si une donnée est manquante ou que la variable de fusion n'est pas nécessairement la même, il est important d'utiliser l'argument "all.x=TRUE" afin de permettre retourner tous les éléments de la table DEP@data.
Il est ensuite possible d'obtenir deux types de cartes différents grâce au code à votre disposition.
Dans un premier temps, seront décrites les cartes choroplèthes avant de s'intéresser plus précisément aux cartes représentant les candidats sortant.

Nous avons cherché à caractériser une donnée quantitative grâce à des variations de couleurs.
Un département (ou région) apparaît ainsi d'une certaine nuance selon la donnée associée.
Pour se faire, la procédure choroLayer a été choisie. Les différents arguments utilisés sont les suivants : 
>>-spdf : "SpatialPolygonsDataFrame" ici : DEP

>>-df :  data frame dans lequel on trouve les données à cartographier ici : DEP@data

>>-spdfid : nom de l'identifiant du spdf 

>>-dfid : nom de l'identifiant dans le data frame données (df)

>>-var : nom de la variable à numérique à représenter sur la carte

>>-border : afficher (ou non) les bordure des éléments à afficher (ici départements) et choix de la couleur

>>-method : choix de la méthode de discrétisation des données

>>-nclass : nombre de classes choisies

>>-col : choix des différentes couleurs de la carte (vecteur ou utilisation de la procédure carto.pal qui propose une palette de couleurs)

>>-legend.title.txt : titre de la légende

>>-legend.pos : position de la légende en fonction de la carte

Cette méthode ne permettait pas de réaliser les cartes représentant le candidat sortant pour chaque département.
Pour cela, une autre procédure a été utilisée.  Chaque étape réalisée dans la procédure précédente a été détaillée.
Une fois avoir fusionné les données à représenter (codée 1, 2, 3 ou 4 selon les candidats) avec le dataframe, il est important de créer les classes.
Le choix des classes n'importe pas sur la représentation tant qu'il propose des classes qui permettent de contenir chacun des entiers.
Par exemple si 3 candidats se présentent, les bornes des classes (à intégrer dans un vecteur) seront telles que c(0.5,1.5,2.5,3.5). 
L'étape suivante est de déterminer les différentes couleurs de la carte (attention à suivre l'ordre des candidats afin d'avoir la bonne correspondance de couleurs.
La procédure d'après permet cette fois ci de créer un vecteur qui associe à chaque département la couleur correspondante.
Ici, nous aurons par exemple un vecteur contenant 96 couleurs suivant l'ordre des départements, inscrit dans le spdf.
Enfin, est affichée la carte grâce à la procédure plot et est créée la légende associée.
Pour finir, toutes les cartes affichées sont automatiquement exportées au format png suivant le chemin associé.
Pour se faire, on trouvera avant la réalisation de chaque graphique la procédure "png" et la procédure dev.off() à la fin qui permet de fermer toutes les fenêtres graphiques actuellement en cours.
