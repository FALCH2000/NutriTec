package tarea1.tec.proyecto2;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;


public class LoginActivity extends AppCompatActivity {

    static String BASEURL = "http://192.168.1.3:8081/";


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_login);

    }


    public void Ini_Principal(View view){
        Intent principal = new Intent(this, Menu.class);
        startActivity (principal);
    }


/*

    public void VerificarUsuario(View view){


        EditText UsuarioText = findViewById (R.id.username);

        EditText PassText = findViewById (R.id.password);
        final BaseDeDatos db = new BaseDeDatos (LoginActivity.this);
        Cursor c = db.ObtenerCliente (String.valueOf(UsuarioText.getText ()));
        String pass = "";
        int cedula = 0;


                if (c != null && c.moveToFirst()){
        do{
            pass = c.getString (7);
            cedula = c.getInt (0);


        }while (c.moveToNext ());

                }

        if(UsuarioText.getText ().toString ().equals ("") || PassText.getText ().toString ().equals ("")){
            Toast.makeText(LoginActivity.this, "Debe rellenar ambos campos", Toast.LENGTH_SHORT).show();

        }else{

            if(String.valueOf(PassText.getText ()).equals (pass)){
                Ini_Principal (cedula);
            }else{
                Toast.makeText(LoginActivity.this, "Usuario o contraseña incorrecta", Toast.LENGTH_SHORT).show();
            }

        }




    }



**/









}
