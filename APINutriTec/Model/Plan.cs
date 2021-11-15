using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class Plan
    {
        /**
         * Clase para definir los planes
         * @author Harold Espinoza
         */
        public string nombre { get; set; }
        public string desayuno { get; set; }
        public string merienda_manana { get; set; }
        public string almuerzo { get; set; }
        public string cena { get; set; }
        public string merienda_tarde { get; set; }
        public string nutricionista { get; set; }
    }
}
