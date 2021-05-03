using CalculScrutinLibrary;
using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Text;

namespace CalculScrutinLibrary
{
    internal class ResultatIndividuelComparer : Comparer<ResultatIndividuel>
    {
        public override int Compare([AllowNull] ResultatIndividuel x, [AllowNull] ResultatIndividuel y)
        {
            if (x.Pourcentage == y.Pourcentage)
            {
                TimeSpan age1 = DateTime.Now - x.Candidat.DateDeNaissance;
                TimeSpan age2 = DateTime.Now - y.Candidat.DateDeNaissance;
                return age1.CompareTo(age2);
            }
            else
            {
                return x.Pourcentage.CompareTo(y.Pourcentage);
            }
        }
    }
}
