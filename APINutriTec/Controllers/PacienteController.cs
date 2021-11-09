﻿using Microsoft.AspNetCore.Mvc;
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
    public class PacienteController : Controller
    {
        String cadenaConexion;
        public PacienteController()
        {
            cadenaConexion = "Server=tcp:bases-tec.database.windows.net,1433;Initial Catalog=NutriTECBD;Persist Security Info=False;User ID=hadmin;Password=marioNeta1;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;";
        }

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