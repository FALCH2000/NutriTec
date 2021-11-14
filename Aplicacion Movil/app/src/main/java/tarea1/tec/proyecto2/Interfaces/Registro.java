package tarea1.tec.proyecto2.Interfaces;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import tarea1.tec.proyecto2.Modelos.RegistroM;

public interface Registro {
    @POST("/api/Receta/registro/insert")
    public Call<ArrayList<RegistroM>> env(@Body ArrayList<RegistroM> Body);
}
