package tarea1.tec.proyecto2.Interfaces;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface FiltroCodigo {
    /**
     *
     *Metodo para obtener producto por su codigo
     */
    @GET("api/Receta/ProductoFiltroCodigo/{email}/{codigo}")
    public Call<List<String>> find(@Path("email") String email, @Path("codigo") String codigo);
}
