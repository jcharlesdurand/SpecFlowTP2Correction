Feature: ScrutinMajoritaire
	En tant que client de l'API à la clôture d'un scrutin
	Je souhaite calculer le résultat du scrutin
	Pour obtenir le vainqueur du vote

	- Pour obtenir un vainqueur, le scrutin doit être clôturé
	- Si un candidat obtient > 50% des voix, il est déclaré vainqueur
	- On veut pouvoir afficher le nombre de votes pour chaque candidat et le pourcentage correspondant à la clôture du scrutin.
	- Si aucun candidat n'a plus de 50%, alors on garde les 2 candidats correspondants aux meilleurs pourcentages et il y aura un deuxième tour de scrutin
	- Il ne peut y avoir que deux tours de scrutins maximums
	- Sur le dernier tour de scrutin, le vainqueur est le candidat ayant le pourcentage de vote le plus élevé
	- Si on a une égalité sur un dernier tour, on ne peut pas déterminer de vainqueur



 Scenario: Scrutin majoritaire un électeur et un vainqueur
	Given les candidats suivants
	| Nom        |
	| candidat 1 |
	| candidat 2 |
	And le tour de scrutin est ouvert
	And le vote d'un electeur est "candidat 1"
	When le scrutin est clôturé
	Then il y a un vainqueur
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
	Then il n'y a pas de vainqueur
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
	Then il y a un vainqueur
	And "candidat 3" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 25          |
	| candidat 3 | 3              | 75          |

Scenario: Scrutin majoritaire deux électeurs, pas de vainqueur au premier tour et pas de vainqueur au second tour
	Given les candidats suivants
	| Nom        |
	| candidat 1 |
	| candidat 2 |
	| candidat 3 |
	And le tour de scrutin est ouvert
	And le vote d'un electeur est "candidat 1"
	And le vote d'un electeur est "candidat 3"
	When le scrutin est clôturé
	Then il n'y a pas de vainqueur
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
	When le scrutin est clôturé
	Then le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 50          |
	| candidat 3 | 1              | 50          |
	And il n'y a pas de vainqueur
