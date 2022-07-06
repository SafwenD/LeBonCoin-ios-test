
**Un project "sample" d'un exercise pour le boncoin.**

Progrès :

 - [x] En cours
 - [ ] Fini

*Exercice*:
Créer une application universelle (iPhone, iPad) en Swift. Celle-ci devra afficher une liste d'annonces disponibles sur l'API  [https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json](https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json)  La correspondance des ids de catégories se trouve sur l'API  [https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json](https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json)  Le contrat d'API est visualisable à cette adresse :  [https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml](https://raw.githubusercontent.com/leboncoin/paperclip/master/swagger.yaml)

Les points attendus dans le projet sont:

 - Une architecture qui respecte le principe de responsabilité unique

 - Création des interfaces avec autolayout directement dans le code (**pas de storyboard ni de xib, ni de SwiftUI**)

 - Développement en Swift Le code doit être versionné (Git) sur une plateforme en ligne type Github ou Bitbucket (pas de zip) et doit être immédiatement exécutable sur la branche master

 - **Aucune librairie externe n'est autorisée** Le projet doit être compatible pour iOS 14+ (compilation et tests)

Nous porterons également une attention particulière sur les points suivants : Les tests unitaires Les efforts UX et UI Performances de l'application Code swifty

Liste d'items Chaque item devra comporter au minimum une image, une catégorie, un titre et un prix. Un indicateur devra aussi avertir si l'item est urgent.

Page de détail Au tap sur un item, une vue détaillée devra être affichée avec toutes les informations fournies dans l'API.
