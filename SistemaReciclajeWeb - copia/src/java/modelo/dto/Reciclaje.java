package modelo.dto;

public class Reciclaje {
    private int id;
    private int usuarioId;
    private int materialId;
    private double cantidadKg;
    private int puntosObtenidos;
    private String fecha; // ¡Esta es la clave! Ahora es String
    private String materialNombre;

    public Reciclaje() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUsuarioId() { return usuarioId; }
    public void setUsuarioId(int usuarioId) { this.usuarioId = usuarioId; }

    public int getMaterialId() { return materialId; }
    public void setMaterialId(int materialId) { this.materialId = materialId; }

    public double getCantidadKg() { return cantidadKg; }
    public void setCantidadKg(double cantidadKg) { this.cantidadKg = cantidadKg; }

    public int getPuntosObtenidos() { return puntosObtenidos; }
    public void setPuntosObtenidos(int puntosObtenidos) { this.puntosObtenidos = puntosObtenidos; }

    public String getFecha() { return fecha; }
    public void setFecha(String fecha) { this.fecha = fecha; }

    public String getMaterialNombre() { return materialNombre; }
    public void setMaterialNombre(String materialNombre) { this.materialNombre = materialNombre; }
}