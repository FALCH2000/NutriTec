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
    public class UsuarioController : Controller
    {
        
        String cadenaConexion;
        public UsuarioController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

        [HttpGet]
        // Get: api/usuario

        public List<Usuario> Get()
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = "SELECT * FROM USUARIO";
            sqlCmd.Connection = myConnection;

            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Usuario> nutricionistas = new List<Usuario>();

            while (reader.Read())
            {
                Usuario nut = new Usuario();

                nut.codigo_nutricionista = reader.GetValue(7).ToString();
                nut.nombre1 = reader.GetValue(0).ToString();
                nut.apellido1 = reader.GetValue(2).ToString();

                nutricionistas.Add(nut);

            }
            myConnection.Close();

            return nutricionistas;
        }
    }
}
