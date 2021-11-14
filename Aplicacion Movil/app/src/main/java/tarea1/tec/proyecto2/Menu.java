package tarea1.tec.proyecto2;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

import pl.droidsonroids.gif.GifImageView;

public class Menu extends AppCompatActivity {

    public String email;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate (savedInstanceState);
        setContentView (R.layout.activity_menu);
        Bundle bundle = this.getIntent ().getExtras ();
        email = bundle.getString ("email");

    }

    public void Ini_Registro(View view){
        Intent principal = new Intent(this, Registro_Diario.class);
        principal.putExtra ("email", email);
        startActivity (principal);
    }

    public void Ini_Gestion(View view){
        Intent principal = new Intent(this, VerRecetas.class);
        principal.putExtra ("email", email);
        startActivity (principal);
    }
    public void animacion(View view){
        GifImageView imprin = findViewById (R.id.imageView2);
        GifImageView img2 = findViewById (R.id.imageView4);
        imprin.setVisibility (View.INVISIBLE);
        img2.setVisibility (View.VISIBLE);
    }
}