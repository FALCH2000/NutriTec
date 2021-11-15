package tarea1.tec.proyecto2;

import android.content.Intent;
import android.database.Cursor;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import tarea1.tec.proyecto2.Interfaces.LoginPacientesApi;


public class LoginActivity extends AppCompatActivity {

    static String BASEURL = "https://nutritecapi.azurewebsites.net/";


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_login);

    }

    /**
     *
     * @param view Tipo vista para ser detectado por el boton
     */
    public void Ini_Principal(View view){
        EditText email = findViewById (R.id.username);
        EditText pass = findViewById (R.id.password);
        find (email.getText ().toString (), pass.getText ().toString ());
    }

    /**
     *
     * @param user String Email Usuario
     * @param pwd String password del usuario
     */

    private void find(String user, String pwd) {
        EditText email = findViewById (R.id.username);
        Retrofit retrofit = new Retrofit.Builder ().baseUrl ("https://nutritecapi.azurewebsites.net/")
                .addConverterFactory (GsonConverterFactory.create ()).build ();

        LoginPacientesApi LoginAPI = retrofit.create (LoginPacientesApi.class);
        Call<Boolean> call = LoginAPI.find (user, pwd);
        call.enqueue (new Callback<Boolean> () {
            @Override
            public void onResponse(Call<Boolean> call, Response<Boolean> response) {
                try {
                    if (response.isSuccessful ()) {
                        Boolean m = response.body ();
                        if (m == true) {
                            Intent principal = new Intent (LoginActivity.this, Menu.class);
                            principal.putExtra ("email", email.getText ().toString ());
                            startActivity (principal);
                        } else {
                            Toast.makeText (LoginActivity.this, "Error de credenciales, favor intentar de nuevo", Toast.LENGTH_SHORT).show ();

                        }
                    }

                } catch (Exception ex) {
                    Toast.makeText (LoginActivity.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                }
            }

            @Override
            public void onFailure(Call<Boolean> call, Throwable t) {
                Toast.makeText (LoginActivity.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
            }
        });
    }










}
