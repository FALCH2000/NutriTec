using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class RangoMedida
    {
        /**
         * Clase para establecer el rango de fechas para las medidas de un paciente
         * @author Harold Espinoza
         */
        public string fecha_inicio { get; set; }
        public string fecha_final { get; set; }
        public int cedula { get; set; }
    }
}
