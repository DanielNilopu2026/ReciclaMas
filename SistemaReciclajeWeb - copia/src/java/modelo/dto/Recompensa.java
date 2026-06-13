package modelo.dto;

public class Recompensa {

    private int id;
    private String nombre;
    private String descripcion;
    private int puntosRequeridos;
    private int stock;

    public Recompensa() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public int getPuntosRequeridos() { return puntosRequeridos; }
    public void setPuntosRequeridos(int puntosRequeridos) { this.puntosRequeridos = puntosRequeridos; }
    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }
}