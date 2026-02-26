<div align="center">
  <h1>Code source (AMPL)</h1>
</div>

Ce répertoire contient les fichiers de modélisation mathématique (**MOD**), les données (**DAT**) et les scripts d'exécution (**RUN**).

### Structure des fichiers
**Partie 1 (Réseau initial)** : 
  - `probleme_transport_partie1.mod` : Modèle (variables, objectif, contraintes).
  - `probleme_transport_partie1.dat` : Données (capacités, coûts, besoins).
  - `probleme_transport_partie1.run` : Script de résolution via CPLEX.

**Partie 2 (Restructuration du réseau)** :
  - `probleme_transport_partie2.mod` (etc.) : Intègre les options d'ouverture/fermeture de dépôts.

### Exécution
Pour reproduire les résultats, lancer le fichier `.run` correspondant depuis un terminal AMPL :
```bash
ampl probleme_transport_partie1.run
````