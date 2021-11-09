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

        public List<Plan> GetPlanesNut(string codigo)
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
        
        [HttpGet("plan")]
        //Obtiene un plan por su nombre
        public Plan Getplan([FromBody]Texto nombre)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPlan";
            sqlCmd.Parameters.Add("@nombre", SqlDbType.VarChar, 50).Value = nombre.texto;
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            Usuario nut = new Usuario();
            Plan plan = new Plan();
            while (reader.Read())
            {

                plan.nombre = reader.GetValue(0).ToString();
                plan.desayuno = reader.GetValue(1).ToString();
                plan.merienda_manana = reader.GetValue(2).ToString();
                plan.almuerzo = reader.GetValue(3).ToString();
                plan.cena = reader.GetValue(4).ToString();
                plan.merienda_tarde = reader.GetValue(5).ToString();
                plan.nutricionista = reader.GetValue(6).ToString();
            }
            myConnection.Close();

            return plan;
        }

        [HttpPut("edit")]
        public async Task<IActionResult> UpdatePlan([FromBody] Plan plan) 
        {
            if (plan == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "UpdatePlan";
            sqlCmd.Parameters.Add("@nombre", SqlDbType.VarChar, 50).Value = plan.nombre;
            sqlCmd.Parameters.Add("@desayuno", SqlDbType.VarChar, 120).Value = plan.desayuno;
            sqlCmd.Parameters.Add("@merienda_manana", SqlDbType.VarChar, 120).Value = plan.merienda_manana;
            sqlCmd.Parameters.Add("@almuerzo", SqlDbType.VarChar, 120).Value = plan.almuerzo;
            sqlCmd.Parameters.Add("@cena", SqlDbType.VarChar, 120).Value = plan.cena;
            sqlCmd.Parameters.Add("@merienda_tarde", SqlDbType.VarChar, 120).Value = plan.merienda_tarde;
            sqlCmd.Parameters.Add("@nutricionista", SqlDbType.VarChar, 20).Value = plan.nutricionista;
            
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            
            return Ok();
        }

        [HttpDelete("delete")]
        public async Task<IActionResult> DeletePlan([FromBody] Texto nombre) 
        {
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "DeletePlan";
            sqlCmd.Parameters.Add("@nombre", SqlDbType.VarChar, 50).Value = nombre.texto;

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();

            return NoContent();
        }

    }
}
