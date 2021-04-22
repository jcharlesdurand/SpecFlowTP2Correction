using System;
using System.Collections.Generic;
using System.Text;

namespace CalculScrutinLibrary
{
    public class Candidat
    {
        public Candidat(string nom)
        {
            this.Nom = nom;
            this.NbVotes = 0;
            this.Pourcentage = 0.0;
        }

        internal void AjoutUnVote()
        {
            this.NbVotes =+ 1;
        }

        internal void CalculPourcentage(int nbDeVotesTotal)
        {
            this.Pourcentage = (this.NbVotes / nbDeVotesTotal) * 100;
        }

        public string Nom { get; private set; }
        public int NbVotes { get; private set; }
        public double Pourcentage { get; private set; }
    }
}
