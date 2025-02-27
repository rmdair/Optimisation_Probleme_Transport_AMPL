#### Fichier probleme_transport_partie1.mod ####

# Ensembles
set USINES;
set DEPOTS;
set CLIENTS;

# Paramètres
param prix_route{USINES union DEPOTS , CLIENTS union DEPOTS} >= 0;
param capacite_accueil{USINES union DEPOTS} >= 0;
param besoin_client{CLIENTS} >= 0;
param preference_client{CLIENTS, USINES union DEPOTS} binary;

# Variables
var quantite_UC{u in USINES, c in CLIENTS} >= 0;
var quantite_UD{u in USINES, d in DEPOTS} >= 0;
var quantite_DC{d in DEPOTS, c in CLIENTS} >= 0;

# Fonction objectif
minimize cout_total:
sum{u in USINES, c in CLIENTS} prix_route[u,c] * quantite_UC[u,c]
+ sum{u in USINES, d in DEPOTS} prix_route[u,d] * quantite_UD[u,d]
+ sum{d in DEPOTS, c in CLIENTS} prix_route[d,c] * quantite_DC[d,c];

# Contrainte des capacités des usines et des dépôts
subject to Capacite_Usines{u in USINES}:
sum{c in CLIENTS} quantite_UC[u,c] + sum{d in DEPOTS} quantite_UD[u,d] <= capacite_accueil[u];
subject to Capacite_Depots{d in DEPOTS}:
sum{u in USINES} quantite_UD[u,d] <= capacite_accueil[d];

# Contrainte des besoins des clients
subject to Besoin_Clients{c in CLIENTS}:
sum{u in USINES} quantite_UC[u,c] + sum{d in DEPOTS} quantite_DC[d,c] = besoin_client[c];

# Contrainte des routes indisponibles
subject to Route_Indisponible_Usine_Client{u in USINES, c in CLIENTS: prix_route[u,c] == 0}:
quantite_UC[u,c] = 0;
subject to Route_Indisponible_Usine_Depot{u in USINES, d in DEPOTS : prix_route[u,d] == 0}:
quantite_UD[u,d] = 0;
subject to Route_Indisponible_Depot_Client{d in DEPOTS, c in CLIENTS: prix_route[d,c] == 0}:
quantite_DC[d,c] = 0;

# Contrainte de liquidation des stocks des dépôts
subject to Liquidation_Stock{d in DEPOTS}:
sum{u in USINES} quantite_UD[u,d] = sum{c in CLIENTS} quantite_DC[d,c];

# Veuillez retirer les commentaires ci-dessous pour inclure les préférences des clients
#subject to Respect_Preferences{c in CLIENTS, s in USINES union DEPOTS}:
#if preference_client[c,s] == 0 then (sum{u in USINES: u == s} quantite_UC[u,c]
# + sum{d in DEPOTS: d == s} quantite_DC[d,c]) = 0;
