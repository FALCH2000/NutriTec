using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Model
{
    public class ConsumoDiario
    {
		public string fecha { get; set; }
		public string almuerzo { get; set; }
		public string cena { get; set; }
		public string desayuno { get; set; }
		public string merienda_manana { get; set; }
		public string merienda_tarde { get; set; }
		public int consumo_calorias { get; set; }
		public int cedula_paciente { get; set; }
	}
}
