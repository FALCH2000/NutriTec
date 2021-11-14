package tarea1.tec.proyecto2.Interfaces;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.POST;
import tarea1.tec.proyecto2.Modelos.ProductosNuevoRecetas;

public interface ProductoBorradoReceta {
    @POST("/api/Receta/BorrarProdcutoReceta/delete")
    public Call<ArrayList<ProductosNuevoRecetas>> env(@Body ArrayList<ProductosNuevoRecetas> Body);
}
