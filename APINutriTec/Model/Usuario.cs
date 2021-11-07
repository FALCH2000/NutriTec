using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class Usuario
    {
        public string nombre1 { get; set; }
        public string nombre2 { get; set; }
        public string apellido1 { get; set; }
        public string apellido2 { get; set; }
        public int cedula { get; set; }
        public string fecha_de_nacimiento { get; set; }
        public int edad { get; set; }
        public string codigo_nutricionista { get; set; }
        public string pass { get; set; }
        public string email { get; set; }
        public int numero_tarjeta { get; set; }
        public string tipo_cobro { get; set; }
        public string rol { get; set; }
        public string direccion { get; set; }
        public string foto { get; set; }
    }
}
