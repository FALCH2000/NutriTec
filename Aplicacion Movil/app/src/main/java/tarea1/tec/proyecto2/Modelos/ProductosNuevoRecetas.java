package tarea1.tec.proyecto2.Modelos;

public class ProductosNuevoRecetas {
    private String nombre;
    private String producto;
    private int porcion;


    public String getNombre() {
        return nombre;
    }

    /**
     *
     * @param nombre String nombre
     */

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    /**
     *
     * @return String nombre producto
     */

    public String getProducto() {
        return producto;
    }

    /**
     *
     * @param producto String nombre producto
     */

    public void setProducto(String producto) {
        this.producto = producto;
    }

    /**
     *
     * @return Int porción de receta
     */

    public int getPorcion() {
        return porcion;
    }

    /**
     *
     * @param porcion int porción receta
     */
    public void setPorcion(int porcion) {
        this.porcion = porcion;
    }
}
