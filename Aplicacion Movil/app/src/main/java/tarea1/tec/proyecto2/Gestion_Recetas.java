package tarea1.tec.proyecto2;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebHistoryItem;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;
import tarea1.tec.proyecto2.Interfaces.EliminarRecetaApi;
import tarea1.tec.proyecto2.Interfaces.LoginPacientesApi;
import tarea1.tec.proyecto2.Interfaces.NuevaRecetaApi;
import tarea1.tec.proyecto2.Interfaces.PorcionRecetaApi;
import tarea1.tec.proyecto2.Interfaces.ProductoBorradoReceta;
import tarea1.tec.proyecto2.Interfaces.ProductoNuevoRApi;
import tarea1.tec.proyecto2.Interfaces.ProductosPaciente;
import tarea1.tec.proyecto2.Interfaces.ProductosReceta;
import tarea1.tec.proyecto2.Interfaces.Recetas;
import tarea1.tec.proyecto2.Interfaces.Registro;
import tarea1.tec.proyecto2.Modelos.EliminarReceta;
import tarea1.tec.proyecto2.Modelos.ProductosNuevoRecetas;
import tarea1.tec.proyecto2.Modelos.RegistroM;
import tarea1.tec.proyecto2.Modelos.nuevaReceta;

public class Gestion_Recetas extends AppCompatActivity {
    public ArrayList<String> productos = new ArrayList<String> ();
    public ArrayList<String> agregado = new ArrayList<String> ();

    public ArrayList<String> productosAgregadosBD = new ArrayList<String> ();
    public ArrayList<String> productosDiponiblesBD = new ArrayList<String> ();


    public String email;
    public String nombreReceta;
    public String Proceso;
    static String BASEURL = "https://nutritecapi.azurewebsites.net/";



    @Override
    protected void onCreate(Bundle savedInstanceState) {



        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_gestion_recetas);
        Bundle bundle = this.getIntent ().getExtras ();
        email = bundle.getString ("email");
        nombreReceta = bundle.getString ("nombre");
        Proceso = bundle.getString ("proceso");

        EditText nom = findViewById (R.id.editTextTextPersonName);
        nom.setText (nombreReceta);


        CargarProductos ();
    }

    /**
     * Carga productos de la receta
     */
    public void CargarProductos(){

        ListView listviewProducto;
        ListView listviewProducto2;

        ListView listAgregado;


        listviewProducto = findViewById (R.id.listProductos);
        listviewProducto2 = findViewById (R.id.listProductos);

        listAgregado = findViewById (R.id.listAgregado);







        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,productos);
        listviewProducto.setAdapter (adaptador);

        ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,agregado);



        if(Proceso.equals ("editar")){

            EditText portxt = findViewById (R.id.porcion);

            Retrofit retrofit = new Retrofit.Builder ().baseUrl (BASEURL)
                    .addConverterFactory (GsonConverterFactory.create ()).build ();
            ProductosReceta NombreRecetaApi = retrofit.create (ProductosReceta.class);


            PorcionRecetaApi PORCIONAPI = retrofit.create (PorcionRecetaApi.class);
            Call<String> call3 = PORCIONAPI.find (email, nombreReceta);
            call3.enqueue (new Callback<String> () {
                @Override
                public void onResponse(Call<String> call, Response<String> response) {
                    try {
                        if (response.isSuccessful ()) {
                            String m = response.body ();
                            //Toast.makeText (Gestion_Recetas.this, m, Toast.LENGTH_SHORT).show ();
                            portxt.setText (m);
                        }

                    } catch (Exception ex) {
                        Toast.makeText (Gestion_Recetas.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<String> call, Throwable t) {
                    Toast.makeText (Gestion_Recetas.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });

            Call<List<String>> call = NombreRecetaApi.find (nombreReceta);
            call.enqueue (new Callback<List<String>> () {
                @Override
                public void onResponse(Call<List<String>> call, Response<List<String>> response) {
                    try {
                        if (response.isSuccessful ()) {
                            int indice = 0;

                            List<String> m = response.body ();
                            for (String prota : m){
                                agregado.add (m.get (indice));
                                productosAgregadosBD.add (m.get (indice));
                                indice++;

                            }
                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Gestion_Recetas.this,android.R.layout.simple_list_item_1,agregado);
                            listAgregado.setAdapter (adaptador);

                            lista2 (agregado);

                        }

                    } catch (Exception ex) {

                        Toast.makeText (Gestion_Recetas.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Gestion_Recetas.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
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
                                productosDiponiblesBD.add (m.get (indice));
                                indice++;

                            }

                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Gestion_Recetas.this,android.R.layout.simple_list_item_1,productos);
                            listviewProducto.setAdapter (adaptador);
                            lista (productos);


                        }

                    } catch (Exception ex) {

                        Toast.makeText (Gestion_Recetas.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Gestion_Recetas.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });
        }else if(Proceso.equals ("nuevo")){
            Button b = findViewById (R.id.button9);
            b.setVisibility (View.INVISIBLE);

            ArrayList<String> t = new ArrayList<String> ();
            lista2 (t);

            Retrofit retrofit = new Retrofit.Builder ().baseUrl (BASEURL)
                    .addConverterFactory (GsonConverterFactory.create ()).build ();

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

                            ArrayAdapter<String> adaptador = new ArrayAdapter<String> (Gestion_Recetas.this,android.R.layout.simple_list_item_1,productos);
                            listviewProducto.setAdapter (adaptador);
                            lista (productos);


                        }

                    } catch (Exception ex) {

                        Toast.makeText (Gestion_Recetas.this, ex.getMessage (), Toast.LENGTH_SHORT).show ();
                    }
                }

                @Override
                public void onFailure(Call<List<String>> call, Throwable t) {
                    Toast.makeText (Gestion_Recetas.this, "Error de conexion", Toast.LENGTH_SHORT).show ();
                }
            });

        }


    }


    /**
     *
     * @param view Tipo vista para ser detectado por el boton
     */
    public void ATRAS(View view){
        super.onBackPressed ();
    }

    /**
     *
     * @param A Array con los nombres de productos disponibles
     */
    public void lista(ArrayList<String> A){
        ListView listviewProducto;
        ListView listAgregado;
        listAgregado = findViewById (R.id.listAgregado);
        listviewProducto = findViewById (R.id.listProductos);

        int indice = 0;

        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,productos);

        ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,agregado);


        while (agregado.size () != indice){
            productos.remove (agregado.get (indice));
            productosDiponiblesBD.remove (agregado.get (indice));

            indice++;
        }

        listviewProducto.setAdapter (adaptador);



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

    }

    /**
     *
     * @param A Array con los nombres de productos agregados
     */
    public void lista2(ArrayList<String> A){
        ListView listviewProducto;
        ListView listAgregado;
        listAgregado = findViewById (R.id.listAgregado);
        listviewProducto = findViewById (R.id.listProductos);

        int indice = 0;

        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,productos);

        ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,agregado);



        while (agregado.size () != indice){
            productos.remove (agregado.get (indice));
            productosDiponiblesBD.remove (agregado.get (indice));
            indice++;
        }

        listviewProducto.setAdapter (adaptador);




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
     * @param v Tipo vista para ser detectado por el boton
     */
    public void GuardarBoton(View v){
        ListView listAgregado;
        listAgregado = findViewById (R.id.listAgregado);
        EditText nomb = findViewById (R.id.editTextTextPersonName);
        EditText por = findViewById (R.id.porcion);
        if(Proceso.equals ("nuevo") && nomb.getText ().length () != 0 && por.getText ().length () != 0 && listAgregado.getAdapter ().getCount () >= 1){


            int indice = 0;
            ArrayList datos = new ArrayList ();

            Retrofit retrofit = new Retrofit.Builder().baseUrl(BASEURL)
                    .addConverterFactory(GsonConverterFactory.create()).build();
            NuevaRecetaApi nuevaRecetaAPI=retrofit.create(NuevaRecetaApi.class);

            if(agregado.size () != 0){
                while (agregado.size () != indice) {
                    nuevaReceta object = new nuevaReceta ();
                    try {
                        object.setEmail (email);
                        object.setNombre (nomb.getText ().toString ());
                        object.setProducto (agregado.get (indice));
                        object.setTamano (Integer.parseInt (por.getText ().toString ()));

                        datos.add (object);

                    } catch (Exception e) {
                        e.printStackTrace ();
                    }
                    indice++;
                }
                Call<ArrayList<nuevaReceta>> call=nuevaRecetaAPI.env(datos);
                call.enqueue(new Callback<ArrayList<nuevaReceta>>() {
                    @Override
                    public void onResponse(Call<ArrayList<nuevaReceta>> call, Response<ArrayList<nuevaReceta>> response) {
                        try
                        {
                            Toast.makeText(Gestion_Recetas.this, "", Toast.LENGTH_SHORT).show();
                        }catch (Exception ex){
                            Toast.makeText(Gestion_Recetas.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                    }

                    @Override
                    public void onFailure(Call<ArrayList<nuevaReceta>> call, Throwable t) {
                    }
                });
            }else{
                Toast.makeText(Gestion_Recetas.this, "", Toast.LENGTH_SHORT).show();
            }
        }else if(Proceso.equals ("editar")  && por.getText ().length () != 0){
            int indice = 0;

            Retrofit retrofit = new Retrofit.Builder().baseUrl(BASEURL)
                    .addConverterFactory(GsonConverterFactory.create()).build();
            ProductoNuevoRApi ProductoRecetaAPI=retrofit.create(ProductoNuevoRApi.class);
            ProductoBorradoReceta ProductoBRecetaAPI=retrofit.create(ProductoBorradoReceta.class);


            ArrayList datos1 = new ArrayList ();
            ArrayList datos2 = new ArrayList ();


            while (productosDiponiblesBD.size () != indice){
                if(productos.contains (productosDiponiblesBD.get (indice)) == false){
                    ProductosNuevoRecetas object = new ProductosNuevoRecetas ();
                    try {
                        object.setNombre (nombreReceta);
                        object.setPorcion (Integer.parseInt (por.getText ().toString ()));
                        object.setProducto (productosDiponiblesBD.get (indice));
                        datos1.add (object);


                    } catch (Exception e) {
                        e.printStackTrace ();
                    }
                }
                indice++;
            }

            Call<ArrayList<ProductosNuevoRecetas>> call=ProductoRecetaAPI.env(datos1);
            call.enqueue(new Callback<ArrayList<ProductosNuevoRecetas>>() {
                @Override
                public void onResponse(Call<ArrayList<ProductosNuevoRecetas>> call, Response<ArrayList<ProductosNuevoRecetas>> response) {
                    try
                    {
                        Toast.makeText(Gestion_Recetas.this, "", Toast.LENGTH_SHORT).show();
                    }catch (Exception ex){
                        Toast.makeText(Gestion_Recetas.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onFailure(Call<ArrayList<ProductosNuevoRecetas>> call, Throwable t) {
                }
            });

            indice = 0;

            while (productosAgregadosBD.size () != indice){
                if(agregado.contains (productosAgregadosBD.get (indice)) == false){
                    ProductosNuevoRecetas object = new ProductosNuevoRecetas ();
                    try {
                        object.setNombre (nombreReceta);
                        object.setPorcion (Integer.parseInt (por.getText ().toString ()));
                        object.setProducto (productosAgregadosBD.get (indice));
                        datos2.add (object);

                    } catch (Exception e) {
                        e.printStackTrace ();
                    }
                }
                indice++;
            }
            Call<ArrayList<ProductosNuevoRecetas>> call2 = ProductoBRecetaAPI.env(datos2);
            call2.enqueue(new Callback<ArrayList<ProductosNuevoRecetas>>() {
                @Override
                public void onResponse(Call<ArrayList<ProductosNuevoRecetas>> call2, Response<ArrayList<ProductosNuevoRecetas>> response) {
                    try
                    {
                        Toast.makeText(Gestion_Recetas.this, "", Toast.LENGTH_SHORT).show();
                    }catch (Exception ex){
                        Toast.makeText(Gestion_Recetas.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
                    }
                }

                @Override
                public void onFailure(Call<ArrayList<ProductosNuevoRecetas>> call2, Throwable t) {
                }
            });

        }

        else{
            Toast.makeText(Gestion_Recetas.this, "Puede faltar el nombre, porcion o cantida insuficiente de productos", Toast.LENGTH_SHORT).show();

        }


        Intent principal = new Intent(this, VerRecetas.class);
        principal.putExtra ("email", email);
        startActivity (principal);

        }

    /**
     *
     * @param v Tipo vista para ser detectado por el boton
     */
        public void EliminarReceta(View v){
    AlertDialog.Builder dialogo1 = new AlertDialog.Builder(this);
        dialogo1.setTitle("Importante");
        dialogo1.setMessage("¿Desea eliminar la receta?");
        dialogo1.setCancelable(false);
        dialogo1.setPositiveButton("Confirmar", new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialogo1, int id) {
            aceptar();
        }
    });
        dialogo1.setNegativeButton("Cancelar", new DialogInterface.OnClickListener() {
        public void onClick(DialogInterface dialogo1, int id) {
            dialogo1.cancel ();
        }
    });
        dialogo1.show();


}

    public void aceptar() {


        Retrofit retrofit = new Retrofit.Builder().baseUrl(BASEURL)
                .addConverterFactory(GsonConverterFactory.create()).build();
        EliminarRecetaApi ElimRecetaAPI=retrofit.create(EliminarRecetaApi.class);





        EliminarReceta object = new EliminarReceta ();

        object.setEmail (email);
        object.setNombre (nombreReceta);




        Call<EliminarReceta> call=ElimRecetaAPI.env(object);
        call.enqueue(new Callback<EliminarReceta>() {
            @Override
            public void onResponse(Call<EliminarReceta> call, Response<EliminarReceta> response) {
                try
                {
                    Toast.makeText(Gestion_Recetas.this, "", Toast.LENGTH_SHORT).show();
                }catch (Exception ex){
                    Toast.makeText(Gestion_Recetas.this, ex.getMessage(), Toast.LENGTH_SHORT).show();
                }
            }

            @Override
            public void onFailure(Call<EliminarReceta> call, Throwable t) {
            }
        });

        Intent principal = new Intent(this, VerRecetas.class);
        principal.putExtra ("email", email);
        startActivity (principal);

    }


}




