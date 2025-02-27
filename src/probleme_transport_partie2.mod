#### Fichier probleme_transport_partie2.mod ####

# Ensembles
set CLIENTS;
set DEPOTS;
set USINES;

# Paramètres de la partie 1
param prix_route{USINES union DEPOTS , CLIENTS union DEPOTS} >= 0;
param capacite_accueil{USINES union DEPOTS} >= 0;
param besoin_client{CLIENTS} >= 0;
param preference_client{CLIENTS, USINES union DEPOTS} >= 0;

# Nouveaux paramètres entrants
param cout_ouverture{DEPOTS} >= 0;
param economie_fermeture{DEPOTS} >= 0;
param cout_extension{DEPOTS} >= 0;

# Variables
var quantite_UC{u in USINES, c in CLIENTS} >= 0;
var quantite_UD{u in USINES , d in DEPOTS} >= 0;
var quantite_DC{d in DEPOTS, c in CLIENTS} >= 0;

# Variables de décision binaires
var decision_Stutt binary := 0; # devient 1 si ouverture d’un dépôt a Stuttgart
var decision_Dort binary := 0; # devient 1 si ouverture d’un dépôt a Dortmund
var decision_Leip binary := 0; # devient 1 si extension du dépôt de Leipzig
var decision_Duss binary := 1; # devient 0 si fermeture d’un dépôt a Düsseldorf
var decision_Franc binary := 1; # devient 0 si fermeture d’un dépôt a Francfort

# Nouvelle fonction objectif : Minimiser les coûts en variant les options des dépôts
minimize cout_total_avec_changement_depots:
decision_Stutt * cout_ouverture["Stuttgart"]
+ decision_Dort * cout_ouverture["Dortmund"]
+ decision_Leip * cout_extension["Leipzig"]
- (1 - decision_Duss) * economie_fermeture["Dusseldorf"]
- (1 - decision_Franc) * economie_fermeture["Francfort"]
+ sum{u in USINES, c in CLIENTS} prix_route[u,c] * quantite_UC[u,c]
+ sum{u in USINES, d in DEPOTS} prix_route[u,d] * quantite_UD[u,d]
+ sum{d in DEPOTS, c in CLIENTS} prix_route[d,c] * quantite_DC[d,c];

# Contrainte des besoins des clients
subject to Besoin_Clients{c in CLIENTS}:
sum{u in USINES} quantite_UC[u,c]
+ sum{d in DEPOTS} quantite_DC[d,c] = besoin_client[c];

# Contraintes des capacités des usines et des dépôts
subject to Capacite_Usines{u in USINES}:
sum{c in CLIENTS} quantite_UC[u,c]
+ sum{d in DEPOTS} quantite_UD[u,d] <= capacite_accueil[u];
subject to Capacite_Depots{d in (DEPOTS diff {"Leipzig"})}:
sum{c in CLIENTS} quantite_DC[d,c] <= capacite_accueil[d];

# Contrainte pour le dépôt de Leipzig
subject to Debit_Leipzig:
sum{c in CLIENTS} quantite_DC["Leipzig",c] <= capacite_accueil["Leipzig"] + decision_Leip * 25000;

# Contrainte pour les routes indisponibles entre Usines et Clients
subject to Route_Usine_Client_Zero{u in USINES, c in CLIENTS: prix_route[u,c] == 0}: 
	quantite_UC[u,c] = 0;
# Contrainte pour les routes indisponibles entre Usines et Dépôts
subject to Route_Usine_Depot_Zero{u in USINES, d in DEPOTS : prix_route[u,d] ==0}:
	quantite_UD[u,d] = 0;
# Contrainte pour les routes indisponibles entre Dépôts et Clients
subject to Route_Depot_Client_Zero{d in DEPOTS, c in CLIENTS: prix_route[d,c] == 0}:
	quantite_DC[d,c] = 0;

# Contrainte de liquidation des stocks des dépôts
subject to Liquidation_Stock{d in DEPOTS}:
	sum{u in USINES} quantite_UD[u,d] = sum{c in CLIENTS} quantite_DC[d,c];

# Contrainte pour garantir un maximum de 4 dépôts ouverts
subject to Nombre_Max_Depots:
	decision_Stutt + decision_Dort + decision_Franc + decision_Duss <= 2;

# Contraintes des quantités livrées selon l’ouverture ou la fermeture des dépôts
subject to Quantites_Francfort:
	sum{c in CLIENTS} quantite_DC["Francfort", c] <= decision_Franc * capacite_accueil["Francfort"];
subject to Quantites_Dusseldorf:
	sum{c in CLIENTS} quantite_DC["Dusseldorf", c] <= decision_Duss * capacite_accueil["Dusseldorf"];
subject to Quantites_Stuttgart:
	sum{c in CLIENTS} quantite_DC["Stuttgart", c] <= decision_Stutt * capacite_accueil["Stuttgart"];
subject to Quantites_Dortmund:
	sum{c in CLIENTS} quantite_DC["Dortmund", c] <= decision_Dort * capacite_accueil["Dortmund"];

# Contrainte des préférences des clients
# Veuillez retirer les commentaires ci-dessous pour traiter ces hypothèses
#subject to Respect_Preferences{c in CLIENTS, s in USINES union DEPOTS}:
#if preference_client[c,s] == 0 then (sum{u in USINES: u == s} quantite_UC[u,c]
# + sum{d in DEPOTS: d == s} quantite_DC[d,c]) = 0;
