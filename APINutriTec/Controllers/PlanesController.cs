using APINutriTec.Model;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace APINutriTec.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PlanesController : Controller
    {
        String cadenaConexion;
        public PlanesController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

        [HttpGet("nut/{codigo}")]
        // Get: api/usuario todos los usuarios

        public List<Plan> Get(string codigo)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPlanesDeNutri";
            sqlCmd.Parameters.Add("@Codigo", SqlDbType.VarChar, 20).Value = codigo;
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Plan> planes = new List<Plan>();

            while (reader.Read())
            {
                Plan plan = new Plan();

                plan.nombre = reader.GetValue(0).ToString();
                plan.desayuno = reader.GetValue(1).ToString();
                plan.merienda_manana = reader.GetValue(2).ToString();
                plan.almuerzo = reader.GetValue(3).ToString();
                plan.cena = reader.GetValue(4).ToString();
                plan.merienda_tarde = reader.GetValue(5).ToString();
                plan.nutricionista = reader.GetValue(6).ToString();
                

                planes.Add(plan);

            }
            myConnection.Close();

            return planes;
        }
    }
}
