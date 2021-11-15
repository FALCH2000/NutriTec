using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class ProductoNuevoReceta
    {
        /**
         * Clase para definir un producto nuevo de una receta 
         * @author Armando Fallas
         */
        public string nombre { get; set; }
        public string producto { get; set; }
        public int porcion { get; set; }
    }
}
