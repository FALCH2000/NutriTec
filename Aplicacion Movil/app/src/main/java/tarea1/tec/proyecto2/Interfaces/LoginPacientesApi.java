package tarea1.tec.proyecto2.Interfaces;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import tarea1.tec.proyecto2.Modelos.Login;

public interface LoginPacientesApi {
    /**
     * Metodo para validar login
     * */
    @GET("api/paciente/validar/{user}/{pwd}")
    public Call<Boolean> find(@Path("user") String user, @Path("pwd") String pass);
}
