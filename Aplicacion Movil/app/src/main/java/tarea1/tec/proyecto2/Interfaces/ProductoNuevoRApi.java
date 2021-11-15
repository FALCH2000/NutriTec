package tarea1.tec.proyecto2.Interfaces;

import java.util.ArrayList;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import tarea1.tec.proyecto2.Modelos.ProductosNuevoRecetas;
import tarea1.tec.proyecto2.Modelos.nuevaReceta;

public interface ProductoNuevoRApi {
    /**
     *
     * Metodo para insertar un nuevo producto en una receta
     */
    @POST("/api/Receta/NuevoProdcutoReceta/insert")
    public Call<ArrayList<ProductosNuevoRecetas>> env(@Body ArrayList<ProductosNuevoRecetas> Body);
}
