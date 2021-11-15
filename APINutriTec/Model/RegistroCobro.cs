using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class RegistroCobro
    {
        /**
         * Clase para definir el registro de cobro
         * @author Harold Espinoza
         */
        public string tipo_cobro { get; set; }
        public string codigo_nutricionista { get; set; }
        public string email { get; set; }
        public string nombre1 { get; set; }
        public string nombre2 { get; set; }
        public string apellido1 { get; set; }
        public string apellido2 { get; set; }
        public int numero_tarjeta { get; set; }
        public int cantidad_pacientes { get; set; }
        public int monto_total { get; set; }
        public int descuento { get; set; }
        public double monto_cobro { get; set; }
    }
}
