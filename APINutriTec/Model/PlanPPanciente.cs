using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class PlanPPanciente
    {
        /**
         * Clase para definir los planes por paciente 
         * @author Harold Espinoza
         */
        public int cedula { get; set; }
        public string nombre_plan { get; set; }
        public string periodo_inicio { get; set; }
        public string periodo_fin { get; set; }
    }
}
