package tarea1.tec.proyecto2;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import tarea1.tec.proyecto2.Interfaces.FiltroCodigo;
import tarea1.tec.proyecto2.Interfaces.FiltroNombre;
import tarea1.tec.proyecto2.Interfaces.FiltroNombreReceta;
import tarea1.tec.proyecto2.Interfaces.ProductosPaciente;
import tarea1.tec.proyecto2.Interfaces.Recetas;
import tarea1.tec.proyecto2.Interfaces.Registro;
import tarea1.tec.proyecto2.Modelos.RegistroM;

public class Registro_Diario extends AppCompatActivity {
    public String seleccion;
    public String email;
    public int habilitar = 0;
    static String BASEURL = "https://nutritecapi.azurewebsites.net/";
    public ArrayList<String> productos = new ArrayList<String> ();
    public ArrayList<String> agregado = new ArrayList<String> ();
    public ArrayList<String> borrado = new ArrayList<String> ();



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_registro_diario);
        Bundle bundle = this.getIntent ().getExtras ();
        email = bundle.getString ("email");


        Spinner spinner;
        ArrayList<String> filtro;
        spinner = findViewById (R.id.spinner2);

        filtro = new ArrayList<String> ();

        filtro.add ("Nombre");
        filtro.add ("Código");

        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,filtro);
        spinner.setAdapter (adaptador);

        CargarHorarios ();
        CargarProductosRecetas ();
    }

    /**
     *
     * @param v Tipo vista para ser detectado por el boton
     */

    public void CargarFiltros(View v){

        ListView listviewProducto;
        listviewProducto = findViewById (R.id.ProdRegistro);


        Spinner spinner;
        String opcion;
        spinner = findViewById (R.id.spinner2);

        EditText filtroTXT = findViewById (R.id.editTextTextPersonName2);


        opcion = spinner.getSelectedItem ().toString ();

        if(opcion.equals ("Nombre") && filtroTXT.getText ().length () != 0){
            productos.clear ();
            Retrofit retrofit = new Retrofit.Builder ().baseUrl (BASEURL)
                    .addConverterFactory (GsonConverterFactory.create ()).build ();
            FiltroNombre FiltroNombreApi = retrofit.create (FiltroNombre.class);
            Call<List<String>> call = FiltroNombreApi.find (email, filtroTXT.getText ().toString ());

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
                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,productos);
                            listviewProducto.setAdapter (adaptador);

                        }

                    } catch (Exception ex) {

                        Toast.makeText (Registro_Diario.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Registro_Diario.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });

            FiltroNombreReceta FiltroReceta = retrofit.create (FiltroNombreReceta.class);
            Call<List<String>> call2 = FiltroReceta.find (email, filtroTXT.getText ().toString ());

            call2.enqueue (new Callback<List<String>> () {
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

                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,productos);
                            listviewProducto.setAdapter (adaptador);


                        }

                    } catch (Exception ex) {

                        Toast.makeText (Registro_Diario.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Registro_Diario.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });

        }else if(opcion.equals ("Código") && filtroTXT.getText ().length () != 0){
            productos.clear ();
            Retrofit retrofit = new Retrofit.Builder ().baseUrl (BASEURL)
                    .addConverterFactory (GsonConverterFactory.create ()).build ();
            FiltroCodigo FiltroCodApi = retrofit.create (FiltroCodigo.class);
            Call<List<String>> call = FiltroCodApi.find (email, filtroTXT.getText ().toString ());

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
                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,productos);
                            listviewProducto.setAdapter (adaptador);

                        }

                    } catch (Exception ex) {

                        Toast.makeText (Registro_Diario.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Registro_Diario.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });
        }
    }

    /**
     * Cargar productos y recetas en la listview
     */

    public void CargarProductosRecetas(){
        ListView listviewProducto;
        ListView listAgregado;


        listviewProducto = findViewById (R.id.ProdRegistro);
        listAgregado = findViewById (R.id.ProdAgregadosRegistro);

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
                        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,productos);
                        listviewProducto.setAdapter (adaptador);

                    }

                } catch (Exception ex) {

                    Toast.makeText (Registro_Diario.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                }
            }

            @Override
            public void onFailure(Call<List<String>> call, Throwable t) {
                Toast.makeText (Registro_Diario.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
            }
        });

        ProductosPaciente ProductosApi = retrofit.create (ProductosPaciente.class);
        Call<List<String>> call2 = ProductosApi.find (email);

        call2.enqueue (new Callback<List<String>> () {
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

                        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,productos);
                        listviewProducto.setAdapter (adaptador);


                    }

                } catch (Exception ex) {

                    Toast.makeText (Registro_Diario.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                }
            }

            @Override
            public void onFailure(Call<List<String>> call, Throwable t) {
                Toast.makeText (Registro_Diario.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
            }
        });




        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,productos);

        ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,agregado);



        listviewProducto.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView adapter, View view, int position, long arg) {

                String text = (String) listviewProducto.getItemAtPosition(position);
                agregado.add (text);
                productos.remove (text);

                listviewProducto.setAdapter (adaptador);
                listAgregado.setAdapter (adaptador2);


            }
        });

        listAgregado.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView adapter, View view, int position, long arg) {

                String text = (String) listAgregado.getItemAtPosition(position);
                agregado.remove (text);
                productos.add (text);

                listviewProducto.setAdapter (adaptador);
                listAgregado.setAdapter (adaptador2);



            }
        });
    }

    /**
     *
     * @param view Tipo vista para ser detectado por el boton
     */
    public void ATRAS(View view){
        super.onBackPressed ();
    }

    /**
     * Carga horarios de comidas en el spinner de la interfaz
     */
    public void CargarHorarios(){
        Spinner spinner;
        ArrayList<String> horarios;
        spinner = findViewById (R.id.spinner);
        horarios = new ArrayList<String> ();
        ListView listAgregado;
        listAgregado = findViewById (R.id.ProdAgregadosRegistro);

        horarios.add ("Desayuno");
        horarios.add ("Merienda Mañana");
        horarios.add ("Almuerzo");
        horarios.add ("Merienda Tarde");
        horarios.add ("Cena");

        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,horarios);
        spinner.setAdapter (adaptador);

        spinner.setOnItemSelectedListener (new AdapterView.OnItemSelectedListener ()
        {
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id)
            {
                //Toast.makeText (Registro_Diario.this, spinner.getSelectedItem ().toString (), Toast.LENGTH_SHORT).show ();
                seleccion = spinner.getSelectedItem ().toString ();
                if(habilitar == 1) {
                    agregado.clear ();
                    ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (Registro_Diario.this,android.R.layout.simple_list_item_1,agregado);
                    listAgregado.setAdapter (adaptador2);
                    productos.clear ();
                    CargarProductosRecetas ();

                }else{
                    habilitar++;
                }


            }
            public void onNothingSelected(AdapterView<?> parent)
            {

            }

        });


    }

    /**
     *
     * @param v Tipo vista para ser detectado por el boton
     */
    public void EnviarRegistro(View v){
        int indice = 0;
        ArrayList datos = new ArrayList ();

        Retrofit retrofit = new Retrofit.Builder().baseUrl(BASEURL)
                .addConverterFactory(GsonConverterFactory.create()).build();
        Registro registroAPI=retrofit.create(Registro.class);

        if(agregado.size () != 0){
            while (agregado.size () != indice) {
                RegistroM object = new RegistroM ();
                try {
                    object.setEmail (email);
                    object.setProducto (agregado.get (indice));

                    if(seleccion.equals ("Desayuno")){
                        object.setHorario ("Desayuno");
                    }else if(seleccion.equals ("Merienda Mañana")){
                        object.setHorario ("MeriendaM");
                    }else if(seleccion.equals ("Almuerzo")){
                        object.setHorario ("Almuerzo");

                    }else if(seleccion.equals ("Merienda Tarde")){
                        object.setHorario ("MeriendaT");

                    }else{
                        object.setHorario ("Cena");
                    }

                    datos.add (object);

                } catch (Exception e) {
                    e.printStackTrace ();
                }
                indice++;
            }
            Call<ArrayList<RegistroM>> call=registroAPI.env(datos);
            call.enqueue(new Callback<ArrayList<RegistroM>>() {
                @Override
                public void onResponse(Call<ArrayList<RegistroM>> call, Response<ArrayList<RegistroM>> response) {


                    try
                    {

                        Toast.makeText(Registro_Diario.this, "Guardado", Toast.LENGTH_SHORT).show();
                    }catch (Exception ex){
                        Toast.makeText(Registro_Diario.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onFailure(Call<ArrayList<RegistroM>> call, Throwable t) {
                    //Toast.makeText(c, "asiento mod", Toast.LENGTH_SHORT).show();
                }
            });
        }else{
            Toast.makeText(Registro_Diario.this, "Agregue algún producto o receta", Toast.LENGTH_SHORT).show();
        }

        Intent principal = new Intent(Registro_Diario.this, Registro_Diario.class);
        principal.putExtra ("email", email);
        startActivity (principal);

    }





}