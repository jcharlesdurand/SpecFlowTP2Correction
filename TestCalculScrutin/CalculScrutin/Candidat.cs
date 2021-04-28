using System;
using System.Collections.Generic;
using System.Text;

namespace CalculScrutinLibrary
{
    public class Candidat
    {
        public Candidat(string nom, DateTime dateDeNaissance)
        {
            this.Nom = nom;
            this.DateDeNaissance = dateDeNaissance;
        }

        public string Nom { get; private set; }
        public DateTime DateDeNaissance { get; set; }
    }
}
