package tarea1.tec.proyecto2.Interfaces;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import tarea1.tec.proyecto2.Modelos.RegistroM;
import tarea1.tec.proyecto2.Modelos.nuevaReceta;

public interface NuevaRecetaApi {
    /**
     *Metodo para insertar una nueva receta
     */
    @POST("/api/Receta/NuevaReceta/insert")
    public Call<ArrayList<nuevaReceta>> env(@Body ArrayList<nuevaReceta> Body);
}
