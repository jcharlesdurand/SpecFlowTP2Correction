using System;
using System.Collections.Generic;
using System.Text;

namespace CalculScrutinLibrary
{
    public class ResultatIndividuel
    {
        public ResultatIndividuel(string nom)
        {
            this.Nom = nom;
            this.NbVotes = 0;
            this.Pourcentage = 0.0;
        }

        internal void AjoutUnVote()
        {
            this.NbVotes += 1;
        }

        internal void CalculPourcentage(int nbDeVotesTotal)
        {
            this.Pourcentage = (this.NbVotes / (double)nbDeVotesTotal) * 100.0;
        }

        public string Nom { get; private set; }
        public int NbVotes { get; private set; }
        public double Pourcentage { get; private set; }
    }
}
