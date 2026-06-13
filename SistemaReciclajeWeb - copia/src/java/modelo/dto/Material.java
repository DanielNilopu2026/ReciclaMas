package modelo.dto;

public class Material {

    private int id;
    private String nombre;
    private double puntosPorKg;

    public Material() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public double getPuntosPorKg() { return puntosPorKg; }
    public void setPuntosPorKg(double puntosPorKg) { this.puntosPorKg = puntosPorKg; }
}