using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class NuevaReceta
    {
        /**
         * Clase para definir una nueva receta
         * @author Armando Fallas
         */
        public string email { get; set; }
        public string nombre { get; set; }
        public int tamano { get; set; }
        public string producto { get; set; }
    }
}
