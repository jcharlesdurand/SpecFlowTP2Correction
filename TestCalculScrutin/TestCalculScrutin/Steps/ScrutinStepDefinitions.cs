using CalculScrutinLibrary;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using FluentAssertions;

namespace TestCalculScrutin.Steps
{
    [Binding]
    public sealed class ScrutinStepDefinitions
    {

        // For additional details on SpecFlow step definitions see https://go.specflow.org/doc-stepdef

        private readonly ScenarioContext _scenarioContext;

        private CalculScrutin _calculScrutin;

        public ScrutinStepDefinitions(ScenarioContext scenarioContext)
        {
            _scenarioContext = scenarioContext;
        }

        [Given(@"les candidats suivants")]
        public void GivenLesCandidatsSuivants(Table table)
        {
            List<string> candidats = new List<string>();
            foreach (TableRow row in table.Rows)
            {
                candidats.Add(row[0]);
            }

            this._calculScrutin = new CalculScrutin(candidats);
        }

        [Given(@"le vote d'un electeur est ""(.*)""")]
        public void GivenLeVoteDUnElecteurEst(string candidat)
        {
            this._calculScrutin.AjoutVote(candidat);
        }

        [When(@"le scrutin est clôturé")]
        public void WhenLeScrutinEstCloture()
        {
            this._calculScrutin.ClotureDuVote();
        }

        [Then(@"le résultat est valide")]
        public void ThenLeResultatEstValide()
        {
            this._calculScrutin.Vainqueur.Should().NotBeNull();
        }

        [Then(@"""(.*)"" est désigné comme vainqueur")]
        public void ThenEstDesigneCommeVainqueur(string candidat)
        {
            this._calculScrutin.Vainqueur.Nom.Should().Be(candidat);            
        }

        [Then(@"le résultat du scrutin est le suivant")]
        public void ThenLeResultatDuScrutinEstLeSuivant(Table table)
        {
            foreach (TableRow row in table.Rows)
            {
                string nom = row["Nom"];
                this._calculScrutin.Candidats[nom].Pourcentage.Should().Be(double.Parse(row["pourcentage"]));
                this._calculScrutin.Candidats[nom].NbVotes.Should().Be(int.Parse(row["Nombre de vote"]));
            }
        }
    }
}
