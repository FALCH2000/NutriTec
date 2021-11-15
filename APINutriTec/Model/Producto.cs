using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class Producto
    {
        /**
         * Clase para definir los productos 
         * @author Harold Espinoza
         */
        public string codigo_de_barras { get; set; }
        public string descripcion { get; set; }
        public int tamano_porcion { get; set; }
        public int energia { get; set; }
        public int grasa { get; set; }
        public int sodio { get; set; }
        public int carbohidrato { get; set; }
        public int proteina { get; set; }
        public int calcio { get; set; }
        public string estado { get; set; }
        public int hierro { get; set; }
    }
}
