using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class Registro
    {
        /**
         * Clase para definir los registros 
         * @author Armando Fallas
         */
        public string email { get; set; }
        public string producto { get; set; }
        public string horario { get; set; }
    }
}
