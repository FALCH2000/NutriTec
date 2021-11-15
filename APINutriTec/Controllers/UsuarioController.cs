using APINutriTec.Model;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;


/*
 * Controlador de usuarios
 * @author Harold Espinoza
 * @author Armando Fallas
 * 
 */
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

        /**
         * Metodo de tipo Get que retorna una lista de los usuarios existentes
         * @return Lista de usuarios
         */
        [HttpGet]
        public List<Usuario> Get()
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetUsuarios";
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Usuario> nutricionistas = new List<Usuario>();

            while (reader.Read())
            {
                Usuario nut = new Usuario();

                nut.nombre1 = reader.GetValue(0).ToString();
                nut.nombre2 = reader.GetValue(1).ToString();
                nut.apellido1 = reader.GetValue(2).ToString();
                nut.apellido2 = reader.GetValue(3).ToString();
                nut.cedula = (int)reader.GetValue(4);
                nut.fecha_de_nacimiento = reader.GetValue(5).ToString();
                nut.edad = (int)reader.GetValue(6);
                nut.codigo_nutricionista = reader.GetValue(7).ToString();
                nut.pass = reader.GetValue(8).ToString();
                nut.email = reader.GetValue(9).ToString();
                nut.numero_tarjeta = (int)reader.GetValue(10);
                nut.tipo_cobro = reader.GetValue(11).ToString();
                nut.rol = reader.GetValue(12).ToString();
                nut.direccion = reader.GetValue(13).ToString();
                nut.foto = reader.GetValue(14).ToString();

                nutricionistas.Add(nut);

            }
            myConnection.Close();

            return nutricionistas;
        }

        /**
         * Metodo de tipo Get obtiene el registro de cobro para los nutricionistas
         * @return Listado con el registro de cobro
         */
        [HttpGet("registrocobro")]
        public List<RegistroCobro> GetRegistroCobro()
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "ReporteCobro";
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<RegistroCobro> registros = new List<RegistroCobro>();

            while (reader.Read())
            {
                RegistroCobro reg = new RegistroCobro();

                reg.tipo_cobro = reader.GetValue(0).ToString();
                reg.codigo_nutricionista = reader.GetValue(1).ToString();
                reg.email = reader.GetValue(2).ToString();
                reg.nombre1 = reader.GetValue(3).ToString();
                reg.nombre2 = reader.GetValue(4).ToString();
                reg.apellido1 = reader.GetValue(5).ToString();
                reg.apellido2 = reader.GetValue(6).ToString();
                reg.numero_tarjeta = (int)reader.GetValue(7);
                reg.cantidad_pacientes = (int)reader.GetValue(8);
                reg.monto_total = (int)reader.GetValue(9);
                reg.descuento = (int)reader.GetValue(10);
                reg.monto_cobro = (double)reader.GetValue(11);



                registros.Add(reg);

            }
            myConnection.Close();

            return registros;
        }


        /**
         * Metodo de tipo Get que obtiene un nutricionista por su codigo
         * @param codigo del nutricinista buscado
         * @return nutricionista solicitado
         */
        [HttpGet("nutri/{codigo}")]
        public Usuario GetNutri(string codigo)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetNuricionistaXcod";
            sqlCmd.Parameters.Add("@NutriCod", SqlDbType.VarChar, 20).Value = codigo;
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            Usuario nut = new Usuario();

            while (reader.Read())
            {

                nut.nombre1 = reader.GetValue(0).ToString();
                nut.nombre2 = reader.GetValue(1).ToString();
                nut.apellido1 = reader.GetValue(2).ToString();
                nut.apellido2 = reader.GetValue(3).ToString();
                nut.cedula = (int)reader.GetValue(4);
                nut.fecha_de_nacimiento = reader.GetValue(5).ToString();
                nut.edad = (int)reader.GetValue(6);
                nut.codigo_nutricionista = reader.GetValue(7).ToString();
                nut.pass = reader.GetValue(8).ToString();
                nut.email = reader.GetValue(9).ToString();
                nut.numero_tarjeta = (int)reader.GetValue(10);
                nut.tipo_cobro = reader.GetValue(11).ToString();
                nut.rol = reader.GetValue(12).ToString();
                nut.direccion = reader.GetValue(13).ToString();
                nut.foto = reader.GetValue(14).ToString();
            }
            myConnection.Close();

            return nut;
        }

        /**
         * Metodo de tipo Get que obtiene un nutricionista por su email
         * @param email del nutricinista buscado
         * @return nutricionista solicitado
         */
        [HttpGet("nutriXemail/{email}")]
        public Usuario GetNutriXemail(string email)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetNutriXEmail";
            sqlCmd.Parameters.AddWithValue("@email", email);
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            Usuario nut = new Usuario();

            while (reader.Read())
            {

                nut.nombre1 = reader.GetValue(0).ToString();
                nut.nombre2 = reader.GetValue(1).ToString();
                nut.apellido1 = reader.GetValue(2).ToString();
                nut.apellido2 = reader.GetValue(3).ToString();
                nut.cedula = (int)reader.GetValue(4);
                nut.fecha_de_nacimiento = reader.GetValue(5).ToString();
                nut.edad = (int)reader.GetValue(6);
                nut.codigo_nutricionista = reader.GetValue(7).ToString();
                nut.pass = reader.GetValue(8).ToString();
                nut.email = reader.GetValue(9).ToString();
                nut.numero_tarjeta = (int)reader.GetValue(10);
                nut.tipo_cobro = reader.GetValue(11).ToString();
                nut.rol = reader.GetValue(12).ToString();
                nut.direccion = reader.GetValue(13).ToString();
                nut.foto = reader.GetValue(14).ToString();
            }
            myConnection.Close();

            return nut;
        }

        /**
         * Metodo de tipo Post que ingresa un nuevo usuario
         * @return codigo resultado de la operacion
         */
        [HttpPost("insert")]
        public async Task<IActionResult> CreateUsuario([FromBody] Usuario user)
        {
            if (user == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();
            
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "InsertUsuario";
            sqlCmd.Parameters.AddWithValue("@nombre1", user.nombre1);
            sqlCmd.Parameters.AddWithValue("@nombre2", user.nombre2);
            sqlCmd.Parameters.AddWithValue("@apellido1", user.apellido1);
            sqlCmd.Parameters.AddWithValue("@apellido2", user.apellido2);
            sqlCmd.Parameters.AddWithValue("@cedula", user.cedula);
            sqlCmd.Parameters.AddWithValue("@fecha_de_nacimiento", DateTime.Parse(user.fecha_de_nacimiento));
            sqlCmd.Parameters.AddWithValue("@edad", user.edad);
            sqlCmd.Parameters.AddWithValue("@codigo_nutricionista", user.codigo_nutricionista);
            sqlCmd.Parameters.AddWithValue("@email", user.email);
            sqlCmd.Parameters.AddWithValue("@pass", user.pass);
            sqlCmd.Parameters.AddWithValue("@numero_tarjeta", user.numero_tarjeta);
            sqlCmd.Parameters.AddWithValue("@tipo_cobro", user.tipo_cobro);
            sqlCmd.Parameters.AddWithValue("@rol", user.rol);
            sqlCmd.Parameters.AddWithValue("@direccion", user.direccion);
            sqlCmd.Parameters.AddWithValue("@foto", user.foto);
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return Created("created",created);
        }

        /**
         * Metodo de tipo Delete que elimina un usuario por su codigo
         * @param codigo del usuario a eliminar
         * @return codigo resultado de la operacion
         */
        [HttpDelete("delete/{codigo}")]
        public async Task<IActionResult> DeleteUsuario(string codigo)
        {
            if (codigo == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "DeleteUsuario";
            sqlCmd.Parameters.Add("@Codigo", SqlDbType.VarChar, 20).Value = codigo;
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return NoContent();
        }

        /**
         * Metodo de tipo Get valida el ingreso del usuario al sistema
         * @param email del usuario buscado
         * @param pwd pass del usuario
         * @param rol tipo de usurio que desea acceder
         * @return booleano con el resultado de la operacion
         */
        [HttpGet("validarUsuario/{user}/{pwd}/{rol}")]
        public async Task<bool> ValidacionLoginUsuario(string user, string pwd, string rol)
        {
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = myConnection;


            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetValidarLoginRol";
            sqlCmd.Parameters.AddWithValue("@User", user);
            sqlCmd.Parameters.AddWithValue("@pass", Encriptar(pwd));
            sqlCmd.Parameters.AddWithValue("@rol", rol);
            sqlCmd.Parameters.Add("@Return", SqlDbType.Int).Direction = ParameterDirection.Output;

            myConnection.Open();
            sqlCmd.ExecuteNonQuery();

            int Dato = Convert.ToInt32(sqlCmd.Parameters["@Return"].Value);



            myConnection.Close();




            if (Dato == 1)
            {
                return true;
            }
            else
            {
                return false;
            }



        }
        //md5
        public static string Encriptar(string texto)
        {
            string key = "mikey";
            byte[] keyArray;

            byte[] Arreglo_a_Cifrar =
            UTF8Encoding.UTF8.GetBytes(texto);


            MD5CryptoServiceProvider hashmd5 =
            new MD5CryptoServiceProvider();

            keyArray = hashmd5.ComputeHash(
            UTF8Encoding.UTF8.GetBytes(key));

            hashmd5.Clear();


            TripleDESCryptoServiceProvider tdes =
            new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform =
            tdes.CreateEncryptor();


            byte[] ArrayResultado =
            cTransform.TransformFinalBlock(Arreglo_a_Cifrar,
            0, Arreglo_a_Cifrar.Length);

            tdes.Clear();

            //se regresa el resultado en forma de una cadena
            return Convert.ToBase64String(ArrayResultado,
            0, ArrayResultado.Length);
        }

        public static string Desencriptar(string textoEncriptado)
        {
            string key = "mikey";
            byte[] keyArray;
            byte[] Array_a_Descifrar =
            Convert.FromBase64String(textoEncriptado);

            MD5CryptoServiceProvider hashmd5 =
            new MD5CryptoServiceProvider();

            keyArray = hashmd5.ComputeHash(
            UTF8Encoding.UTF8.GetBytes(key));

            hashmd5.Clear();

            TripleDESCryptoServiceProvider tdes =
            new TripleDESCryptoServiceProvider();

            tdes.Key = keyArray;
            tdes.Mode = CipherMode.ECB;
            tdes.Padding = PaddingMode.PKCS7;

            ICryptoTransform cTransform =
            tdes.CreateDecryptor();

            byte[] resultArray =
            cTransform.TransformFinalBlock(Array_a_Descifrar,
            0, Array_a_Descifrar.Length);

            tdes.Clear();

            return UTF8Encoding.UTF8.GetString(resultArray);
        }

        /**
         * Metodo de tipo Get que obtiene los pacientes que tiene asociado un nutricionista
         * @param codigo del nutricionista buscado
         * @return Lista de pacientes pertenecientes a ese nutricionista
         */
        [HttpGet("pacientes/{nutri}")]
        public List<paciente> GetPlanesNut(string nutri)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPacientesDeUnNutri";
            sqlCmd.Parameters.Add("@nutri", SqlDbType.VarChar, 20).Value = nutri;
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<paciente> pacientes = new List<paciente>();

            while (reader.Read())
            {
                paciente pas = new paciente();

                pas.nombre1 = reader.GetValue(0).ToString();
                pas.nombre2 = reader.GetValue(1).ToString();
                pas.apellido1 = reader.GetValue(2).ToString();
                pas.apellido2 = reader.GetValue(3).ToString();
                pas.cedula = (int)reader.GetValue(4);
                pas.fecha_de_nacimiento = reader.GetValue(5).ToString();
                pas.peso = (double)reader.GetValue(6);
                pas.estado = reader.GetValue(7).ToString();
                pas.edad = (int)reader.GetValue(8);
                pas.pass = reader.GetValue(9).ToString();
                pas.email = reader.GetValue(10).ToString();
                pas.imc = (int)reader.GetValue(11);
                pas.pais = reader.GetValue(12).ToString();
                pas.codigo_nutricionista = reader.GetValue(13).ToString();


                pacientes.Add(pas);

            }
            myConnection.Close();

            return pacientes;
        }

    }
}
