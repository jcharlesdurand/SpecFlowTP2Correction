using System;
using System.Collections.Generic;
using System.Linq;

namespace CalculScrutinLibrary
{
    public class CalculScrutin
    {
        private bool _scrutinOuvert;
        private int _nombreDeVotesTotal;
        private int _tourDeScrutin;
        
        public CalculScrutin(List<Candidat> candidats)
        {
            this.Candidats = new List<Candidat>(candidats);
            _tourDeScrutin = 0;
            this.EnAttenteProchainTour = true;
        }

        public ResultatIndividuel Vainqueur { get; private set; }
  
        public List<ResultatIndividuel> Resultats { get; private set; }

        public int VotesBlancsOuNuls { get; private set; }

        public List<Candidat> Candidats{ get; private set; }
        public bool EnAttenteProchainTour { get; private set; }

        public void AjoutVote(string candidat)
        {
            if (this._scrutinOuvert)
            {
                ResultatIndividuel resultat = this.Resultats.SingleOrDefault(_ => _.Candidat.Nom == candidat);
                if (resultat != null)
                {
                    resultat.AjoutUnVote();
                    this._nombreDeVotesTotal += 1;
                }
                else
                {
                    this.VotesBlancsOuNuls += 1;
                }
            }
        }

        public void OuvertureDuScrutin()
        {
            if (!this.EnAttenteProchainTour)
            {
                return;
            }

            this.EnAttenteProchainTour = false;
            this._tourDeScrutin++;
            this.Resultats = new List<ResultatIndividuel>();
            foreach (var candidat in this.Candidats)
            {
                this.Resultats.Add(new ResultatIndividuel(candidat));
            }
            
            this._nombreDeVotesTotal = 0;
            this.VotesBlancsOuNuls = 0;
            this._scrutinOuvert = true;
        }

        public void ClotureDuVote()
        {
            this._scrutinOuvert = false;
            this.CalculDuResultat();
        }
        private void CalculDuResultat()
        {
            foreach (ResultatIndividuel resultat in this.Resultats)
            {
                resultat.CalculPourcentage(_nombreDeVotesTotal);
            }

            this.Vainqueur = this.Resultats.SingleOrDefault(_ => _.Pourcentage > 50.0);
            if (this.Vainqueur == null && this._tourDeScrutin == 1)
            {
                this.EnAttenteProchainTour = true;
                this.Candidats = this.Resultats.OrderBy(_ => _.Pourcentage).TakeLast(2).Select(_ => _.Candidat).ToList();
            }
            else
            {
                this.EnAttenteProchainTour = false;
            }
        }
    }
}
