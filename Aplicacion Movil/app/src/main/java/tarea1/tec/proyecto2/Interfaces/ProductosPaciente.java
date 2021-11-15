package tarea1.tec.proyecto2.Interfaces;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

public interface ProductosPaciente {
    /**
     *
     * Metodo para obtener productos de un paciente
     */
    @GET("api/Receta/ProducPaciente/{email}")
    public Call<List<String>> find(@Path("email") String email);
}
