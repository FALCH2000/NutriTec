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
        // Get: api/usuario todos los usuarios

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

        //un usuario por codigo
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

        //ingersa usuario
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
            sqlCmd.Parameters.Add("@nombre1", SqlDbType.VarChar, 20).Value = user.nombre1;
            sqlCmd.Parameters.Add("@nombre2", SqlDbType.VarChar, 20).Value = user.nombre2;
            sqlCmd.Parameters.Add("@apellido1", SqlDbType.VarChar, 20).Value = user.apellido1;
            sqlCmd.Parameters.Add("@apellido2", SqlDbType.VarChar, 20).Value = user.apellido2;
            sqlCmd.Parameters.Add("@cedula", SqlDbType.VarChar, 20).Value = user.cedula;
            sqlCmd.Parameters.Add("@fecha_de_nacimiento", SqlDbType.VarChar, 20).Value = DateTime.Parse(user.fecha_de_nacimiento);
            sqlCmd.Parameters.Add("@edad", SqlDbType.VarChar, 20).Value = user.edad;
            sqlCmd.Parameters.Add("@codigo_nutricionista", SqlDbType.VarChar, 20).Value = user.codigo_nutricionista;
            sqlCmd.Parameters.Add("@email", SqlDbType.VarChar, 20).Value = user.email;
            sqlCmd.Parameters.Add("@pass", SqlDbType.VarChar, 20).Value = user.pass;
            sqlCmd.Parameters.Add("@numero_tarjeta", SqlDbType.VarChar, 20).Value = user.numero_tarjeta;
            sqlCmd.Parameters.Add("@tipo_cobro", SqlDbType.VarChar, 20).Value = user.tipo_cobro;
            sqlCmd.Parameters.Add("@rol", SqlDbType.VarChar, 20).Value = user.rol;
            sqlCmd.Parameters.Add("@direccion", SqlDbType.VarChar, 20).Value = user.direccion;
            sqlCmd.Parameters.Add("@foto", SqlDbType.VarChar, 20).Value = user.foto;
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return Created("created",created);
        }

        //elimina usuario
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

        //login usuario
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

    }
}
