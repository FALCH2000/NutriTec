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
    public class ProductoController : Controller
    {
        String cadenaConexion;
        public ProductoController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

        /**
         * Metodo de tipo Get que retorna los productos existentes
         * @return Lista de productos almacenados
         */
        [HttpGet]
        public List<Producto> GetProductos()
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductos";

            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Producto> productos = new List<Producto>();

            while (reader.Read())
            {
                Producto pdto = new Producto();

                pdto.codigo_de_barras = reader.GetValue(0).ToString();
                pdto.descripcion = reader.GetValue(1).ToString();
                pdto.tamano_porcion = (int)reader.GetValue(2);
                pdto.energia = (int)reader.GetValue(3);
                pdto.grasa = (int)reader.GetValue(4);
                pdto.sodio = (int)reader.GetValue(5);
                pdto.carbohidrato = (int)reader.GetValue(6);
                pdto.proteina = (int)reader.GetValue(7);
                pdto.calcio = (int)reader.GetValue(8);
                pdto.estado = reader.GetValue(9).ToString();
                pdto.hierro = (int)reader.GetValue(10);


                productos.Add(pdto);

            }
            myConnection.Close();

            return productos;


        }


        [HttpGet("estado/{estado}")]
        public List<Producto> GetProductosXestado(string estado)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProductosXEstado";
            sqlCmd.Parameters.AddWithValue("@estado", estado);

            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Producto> productos = new List<Producto>();

            while (reader.Read())
            {
                Producto pdto = new Producto();

                pdto.codigo_de_barras = reader.GetValue(0).ToString();
                pdto.descripcion = reader.GetValue(1).ToString();
                pdto.tamano_porcion = (int)reader.GetValue(2);
                pdto.energia = (int)reader.GetValue(3);
                pdto.grasa = (int)reader.GetValue(4);
                pdto.sodio = (int)reader.GetValue(5);
                pdto.carbohidrato = (int)reader.GetValue(6);
                pdto.proteina = (int)reader.GetValue(7);
                pdto.calcio = (int)reader.GetValue(8);
                pdto.estado = reader.GetValue(9).ToString();
                pdto.hierro = (int)reader.GetValue(10);


                productos.Add(pdto);

            }
            myConnection.Close();

            return productos;


        }


        /**
         * Metodo de tipo Get que retorna un producto buscado por su codigo de barras
         * @param codigo del producto solicitado
         * @return producto buscado
         */
        [HttpGet("pdto/{codigo}")]
        public Producto GetProducto(string codigo) 
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetProducto";
            sqlCmd.Parameters.AddWithValue("@codigo", codigo);
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            Producto pdto = new Producto();

            while (reader.Read())
            {

                pdto.codigo_de_barras = reader.GetValue(0).ToString();
                pdto.descripcion = reader.GetValue(1).ToString();
                pdto.tamano_porcion = (int)reader.GetValue(2);
                pdto.energia = (int)reader.GetValue(3);
                pdto.grasa = (int)reader.GetValue(4);
                pdto.sodio = (int)reader.GetValue(5);
                pdto.carbohidrato = (int)reader.GetValue(6);
                pdto.proteina = (int)reader.GetValue(7);
                pdto.calcio = (int)reader.GetValue(8);
                pdto.estado = reader.GetValue(9).ToString();
                pdto.hierro = (int)reader.GetValue(10);
            }
            myConnection.Close();

            return pdto;

        }

        /**
         * Metodo de tipo Post que ingresa un nuevo producto
         * @return codigo resultado de la operacion
         */
        [HttpPost("insert")]
        public async Task<IActionResult> Createproducto([FromBody] Producto pdto)
        {
            if (pdto == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "InsertProducto";
            sqlCmd.Parameters.AddWithValue("@codigo_de_barras", pdto.codigo_de_barras);
            sqlCmd.Parameters.AddWithValue("@descripcion", pdto.descripcion);
            sqlCmd.Parameters.AddWithValue("@tamano_porcion", pdto.tamano_porcion);
            sqlCmd.Parameters.AddWithValue("@energia", pdto.energia);
            sqlCmd.Parameters.AddWithValue("@grasa", pdto.grasa);
            sqlCmd.Parameters.AddWithValue("@sodio", pdto.sodio);
            sqlCmd.Parameters.AddWithValue("@carbohidrato", pdto.carbohidrato);
            sqlCmd.Parameters.AddWithValue("@proteina", pdto.proteina);
            sqlCmd.Parameters.AddWithValue("@calcio", pdto.calcio);
            sqlCmd.Parameters.AddWithValue("@estado", pdto.estado);
            sqlCmd.Parameters.AddWithValue("@hierro", pdto.hierro);

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return Created("created", created);
        }

        /**
         * Metodo de tipo Put que cambia el estado de aprovacion de un producto
         * @param codigo del producto a cambiar
         * @param estado que se se va a asignar al producto
         * @return codigo resultado de la operacion
         */
        [HttpPut("aprovacion/{codigo}/{estado}")]
        public async Task<IActionResult> AprovPdto(string codigo, string estado) 
        {
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "AprovacionProducto";
            sqlCmd.Parameters.AddWithValue("@codigo", codigo);
            sqlCmd.Parameters.AddWithValue("@estado", estado);

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();

            return Ok();
        }


    }
}
