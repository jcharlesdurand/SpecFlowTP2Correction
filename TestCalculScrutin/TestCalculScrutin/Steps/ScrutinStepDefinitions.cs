﻿using CalculScrutinLibrary;
using System.Collections.Generic;
using TechTalk.SpecFlow;
using System.Linq;
using FluentAssertions;
using System;

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
            List<Candidat> candidats = new List<Candidat>();
            foreach (TableRow row in table.Rows)
            {
                candidats.Add(new Candidat(row[0], DateTime.Parse(row[1])));
            }

            this._calculScrutin = new CalculScrutin(candidats);
        }

        [Given(@"le tour de scrutin est ouvert")]
        public void GivenLeScrutinEstOuvert()
        {
            this._calculScrutin.OuvertureDuScrutin();
        }

        [Given(@"le vote des electeurs est le suivant")]
        public void GivenLeVoteDesElecteursEstLeSuivant(Table table)
        {
            foreach (TableRow row in table.Rows)
            {
                this._calculScrutin.AjoutVotes(row[0], int.Parse(row[1]));
            }
        }

        [When(@"le scrutin est clôturé")]
        public void WhenLeScrutinEstCloture()
        {
            this._calculScrutin.ClotureDuVote();
        }

        [Then(@"il y a un vainqueur")]
        public void ThenIlYAUnVainqueur()
        {
            this._calculScrutin.Vainqueur.Should().NotBeNull();
        }

        [Then(@"il n'y a pas de vainqueur")]
        public void ThenIlNyAPasDeVainqueur()
        {
            this._calculScrutin.Vainqueur.Should().BeNull();
        }

        [Then(@"""(.*)"" est désigné comme vainqueur")]
        public void ThenEstDesigneCommeVainqueur(string candidat)
        {
            this._calculScrutin.Vainqueur.Candidat.Nom.Should().Be(candidat);            
        }

        [Then(@"le résultat du scrutin est le suivant")]
        public void ThenLeResultatDuScrutinEstLeSuivant(Table table)
        {
            foreach (TableRow row in table.Rows)
            {
                string nom = row["Nom"];
                ResultatIndividuel resultat = this._calculScrutin.Resultats.Single(_ => _.Candidat.Nom == nom);
                resultat.Pourcentage.Should().Be(double.Parse(row["pourcentage"]));
                resultat.NbVotes.Should().Be(int.Parse(row["Nombre de vote"]));
            }
        }

        [Then(@"un autre tour de scrutin est possible")]
        public void ThenUnAutreTourDeScrutinEstPossible()
        {
            this._calculScrutin.EnAttenteProchainTour.Should().BeTrue();
        }

        [Then(@"un autre tour de scrutin n'est pas possible")]
        public void ThenUnAutreTourDeScrutinNEstPasPossible()
        {
            this._calculScrutin.EnAttenteProchainTour.Should().BeFalse();
        }

        [Then(@"les candidats suivants sont qualifiés")]
        public void ThenLesCandidatsSuivantsSontQualifies(Table table)
        {
            this._calculScrutin.Candidats.Count.Should().Be(table.RowCount);
            foreach (TableRow row in table.Rows)
            {
                this._calculScrutin.Candidats.SingleOrDefault(_ => _.Nom == row[0]);
            }
        }

        [Then(@"il y a (.*) votes blancs ou nuls")]
        public void ThenIlYAVotesBlancsOuNuls(int nombreDeVotesBlancsOuNuls)
        {
            this._calculScrutin.VotesBlancsOuNuls.Should().Be(nombreDeVotesBlancsOuNuls);
        }
    }
}
