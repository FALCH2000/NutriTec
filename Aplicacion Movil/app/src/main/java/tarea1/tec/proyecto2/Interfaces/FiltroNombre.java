package tarea1.tec.proyecto2.Interfaces;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface FiltroNombre {
    /**
     *
     * Obtener producto por su nombre
     */
    @GET("api/Receta/ProductoFiltroNombre/{email}/{nombre}")
    public Call<List<String>> find(@Path("email") String email, @Path("nombre") String nombre);
}
