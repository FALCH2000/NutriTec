package tarea1.tec.proyecto2.Interfaces;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface PorcionRecetaApi {
    /**
     *
     * metodo para obtener porcion de una receta
     */
    @GET("api/Receta/porcionReceta/{email}/{nombre}")
    public Call<String> find(@Path("email") String email, @Path("nombre") String nombre);
}
