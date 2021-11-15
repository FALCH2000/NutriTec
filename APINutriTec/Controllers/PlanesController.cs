using APINutriTec.Model;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;


/*
 * Controlador de planes
 * @author Harold Espinoza 
 * @author Armando Fallas
 * 
 */
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

        /**
         * Metodo de tipo Get que retorna los planes creados por cierto nutricionista
         * @param codigo nutricionista que se busca
         * @return booleano con el resultado de la operacion
         */
        [HttpGet("nut/{codigo}")]
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

        /**
         * Metodo de tipo Get que obtiene un plan por su nombre
         * @return booleano con el resultado de la operacion
         */
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


        [HttpPost("insertplan")]
        public async Task<IActionResult> InsertPlan([FromBody] Plan plan)
        {
            if (plan == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "InsertPlan";
            sqlCmd.Parameters.AddWithValue("@nombre", plan.nombre);
            sqlCmd.Parameters.AddWithValue("@desayuno", plan.desayuno);
            sqlCmd.Parameters.AddWithValue("@merienda_manana", plan.merienda_manana);
            sqlCmd.Parameters.AddWithValue("@almuerzo", plan.almuerzo);
            sqlCmd.Parameters.AddWithValue("@cena", plan.cena);
            sqlCmd.Parameters.AddWithValue("@merienda_tarde", plan.merienda_tarde);
            sqlCmd.Parameters.AddWithValue("@nutricionista", plan.nutricionista);

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();



            return Created("created", created);
        }

        /**
         * Metodo de tipo Put que actualiza los datos de un plan
         * @return booleano con el resultado de la operacion
         */
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

        /**
         * Metodo de tipo Delete que elimina un plan por su nombre
         * @param codigo nutricionista que se busca
         * @return booleano con el resultado de la operacion
         */
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

        /**
         * Metodo de tipo Post que asigna un plan a un paciente
         * @return booleano con el resultado de la operacion
         */
        [HttpPost("asignar")]
        public async Task<IActionResult> Asignarplan([FromBody] PlanPPanciente plan)
        {
            if (plan == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "AsignarPlanAPaciente";
            sqlCmd.Parameters.Add("@cedula", SqlDbType.VarChar, 50).Value = plan.cedula;
            sqlCmd.Parameters.Add("@nombre_plan", SqlDbType.VarChar, 120).Value = plan.nombre_plan;
            sqlCmd.Parameters.Add("@inicio", SqlDbType.VarChar, 120).Value = plan.periodo_inicio;
            sqlCmd.Parameters.Add("@fin", SqlDbType.VarChar, 120).Value = plan.periodo_fin;

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();



            return Created("created",created);
        }

        //agregar producto 
        [HttpPost("NuevoProductoPlan/insert")]
        public async Task<IActionResult> InsertarNuevaProductoPlan([FromBody] List<AgregarProPlan> producto)
        {
            SqlDataReader reader = null;

            foreach (AgregarProPlan r in producto)
            {
                SqlConnection myConnection = new SqlConnection(cadenaConexion);


                SqlCommand sqlCmd = new SqlCommand();

                sqlCmd.Connection = myConnection;

                sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCmd.CommandText = "AgregarProductoPlan ";
                sqlCmd.Parameters.AddWithValue("@NombrePlan", r.nombre);
                sqlCmd.Parameters.AddWithValue("@Producto", r.producto);



                myConnection.Open();

                var created = sqlCmd.ExecuteNonQuery();

                myConnection.Close();

            }



            return Created("Agregado", 1);
        }

    }
}
