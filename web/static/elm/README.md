# Askcode Frontend

## Application Structure

<pre>
.
|
+-- Main.elm                     /* Elm app entry point */
+-- Root.elm                     /* Top level component */
+-- Styles.elm                   /* Common styles */
+-- Models                       /* Common models and json serializers */
+-- Routing                      /* Routing configs */
|   +-- Config.elm
|   +-- Page                     /* Routing config for CRUD */
|       +-- Config.elm
|       +-- Utility.elm
+-- Page                         /* Pages or UI components */
    +-- UI
+-- View                         /* Components without msg and update */
+-- Validation.elm               /* Logic related to validation */
|
/* Misc */
+-- Ace.elm
+-- LocalStorage.elm
+-- Native                       /* Natvie codes */
|   +-- LocalStorage.js
+-- Html/                        /* elm-lang/html extensions */
+-- Http/                        /* elm-lang/http extensions */
</pre>
