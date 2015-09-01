---
title: Bootstrap avec symfony
date: 2012-04-25 00:00 UTC
tags: php, symfony
cover: symphony-php.jpg
lang: fr
---

Développant essentiellement sur Symfpny et PHP, l'étape que je redoute
et le moment de mettre en place le design, et en particulier l'affichage
sur tous les navigateurs. Mais un jour après une discution avec un
collegue. J'ai découvert bootstrap. Et franchement bravo. On fait le
design de son application en déclarant quelques classes. J'ai ainsi pu
refaire le design de mon site, très rapidement. 

README
 

## Les bundles symfony2 et bootstrap 

Au rayon des bonnes surprises j'ai découvert que certains bundle
faisaient très bon ménage avec ce framework CSS (l'appelation est-elle
correct ? En tout cas ça y ressemble bien). Le bundle
[WhiteOctoberPagerfantaBundle](https://github.com/whiteoctober/WhiteOctoberPagerfantaBundle "WhiteOctoberPagerfantaBundle")
propose de base un template pour bootstrap. bref vous intégrez la
pagination sans vous soucier de comment l'intégrer par la suite. Le code
pour y parvenir (se trouve aussi dans la doc officiel) : 

```
{{ pagerfanta(pagerfanta, 'twitter_bootstrap_translated') }}
```

Et voilà votre paginator ressemble à quelque chose. 