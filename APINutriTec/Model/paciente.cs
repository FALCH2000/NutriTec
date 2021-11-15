using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class paciente
    {
        /**
         * Clase para definir los pacientes 
         * @author Armando Fallas
         */
        public string nombre1 { get; set; }
        public string nombre2 { get; set; }
        public string apellido1 { get; set; }
        public string apellido2 { get; set; }
        public int cedula { get; set; }
        public string fecha_de_nacimiento { get; set; }
        public double peso { get; set; }
        public string estado { get; set; }
        public int edad { get; set; }
        public string pass { get; set; }
        public string email { get; set; }
        public int imc { get; set; }
        public string pais { get; set; }
        public string codigo_nutricionista { get; set; }

    }
}
