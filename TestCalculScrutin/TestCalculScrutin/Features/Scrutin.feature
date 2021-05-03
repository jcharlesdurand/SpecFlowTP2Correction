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

	Evolution
	- Gestion des égalités sur le 2ème et 3ème candidat sur un premier tour
		- Règle métier choisie: en cas d'égalité au premier tour, le candidat le plus âgé est qualifié au deuxième tour
	- Gestion du vote blanc
		- Règle métier choisie: les votes blancs ou nuls ne sont pas comptabilisés dans les suffrages exprimés
								, mais ils sont décomptés à part et on veut pouvoir en connaître le nombre pour chaque tour 

 Scenario: Scrutin majoritaire un électeur et un vainqueur
	Given les candidats suivants
	| Nom        | DateDeNaissance |
	| candidat 1 | Jan 1, 1999     |
	| candidat 2 | Jun 15, 1995    |
	And le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 1              |
	When le scrutin est clôturé
	Then il y a un vainqueur
	And "candidat 1" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 100         |
	| candidat 2 | 0              | 0           |

Scenario: Scrutin majoritaire deux électeurs, pas de vainqueur au premier tour et vainqueur au second tour
	Given les candidats suivants
		| Nom        | DateDeNaissance |
		| candidat 1 | Jan 1, 1999     |
		| candidat 2 | Jun 15, 1995    |
		| candidat 3 | Jan 2, 1999     |
	And le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 4              |
	| candidat 2 | 2              |
	| candidat 3 | 3              |
	When le scrutin est clôturé
	Then il n'y a pas de vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage       |
	| candidat 1 | 4              | 44.44444444444444 |
	| candidat 2 | 2              | 22.22222222222222 |
	| candidat 3 | 3              | 33.33333333333333 |
	And un autre tour de scrutin est possible
	And les candidats suivants sont qualifiés
	| Nom        | 
	| candidat 1 | 
	| candidat 3 | 
	Given le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 1              |
	| candidat 3 | 3              |
	When le scrutin est clôturé
	Then il y a un vainqueur
	And "candidat 3" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 25          |
	| candidat 3 | 3              | 75          |

Scenario: Scrutin majoritaire deux électeurs, pas de vainqueur au premier tour et pas de vainqueur au second tour
	Given les candidats suivants
		| Nom        | DateDeNaissance |
		| candidat 1 | Jan 1, 1999     |
		| candidat 2 | Jun 15, 1995    |
		| candidat 3 | Jan 2, 1999     |
	And le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 1              |
	| candidat 3 | 1              |
	When le scrutin est clôturé
	Then il n'y a pas de vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 50          |
	| candidat 2 | 0              | 0           |
	| candidat 3 | 1              | 50          |
	And un autre tour de scrutin est possible
	And les candidats suivants sont qualifiés
	| Nom        | 
	| candidat 1 | 
	| candidat 3 | 
	Given le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 1              |
	| candidat 3 | 1              |
	When le scrutin est clôturé
	Then le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage |
	| candidat 1 | 1              | 50          |
	| candidat 3 | 1              | 50          |
	And il n'y a pas de vainqueur
	And un autre tour de scrutin n'est pas possible

	Scenario: Scrutin majoritaire deux électeurs, pas de vainqueur au premier tour et égalité sur les 2eme et 3eme candidat
	Given les candidats suivants
	| Nom        | DateDeNaissance |
	| candidat 1 | Jan 1, 1999     |
	| candidat 2 | Jun 15, 1995    |
	| candidat 3 | Jan 2, 1999     |
	And le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 2              |
	| candidat 2 | 3              |
	| candidat 3 | 2              |
	When le scrutin est clôturé
	Then il n'y a pas de vainqueur
	And le résultat du scrutin est le suivant
	| Nom        | Nombre de vote | pourcentage        |
	| candidat 1 | 2              | 28.57142857142857  |
	| candidat 2 | 3              | 42.857142857142854 |
	| candidat 3 | 2              | 28.57142857142857  |
	And un autre tour de scrutin est possible
	And les candidats suivants sont qualifiés
	| Nom        | 
	| candidat 1 | 
	| candidat 2 | 

Scenario: Scrutin majoritaire un électeur et un vainqueur, gestion des votes blancs ou nuls
	Given les candidats suivants
	| Nom        | DateDeNaissance |
	| candidat 1 | Jan 1, 1999     |
	| candidat 2 | Jun 15, 1995    |
	And le tour de scrutin est ouvert
	And le vote des electeurs est le suivant
	| Nom        | Nombre de vote |
	| candidat 1 | 1              |
	|            | 1              |
	| adcve      | 1              |
	When le scrutin est clôturé
	Then il y a un vainqueur
	And "candidat 1" est désigné comme vainqueur
	And le résultat du scrutin est le suivant
	| Nom            | Nombre de vote | pourcentage |
	| candidat 1     | 1              | 100         |
	| candidat 2     | 0              | 0           |
	And il y a 2 votes blancs ou nuls