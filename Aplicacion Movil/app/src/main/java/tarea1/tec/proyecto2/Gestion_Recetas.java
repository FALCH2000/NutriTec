package tarea1.tec.proyecto2;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class Gestion_Recetas extends AppCompatActivity {
    public ArrayList<String> productos = new ArrayList<String> ();
    public ArrayList<String> agregado = new ArrayList<String> ();
    public ArrayList<String> porcion = new ArrayList<String> ();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_gestion_recetas);
        CargarProductos ();
    }

    public void CargarProductos(){
        ConstraintLayout emergente;
        emergente = findViewById (R.id.CuadroEmergente);

        ListView listviewProducto;
        ListView listAgregado;
        ListView listPorcion;


        listviewProducto = findViewById (R.id.listProductos);
        listAgregado = findViewById (R.id.listAgregado);
        listPorcion = findViewById (R.id.porciones);




        productos.add ("Arroz");
        productos.add ("frijoles");
        productos.add ("aceite");
        productos.add ("pimienta");
        productos.add ("queso");
        productos.add ("leche");
        productos.add ("sal");
        productos.add ("azucar");


        ArrayAdapter<String> adaptador = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,productos);
        listviewProducto.setAdapter (adaptador);

        ArrayAdapter<String> adaptador2 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,agregado);

        ArrayAdapter<String> adaptador3 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,porcion);


        listviewProducto.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView adapter, View view, int position, long arg) {

                String text = (String) listviewProducto.getItemAtPosition(position);
                agregado.add (text);
                productos.remove (text);

                listviewProducto.setAdapter (adaptador);
                listAgregado.setAdapter (adaptador2);
                emergente.setVisibility (View.VISIBLE);
                listAgregado.setVisibility (View.INVISIBLE);
                listviewProducto.setVisibility (View.INVISIBLE);
                listPorcion.setVisibility (View.INVISIBLE);

            }
        });

        listAgregado.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView adapter, View view, int position, long arg) {

                String text = (String) listAgregado.getItemAtPosition(position);
                agregado.remove (text);
                productos.add (text);
                porcion.remove (position);

                listviewProducto.setAdapter (adaptador);
                listAgregado.setAdapter (adaptador2);
                listPorcion.setAdapter (adaptador3);



            }
        });

    }

    public void CargarPorcion(View v){
        ConstraintLayout emergente;
        emergente = findViewById (R.id.CuadroEmergente);
        ListView listPorcion;
        ListView listviewProducto;
        ListView listAgregado;
        listviewProducto = findViewById (R.id.listProductos);
        listAgregado = findViewById (R.id.listAgregado);
        listPorcion = findViewById (R.id.porciones);

        EditText Nporcion = findViewById (R.id.Porciones);
        if(Nporcion.getText ().toString ().equals ("")){
            Toast.makeText (Gestion_Recetas.this, "Agregar porcion", Toast.LENGTH_SHORT).show ();

        }else{
            porcion.add (Nporcion.getText ().toString ());
            ArrayAdapter<String> adaptador3 = new ArrayAdapter<String> (this,android.R.layout.simple_list_item_1,porcion);
            listPorcion.setAdapter (adaptador3);
            emergente.setVisibility (View.INVISIBLE);
            listAgregado.setVisibility (View.VISIBLE);
            listviewProducto.setVisibility (View.VISIBLE);
            listPorcion.setVisibility (View.VISIBLE);
            Nporcion.setText ("");

        }

    }




}