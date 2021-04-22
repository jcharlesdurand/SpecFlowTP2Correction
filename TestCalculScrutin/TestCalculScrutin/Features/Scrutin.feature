Feature: ScrutinMajoritaire
	En tant que client de l'API à la clôture d'un scrutin
	Je souhaite calculer le résultat du scrutin
	Pour obtenir le vainqueur du vote

 Scenario: Scrutin majoritaire un électeur et un vainqueur
	Given les candidats suivants
	| Nom        |
	| candidat 1 |
	| candidat 2 |
	And le vote d'un electeur est "candidat 1"
	When le scrutin est clôturé
	Then le résultat est valide
	And "candidat 1" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 100         |
	| candidat 2 | 0              | 0           |