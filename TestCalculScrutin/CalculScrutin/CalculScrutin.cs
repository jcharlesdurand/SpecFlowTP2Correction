using System;
using System.Collections.Generic;
using System.Linq;

namespace CalculScrutinLibrary
{
    public class CalculScrutin
    {
        private bool _scrutinOuvert;
        private int _nombreDeVotesTotal;
        

        public CalculScrutin(List<string> candidats)
        {
            this.Candidats = new Dictionary<string, Candidat>();
            foreach (var candidat in candidats)
            {
                this.Candidats.Add(candidat, new Candidat(candidat));
            }

            this._nombreDeVotesTotal = 0;
            this.Vainqueur = null;
            this._scrutinOuvert = true;
        }

        public Candidat Vainqueur { get; private set; }
        public Dictionary<string, Candidat> Candidats { get; private set; }

        public void AjoutVote(string candidat)
        {
            if (this._scrutinOuvert)
            {
                this.Candidats[candidat].AjoutUnVote();
                this._nombreDeVotesTotal += 1;
            }
        }

        public void ClotureDuVote()
        {
            this._scrutinOuvert = false;
            this.CalculDuResultat();
        }

        private void CalculDuResultat()
        {
            foreach (Candidat candidat in this.Candidats.Values)
            {
                candidat.CalculPourcentage(_nombreDeVotesTotal);
            }

            Vainqueur = this.Candidats.Values.SingleOrDefault(_ => _.Pourcentage > 50.0);
        }
    }
}
