package modelo.dto;

import java.sql.Timestamp;

public class Usuario {

    private int id;
    private String nombre;
    private String email;
    private String password;
    private int puntosTotal;
    private Timestamp fechaRegistro;

    public Usuario() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public int getPuntosTotal() { return puntosTotal; }
    public void setPuntosTotal(int puntosTotal) { this.puntosTotal = puntosTotal; }
    public Timestamp getFechaRegistro() { return fechaRegistro; }
    public void setFechaRegistro(Timestamp fechaRegistro) { this.fechaRegistro = fechaRegistro; }
}