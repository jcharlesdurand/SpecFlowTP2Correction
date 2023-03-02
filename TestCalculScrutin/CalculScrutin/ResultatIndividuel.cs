using System;
using System.Collections.Generic;
using System.Text;

namespace CalculScrutinLibrary
{
    public class ResultatIndividuel
    {
        public ResultatIndividuel(Candidat candidat)
        {
            this.Candidat = candidat;
            this.NbVotes = 0;
            this.Pourcentage = 0.0;
        }

        internal void AjoutVotes(int nombreDeVoix)
        {
            this.NbVotes += nombreDeVoix;
        }

        internal void CalculPourcentage(int nbDeVotesTotal)
        {
            this.Pourcentage = Math.Round((this.NbVotes / (double)nbDeVotesTotal) * 100.0, 2);
        }

        public Candidat Candidat { get; private set; }
        public int NbVotes { get; private set; }
        public double Pourcentage { get; private set; }
    }
}
