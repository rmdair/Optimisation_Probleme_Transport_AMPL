<div align="center">
  <h1>Optimisation d’un Problème de Transport avec AMPL</h1>
</div>

Dans un contexte où la logistique est un enjeu stratégique pour les entreprises, l’optimisation des coûts de transport devient un levier essentiel pour améliorer la rentabilité et l’efficacité des flux de distribution. Ce projet propose une modélisation détaillée d’un problème de transport à l’aide du langage **AMPL**, avec plusieurs scénarios d’optimisation pour une entreprise allemande cherchant à approvisionner ses clients tout en minimisant ses coûts.

## Le Langage AMPL  
AMPL (**A Mathematical Programming Language**) est un langage de modélisation utilisé pour résoudre des problèmes d’optimisation linéaire et non linéaire. Il permet une séparation claire entre :
- **Les données** (fichiers `.dat`),
- **Le modèle mathématique** (fichiers `.mod`),
- **Les commandes de résolution** (fichiers `.run`).  

Grâce à cette structure modulaire, AMPL facilite l'expérimentation avec différents solveurs comme **CPLEX** pour trouver des solutions optimales.

## Objectifs du Projet  
L’étude explore différentes approches d’optimisation, incluant :
- **Minimisation des coûts de transport** entre usines, dépôts et clients.
- **Comparaison des stratégies de distribution**, avec ou sans entrepôts intermédiaires.
- **Intégration des préférences clients** pour adapter le réseau logistique à leurs exigences.
- **Réorganisation du réseau de dépôts**, en étudiant l’ouverture, l’extension ou la fermeture de certaines infrastructures.
- **Utilisation du solveur CPLEX** pour obtenir des solutions optimales.

## Contenu du Rapport  
Le rapport présente une analyse approfondie du problème, avec :
- La **formulation mathématique** complète sous AMPL.
- Les **résultats des simulations**, illustrés par des tableaux et diagrammes de flux.
- Les **interprétations** sur les différentes stratégies logistiques.

**Consulter le rapport complet :**  
➡️ [Optimisation du Problème de Transport (PDF)](./Optimisation_Probleme_Transport.pdf)

## Code et Modélisation  
Le projet est structuré en plusieurs fichiers (accessibles via [ce lien](src/)) :
- **`probleme_transport_partie1.mod`** : Modèle AMPL de base avec les dépôts initiaux.
- **`probleme_transport_partie1.dat`** : Données associées aux coûts de transport, capacités, demandes et préférences des clients. 
- **`probleme_transport_partie1.run`** : Commandes pour résoudre le modèle avec CPLEX. 
- **`probleme_transport_partie2.mod`** : Modèle AMPL intégrant les nouvelles options de dépôts. 
- **`probleme_transport_partie2.dat`** : Données mises à jour incluant les coûts d’ouverture, de fermeture et d'extension de dépôts.
- **`probleme_transport_partie2.run`** : Exécution de la simulation avec le solveur. 

## Références  
- AMPL Documentation officielle - *A Modeling Language for Mathematical Programming*  
  📖 [Lire le guide complet](https://ampl.com/wp-content/uploads/BOOK.pdf)
