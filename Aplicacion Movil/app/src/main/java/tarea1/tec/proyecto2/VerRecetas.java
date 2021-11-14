package tarea1.tec.proyecto2;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import tarea1.tec.proyecto2.Interfaces.Recetas;
import tarea1.tec.proyecto2.R;

public class VerRecetas extends AppCompatActivity {

    public String email;
    public ArrayList<String> productos = new ArrayList<String> ();
    static String BASEURL = "https://nutritecapi.azurewebsites.net/";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_ver_recetas);
        Bundle bundle = this.getIntent ().getExtras ();
        email = bundle.getString ("email");

        CargarRecetas ();

    }

    public void ATRAS(View view){
        super.onBackPressed ();
    }

    public void CargarRecetas(){
        ListView listRecetas;
        listRecetas = findViewById (R.id.ListRec);

        Retrofit retrofit = new Retrofit.Builder ().baseUrl (BASEURL)
                .addConverterFactory (GsonConverterFactory.create ()).build ();
        Recetas NombreRecetaApi = retrofit.create (Recetas.class);
        Call<List<String>> call = NombreRecetaApi.find (email);

        call.enqueue (new Callback<List<String>> () {
            @Override
            public void onResponse(Call<List<String>> call, Response<List<String>> response) {
                try {
                    if (response.isSuccessful ()) {
                        int indice = 0;

                        List<String> m = response.body ();
                        for (String prota : m){
                                productos.add (m.get (indice));
                                indice++;

                        }
                        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (VerRecetas.this,android.R.layout.simple_list_item_1,productos);
                        listRecetas.setAdapter (adaptador);

                    }

                } catch (Exception ex) {

                    Toast.makeText (VerRecetas.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                }
            }

            @Override
            public void onFailure(Call<List<String>> call, Throwable t) {
                Toast.makeText (VerRecetas.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
            }
        });


        listRecetas.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView adapter, View view, int position, long arg) {

                String text = (String) listRecetas.getItemAtPosition(position);


                Intent principal = new Intent (VerRecetas.this, Gestion_Recetas.class);
                principal.putExtra ("email", email);
                principal.putExtra ("nombre", text);
                principal.putExtra ("proceso", "editar");
                startActivity (principal);

            }
        });

    }

    public void NuevaReceta(View view){
        Intent principal = new Intent (VerRecetas.this, Gestion_Recetas.class);
        principal.putExtra ("email", email);
        principal.putExtra ("nombre", "");
        principal.putExtra ("proceso", "nuevo");
        startActivity (principal);
    }

}