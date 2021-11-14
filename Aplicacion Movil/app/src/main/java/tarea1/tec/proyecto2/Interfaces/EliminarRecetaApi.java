package tarea1.tec.proyecto2.Interfaces;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import tarea1.tec.proyecto2.Modelos.EliminarReceta;
import tarea1.tec.proyecto2.Modelos.ProductosNuevoRecetas;

public interface EliminarRecetaApi {

    @POST("/api/Receta/delete")
    public Call<EliminarReceta> env(@Body EliminarReceta Body);
}
