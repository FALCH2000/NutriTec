package tarea1.tec.proyecto2.Modelos;

public class nuevaReceta {
    private String email;
    private String nombre;
    private int tamano;
    private String producto;

    /**
     *
     * @return String email paciente
     */
    public String getEmail() {
        return email;
    }

    /**
     *
     * @param email String email paciente
     */

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     *
     * @return String nombre de la receta
     */
    public String getNombre() {
        return nombre;
    }

    /**
     *
     * @param nombre String nombre de la receta
     */
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     *
     * @return int tamaño de porción en gramos
     */

    public int getTamano() {
        return tamano;
    }

    /**
     *
     * @param tamano int tamaño de porción en gramos
     */
    public void setTamano(int tamano) {
        this.tamano = tamano;
    }

    /**
     *
     * @return String nombre del producto
     */
    public String getProducto() {
        return producto;
    }

    /**
     *
     * @param producto String nombre del producto
     */

    public void setProducto(String producto) {
        this.producto = producto;
    }
}
