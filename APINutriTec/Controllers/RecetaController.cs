using Microsoft.AspNetCore.Mvc;
using APINutriTec.Model;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;


/*
 * Controlador de planes
 * @author Armando Fallas
 * 
 */
namespace APINutriTec.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RecetaController : Controller
    {
        String cadenaConexion;
        public RecetaController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";

        }

        /**
         * Metodo de tipo Get que retorna los productos que se le asignaron a un paciente
         * @return Lista de productos del paciente
         */
        [HttpGet("ProducPaciente/{email}")]
        public async Task<List<string>> TodosLosProductosPaciente(string email)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductosDePaciente";
            sqlCmd.Parameters.AddWithValue("@Email", email);

            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();

          



            return lista;
        }

        /**
         * Metodo de tipo Get obtiene el producto por el nombre
         * @param email del paciente
         * @param nombre del producto
         * @return lista solicitada
         */
        [HttpGet("ProductoFiltroNombre/{email}/{nombre}")]
        public async Task<List<string>> ProductosFiltroNombre(string email, string nombre)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductosPlanPorNombre";
            sqlCmd.Parameters.AddWithValue("@Email", email);
            sqlCmd.Parameters.AddWithValue("@nombre", nombre);


            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();





            return lista;
        }

        /**
         * Metodo de tipo Get obtiene el producto por el codigo
         * @param codigo codigo de barras del producto
         * @param nombre del producto
         * @return lista solicitada
         */
        [HttpGet("ProductoFiltroCodigo/{email}/{codigo}")]
        public async Task<List<string>> ProductosFiltroCodigo(string email, string codigo)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductosPlanPorCodigo";
            sqlCmd.Parameters.AddWithValue("@Email", email);
            sqlCmd.Parameters.AddWithValue("@codigo", codigo);


            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();





            return lista;
        }

        /**
         * Metodo de tipo Get obtiene la receta por el nombre
         * @param email del paciente
         * @param nombre del producto
         * @return lista solicitada
         */
        [HttpGet("RecetaFiltroNombre/{email}/{nombre}")]
        public async Task<List<string>> RecetaFiltronombre(string email, string nombre)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetNombreRecetasPorNombre";
            sqlCmd.Parameters.AddWithValue("@Email", email);
            sqlCmd.Parameters.AddWithValue("@Nombre", nombre);


            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();





            return lista;
        }

        /**
         * Metodo de tipo Get que retorna las recetas de un paciente
         * @param email del paciente consultado
         * @return Lista de productos almacenados
         */
        [HttpGet("RecetasPaciente/{email}")]
        public async Task<List<string>> TodosLasRecetasPaciente(string email)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetRecetasPaciente";
            sqlCmd.Parameters.AddWithValue("@Email", email);

            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();


            return lista;
        }


        /**
         * Metodo de tipo Delete que elimina una receta
         * @return codigo con el resultado de la operacion
         */
        [HttpPost("delete")]
        public async Task<IActionResult> BorrarReceta([FromBody] Receta receta)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            // myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = myConnection;


            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "BorrarReceta ";
            sqlCmd.Parameters.AddWithValue("@Email", receta.email);
            sqlCmd.Parameters.AddWithValue("@NombreReceta", receta.nombre);

            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();

            return NoContent();
        }

        /**
         * Metodo de tipo Get que retorna productos que contiene una receta
         * @param nombre de la receta buscada
         * @return Lista de productos
         */
        [HttpGet("ProducReceta/{nombre}")]
        public async Task<List<string>> ProductosReceta(string nombre)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.Connection = myConnection;



            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductoPorReceta";
            sqlCmd.Parameters.AddWithValue("@NombreReceta", nombre);

            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<string> lista = new List<string>();

            while (reader.Read())
            {

                string Strlista = reader.GetValue(0).ToString();



                lista.Add(Strlista);


            }
            myConnection.Close();





            return lista;
        }


        /**
         * Metodo de tipo Post que ingresa un nuevo registro
         * @return codigo resultado de la operacion
         */
        [HttpPost("registro/insert")]
        public async Task<IActionResult> InsertarRegistro([FromBody] List<Registro> registro)
        {
            SqlDataReader reader = null;
            


            foreach (Registro r in registro)
            {
                SqlConnection myConnection = new SqlConnection(cadenaConexion);


                SqlCommand sqlCmd = new SqlCommand();

                sqlCmd.Connection = myConnection;

                sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCmd.CommandText = "RegistroDiario";
                sqlCmd.Parameters.AddWithValue("@Email", r.email);
                sqlCmd.Parameters.AddWithValue("@Producto", r.producto);
                sqlCmd.Parameters.AddWithValue("@Horario", r.horario);


                myConnection.Open();

                var created = sqlCmd.ExecuteNonQuery();

                myConnection.Close();

            }



            return Created("Agregado", 1);
        }

        /**
         * Metodo de tipo Post que ingresa una nueva receta
         * @return codigo resultado de la operacion
         */
        [HttpPost("NuevaReceta/insert")]
        public async Task<IActionResult> InsertarNuevaReceta([FromBody] List<NuevaReceta> receta)
        {
            SqlDataReader reader = null;

            foreach (NuevaReceta r in receta)
            {
                SqlConnection myConnection = new SqlConnection(cadenaConexion);


                SqlCommand sqlCmd = new SqlCommand();

                sqlCmd.Connection = myConnection;

                sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCmd.CommandText = "AgregarReceta";
                sqlCmd.Parameters.AddWithValue("@Email", r.email);
                sqlCmd.Parameters.AddWithValue("@NombreReceta", r.nombre);
                sqlCmd.Parameters.AddWithValue("@TamanoPorcion", r.tamano);
                sqlCmd.Parameters.AddWithValue("@Producto", r.producto);



                myConnection.Open();

                var created = sqlCmd.ExecuteNonQuery();

                myConnection.Close();

            }



            return Created("Agregado", 1);
        }

        /**
         * Metodo de tipo Post que ingresa un producto en una receta
         * @return codigo resultado de la operacion
         */
        [HttpPost("NuevoProdcutoReceta/insert")]
        public async Task<IActionResult> InsertarNuevaProductoReceta([FromBody] List<ProductoNuevoReceta> receta)
        {
            SqlDataReader reader = null;

            foreach (ProductoNuevoReceta r in receta)
            {
                SqlConnection myConnection = new SqlConnection(cadenaConexion);


                SqlCommand sqlCmd = new SqlCommand();

                sqlCmd.Connection = myConnection;

                sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCmd.CommandText = "AgregarProdRecetaNuevo";
                sqlCmd.Parameters.AddWithValue("@NombreReceta", r.nombre);
                sqlCmd.Parameters.AddWithValue("@Producto", r.producto);
                sqlCmd.Parameters.AddWithValue("@Porcion", r.porcion);



                myConnection.Open();

                var created = sqlCmd.ExecuteNonQuery();

                myConnection.Close();

            }



            return Created("Agregado", 1);
        }
        
        /**
         * Metodo de tipo Delete que elimina un producto de una receta
         * @return codigo resultado de la operacion
         */
        [HttpPost("BorrarProdcutoReceta/delete")]
        public async Task<IActionResult> BorrarProductoReceta([FromBody] List<ProductoNuevoReceta> receta)
        {
            SqlDataReader reader = null;

            foreach (ProductoNuevoReceta r in receta)
            {
                SqlConnection myConnection = new SqlConnection(cadenaConexion);


                SqlCommand sqlCmd = new SqlCommand();

                sqlCmd.Connection = myConnection;

                sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlCmd.CommandText = "[BorrarProdReceta]";
                sqlCmd.Parameters.AddWithValue("@NombreReceta", r.nombre);
                sqlCmd.Parameters.AddWithValue("@ProductoBorrado", r.producto);



                myConnection.Open();

                var created = sqlCmd.ExecuteNonQuery();

                myConnection.Close();

            }



            return Created("Borrado", 1);
        }

        /**
         * Metodo de tipo Get obtiene la procion de una receta de un paciente
         * @param nombre de la receta buscada
         * @return Lista de productos
         */
        [HttpGet("porcionReceta/{email}/{nombre}")]
        public async Task<string> Porcion(string email, string nombre)
        {
            SqlDataReader reader = null;

            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            // myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = myConnection;


            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPorcionReceta ";
            sqlCmd.Parameters.AddWithValue("@Email", email);
            sqlCmd.Parameters.AddWithValue("@Nombre", nombre);

            myConnection.Open();
            // sqlCmd.ExecuteNonQuery();

            reader = sqlCmd.ExecuteReader();

            string dato = "";

            while (reader.Read())
            {

                dato = reader.GetValue(0).ToString();

            }

            myConnection.Close();




            return dato;
        }

    }
}
