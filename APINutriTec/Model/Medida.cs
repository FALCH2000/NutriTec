using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class Medida
    {
        /**
         * Clase para definir las medidas 
         * @author Harold Espinoza
         */
        public string fecha_ingreso { get; set; }
        public int cadera { get; set; }
        public int cintura { get; set; }
        public int cuello { get; set; }
        public int peso { get; set; }
        public int musculo { get; set; }
        public int grasa { get; set; }
        public int cedula_paciente { get; set; }

    }
}
