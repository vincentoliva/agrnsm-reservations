CONFIGURATION GRATUITE – AGRNSM
=====================================

Cette version est préparée pour fonctionner avec :
- Supabase Free : base PostgreSQL + authentification
- Cloudflare Pages : hébergement statique gratuit
- GitHub : dépôt du code gratuit

1. CRÉER SUPABASE
-----------------
Créer un projet gratuit sur https://supabase.com/

Dans SQL Editor, ouvrir schema.sql et exécuter tout le contenu.

2. RÉCUPÉRER LES CLÉS
---------------------
Dans Supabase : Project Settings > API.
Copier :
- Project URL
- anon public key

NE JAMAIS mettre la clé service_role dans le site.

3. CONFIGURER LE SITE
---------------------
Le site fourni est déjà préconfiguré avec l'URL du projet Supabase AGRNSM et sa clé Publishable.

4. CRÉER LE COMPTE ADMIN
------------------------
Dans Supabase > Authentication > Users :
Create user.
Exemple :
Email : votre-adresse-AGRNSM
Mot de passe : un mot de passe fort

Ce compte servira à admin.html.

5. HÉBERGER GRATUITEMENT
------------------------
Déposer les fichiers sur GitHub puis connecter le dépôt à Cloudflare Pages.
Aucun serveur payant n'est nécessaire.

6. IMPORTANT – RÉSERVATIONS
---------------------------
Une réservation "Demande" ou "Confirmée" bloque :
- la date
- la demi-journée (matin ou après-midi)

La contrainte unique de PostgreSQL empêche deux réservations concurrentes
sur la même demi-journée.

7. ANNÉE SCOLAIRE
-----------------
Le calendrier conserve l'affichage septembre → juin.

8. MODE DÉMONSTRATION
---------------------
Si Supabase n'est pas configuré, le site continue à fonctionner en local
comme le prototype précédent avec localStorage. Une fois les clés renseignées,
les réservations passent sur la base centrale.

9. ÉVOLUTION CONSEILLÉE
-----------------------
Après mise en ligne, on pourra ajouter :
- confirmation/refus par e-mail
- comptes enseignants
- gestion des 41 interventions depuis l'administration
- établissements enregistrés
- export Excel
- statistiques
- calendrier des intervenants
- blocage des vacances scolaires et jours fériés.
