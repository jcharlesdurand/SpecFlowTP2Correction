﻿Feature: ScrutinMajoritaire
	En tant que client de l'API à la clôture d'un scrutin
	Je souhaite calculer le résultat du scrutin
	Pour obtenir le vainqueur du vote

 Scenario: Scrutin majoritaire un électeur et un vainqueur
	Given les candidats suivants
	| Nom        |
	| candidat 1 |
	| candidat 2 |
	And le tour de scrutin est ouvert
	And le vote d'un electeur est "candidat 1"
	When le scrutin est clôturé
	Then le résultat est valide
	And "candidat 1" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 100         |
	| candidat 2 | 0              | 0           |

	Scenario: Scrutin majoritaire deux électeurs, pas de vainqueur au premier tour et vainqueur au second tour
	Given les candidats suivants
	| Nom        |
	| candidat 1 |
	| candidat 2 |
	| candidat 3 |
	And le tour de scrutin est ouvert
	And le vote d'un electeur est "candidat 1"
	And le vote d'un electeur est "candidat 3"
	When le scrutin est clôturé
	Then le résultat n'est pas valide
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 50          |
	| candidat 2 | 0              | 0           |
	| candidat 3 | 1              | 50          |
	And un second tour de scrutin est possible
	And les candidats suivants sont qualifiés
	| Nom        | 
	| candidat 1 | 
	| candidat 3 | 
	Given le tour de scrutin est ouvert
	And le vote d'un electeur est "candidat 1"
	And le vote d'un electeur est "candidat 3"
	And le vote d'un electeur est "candidat 3"
	And le vote d'un electeur est "candidat 3"
	When le scrutin est clôturé
	Then le résultat est valide
	And "candidat 3" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 25          |
	| candidat 3 | 3              | 75          |