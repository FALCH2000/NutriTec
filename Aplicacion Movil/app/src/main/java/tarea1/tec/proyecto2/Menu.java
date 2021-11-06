package tarea1.tec.proyecto2;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class Menu extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_menu);
    }

    public void Ini_Registro(View view){
        Intent principal = new Intent(this, Registro_Diario.class);
        startActivity (principal);
    }

    public void Ini_Gestion(View view){
        Intent principal = new Intent(this, Gestion_Recetas.class);
        startActivity (principal);
    }
}