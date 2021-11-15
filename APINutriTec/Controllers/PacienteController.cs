using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using APINutriTec.Model;


/*
 * Controlador de pacientes
 * @author Harold Espinoza 
 * 
 */
namespace APINutriTec.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PacienteController : Controller
    {
        String cadenaConexion;
        public PacienteController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

        /**
         * Metodo de tipo Get que retorna un paciente por su numero de cedula 
         * @param codigo del paciente solicitado
         * @return paciente buscado
         */
        [HttpGet("get/{codigo}")]
        public paciente GetPaciente(string codigo)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPaciente";
            sqlCmd.Parameters.AddWithValue("@cedula", codigo);
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            paciente pas = new paciente();

            while (reader.Read())
            {

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


            }
            myConnection.Close();

            return pas;

        }

        /**
         * Metodo de tipo Get que retorna un paciente por su email
         * @param email del paciente solicitado
         * @return paciente buscado
         */
        [HttpGet("email/{email}")]
        public paciente GetPacienteXemail(string email)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetPacienteXEmail";
            sqlCmd.Parameters.AddWithValue("@email", email);
            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            paciente pas = new paciente();

            while (reader.Read())
            {

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


            }
            myConnection.Close();

            return pas;

        }


        /**
         * Metodo de tipo Get que valida el inicio de secion de un paciente
         * @param user email del usuario
         * @param pwd password del usuario
         * @return booleano con el resultado de la operacion
         */
        [HttpGet("validar/{user}/{pwd}")]
        public async Task<bool> Validacion(string user, string pwd)
        {
            SqlConnection myConnection = new SqlConnection(cadenaConexion);


            // myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.Connection = myConnection;


            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetValidarLogin";
            sqlCmd.Parameters.AddWithValue("@User", user);
            sqlCmd.Parameters.AddWithValue("@pass", Encriptar(pwd));
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

        /**
         * Metodo que se encarga de hacer la encriptacion de la contrasena con MD5
         */
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
         * Metodo de tipo Get que obtiene una lista de los pacientes que no tienen un nutricionista asignado
         * @return lista de pacientes sin nutricionista
         */
        [HttpGet("libres")]
        public List<paciente> PacienteSinNutri() 
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "PacienteSinNutri";
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

        /**
         * Metodo de tipo Get que obtiene la lista de medidas segun su cedula
         * @param cedula del paciente solicitado
         * @return lista de medidas de ese paciente
         */
        [HttpGet("medidas/{cedula}")]
        public List<Medida> GetPacienteMedidas(int cedula)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetMedidasXCedula";
            sqlCmd.Parameters.AddWithValue("@cedula_paciente", cedula);

            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Medida> medidas = new List<Medida>();

            while (reader.Read())
            {
                Medida medida = new Medida();

                medida.fecha_ingreso = reader.GetValue(0).ToString();
                medida.cadera = (int)reader.GetValue(1);
                medida.cintura = (int)reader.GetValue(2);
                medida.cuello = (int)reader.GetValue(3);
                medida.peso = (int)reader.GetValue(4);
                medida.musculo = (int)reader.GetValue(5);
                medida.grasa = (int)reader.GetValue(6);
                medida.cedula_paciente = (int)reader.GetValue(7);


                medidas.Add(medida);

            }
            myConnection.Close();

            return medidas;

        }

        /**
         * Metodo de tipo Get que obtiene la lista de medidas de un paciente en un rango de fachas
         * @return lista de medidas de ese paciente
         */
        [HttpGet("rangomedidas")]
        public List<Medida> GetPacienteMedidasRango([FromBody] RangoMedida rango)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetRangoMedidas";
            sqlCmd.Parameters.AddWithValue("@fecha_inicial", rango.fecha_inicio);
            sqlCmd.Parameters.AddWithValue("@fecha_final", rango.fecha_final);
            sqlCmd.Parameters.AddWithValue("@cedula_paciente", rango.cedula);

            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<Medida> medidas = new List<Medida>();

            while (reader.Read())
            {
                Medida medida = new Medida();

                medida.fecha_ingreso = reader.GetValue(0).ToString();
                medida.cadera = (int)reader.GetValue(1);
                medida.cintura = (int)reader.GetValue(2);
                medida.cuello = (int)reader.GetValue(3);
                medida.peso = (int)reader.GetValue(4);
                medida.musculo = (int)reader.GetValue(5);
                medida.grasa = (int)reader.GetValue(6);
                medida.cedula_paciente = (int)reader.GetValue(7);


                medidas.Add(medida);

            }
            myConnection.Close();

            return medidas;

        }


        /**
         * Metodo de tipo Post que ingresa unas nuevas medidas para el paciente
         * @return resultado de la operacion
         */
        [HttpPost("medida/insert")]
        public async Task<IActionResult> InsertMedida([FromBody]Medida medida) 
        {

            if (medida == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "InsertMedidas";
            sqlCmd.Parameters.AddWithValue("@fecha", DateTime.Parse(medida.fecha_ingreso));
            sqlCmd.Parameters.AddWithValue("@cadera", medida.cadera);
            sqlCmd.Parameters.AddWithValue("@cintura", medida.cintura);
            sqlCmd.Parameters.AddWithValue("@cuello", medida.cuello);
            sqlCmd.Parameters.AddWithValue("@peso", medida.peso);
            sqlCmd.Parameters.AddWithValue("@musculo", medida.musculo);
            sqlCmd.Parameters.AddWithValue("@grasa", medida.grasa);
            sqlCmd.Parameters.AddWithValue("@cedula_paciente", medida.cedula_paciente);
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return Created("created", created);
        }

        /**
         * Metodo de tipo Get que obtiene la lista de los consumos de un paciente segun su cedula
         * @param cedula del paciente solicitado
         * @return lista de consumos de ese paciente
         */
        [HttpGet("consumo/{cedula}")]
        public List<ConsumoDiario> GetPacienteconsumos(int cedula)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "GetConsumosPaciente";
            sqlCmd.Parameters.AddWithValue("@cedula", cedula);

            sqlCmd.Connection = myConnection;
            myConnection.Open();

            reader = sqlCmd.ExecuteReader();

            List<ConsumoDiario> consumos = new List<ConsumoDiario>();

            while (reader.Read())
            {
                ConsumoDiario consumo = new ConsumoDiario();
                consumo.fecha = reader.GetValue(0).ToString();
                consumo.almuerzo = reader.GetValue(1).ToString();
                consumo.cena = reader.GetValue(2).ToString();
                consumo.desayuno = reader.GetValue(3).ToString();
                consumo.merienda_manana = reader.GetValue(4).ToString();
                consumo.merienda_tarde = reader.GetValue(5).ToString();
                consumo.consumo_calorias = (int)reader.GetValue(6);
                consumo.cedula_paciente = (int)reader.GetValue(7);





                consumos.Add(consumo);

            }
            myConnection.Close();

            return consumos;

        }


        /**
         * Metodo de tipo Post que ingresa un nuevo consumo de un paciente
         * @return codigo con resultado de la operacion
         */
        [HttpPost("consumo/insert")]
        public async Task<IActionResult> InsertConsumo([FromBody] ConsumoDiario consumo)
        {

            if (consumo == null)

                return BadRequest();
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "InsertConsumo";
            sqlCmd.Parameters.AddWithValue("@fecha", DateTime.Parse(consumo.fecha));
            sqlCmd.Parameters.AddWithValue("@almuerzo", consumo.almuerzo);
            sqlCmd.Parameters.AddWithValue("@cena", consumo.cena);
            sqlCmd.Parameters.AddWithValue("@desayuno", consumo.desayuno);
            sqlCmd.Parameters.AddWithValue("@merienda_manana", consumo.merienda_manana);
            sqlCmd.Parameters.AddWithValue("@merienda_tarde", consumo.merienda_tarde);
            sqlCmd.Parameters.AddWithValue("@consumo_calorias", consumo.consumo_calorias);
            sqlCmd.Parameters.AddWithValue("@cedula_paciente", consumo.cedula_paciente);
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();


            return Created("created", created);
        }

        /**
         * Metodo de tipo Put que asigna un nutricionista a un paciente 
         * @param cedula del paciente que se desea asosiar
         * @param nutri codigo del nutricionista a asosiar
         * @return codigo con el resultado de la operacion
         */
        [HttpPut("asignar/{cedula}/{nutri}")]
        public async Task<IActionResult> AsignarNutri(int cedula, string nutri)
        {

            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "AsignarNutriAPaciente";
            sqlCmd.Parameters.Add("@cedula_paciente", SqlDbType.VarChar, 50).Value = cedula;
            sqlCmd.Parameters.Add("@codigo_nutri", SqlDbType.VarChar, 120).Value = nutri;
     

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();



            return Ok();
        }

        /**
         * Metodo de tipo Delete que desasocia un nutricionista de un paciente
         * @param cedula del paciente que se desea desasosiar
         * @return codigo con el resultado de la operacion
         */
        [HttpDelete("desligarnutri/{cedula}")]
        public async Task<IActionResult> DesligarNutri(int cedula)
        {
            SqlConnection myConnection = new SqlConnection();

            myConnection.ConnectionString = cadenaConexion;

            SqlCommand sqlCmd = new SqlCommand();

            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.CommandText = "DesligarNutricionista";
            sqlCmd.Parameters.Add("@cedula_paciente", SqlDbType.VarChar, 50).Value = cedula;

            sqlCmd.Connection = myConnection;
            myConnection.Open();
            var created = sqlCmd.ExecuteNonQuery();
            myConnection.Close();

            return NoContent();
        }

    }
}
