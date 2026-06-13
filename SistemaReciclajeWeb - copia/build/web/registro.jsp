package dao;

import ConexionBD.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Reciclaje;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ReciclajeDAO {

    private static final Logger LOG = LoggerFactory.getLogger(ReciclajeDAO.class);

    public boolean registrar(Reciclaje rec) {
        Connection con = null;
        PreparedStatement psInsert = null;
        PreparedStatement psUpdate = null;
        try {
            con = ConexionBD.getConexion();
            con.setAutoCommit(false);

            String sql1 = "INSERT INTO reciclajes (usuario_id, material_id, cantidad_kg, puntos_obtenidos, fecha) VALUES (?, ?, ?, ?, NOW())";
            psInsert = con.prepareStatement(sql1);
            psInsert.setInt(1, rec.getUsuarioId());
            psInsert.setInt(2, rec.getMaterialId());
            psInsert.setDouble(3, rec.getCantidadKg());
            psInsert.setInt(4, rec.getPuntosObtenidos());
            psInsert.executeUpdate();

            String sql2 = "UPDATE usuarios SET puntos_total = puntos_total + ? WHERE id = ?";
            psUpdate = con.prepareStatement(sql2);
            psUpdate.setInt(1, rec.getPuntosObtenidos());
            psUpdate.setInt(2, rec.getUsuarioId());
            psUpdate.executeUpdate();

            con.commit();
            LOG.info("Reciclaje registrado: usuario={}, material={}, cantidadKg={}, puntos={}",
                    rec.getUsuarioId(), rec.getMaterialId(), rec.getCantidadKg(), rec.getPuntosObtenidos());
            return true;
        } catch (SQLException e) {
            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                LOG.error("Error al hacer rollback del registro de reciclaje: {}", ex.getMessage(), ex);
            }
            LOG.error("Error al registrar reciclaje para usuario={}: {}", rec.getUsuarioId(), e.getMessage(), e);
            return false;
        } finally {
            try {
                if (psInsert != null) psInsert.close();
                if (psUpdate != null) psUpdate.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                LOG.warn("Error al cerrar recursos JDBC en ReciclajeDAO.registrar: {}", e.getMessage());
            }
        }
    }

    public List<Reciclaje> obtenerHistorial(int usuarioId) {
        List<Reciclaje> lista = new ArrayList<>();
        String sql = "SELECT r.fecha, m.nombre as material_nombre, r.cantidad_kg, r.puntos_obtenidos " +
                     "FROM reciclajes r INNER JOIN materiales m ON r.material_id = m.id " +
                     "WHERE r.usuario_id = ? ORDER BY r.fecha DESC";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reciclaje r = new Reciclaje();
                    r.setFecha(rs.getString("fecha"));
                    r.setMaterialNombre(rs.getString("material_nombre"));
                    r.setCantidadKg(rs.getDouble("cantidad_kg"));
                    r.setPuntosObtenidos(rs.getInt("puntos_obtenidos"));
                    lista.add(r);
                }
            }
            LOG.info("Historial de reciclaje obtenido para usuario={}: {} registros.", usuarioId, lista.size());
        } catch (SQLException e) {
            LOG.error("Error al obtener historial de usuario={}: {}", usuarioId, e.getMessage(), e);
        }
        return lista;
    }
}<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReciclaMas - Crear Cuenta</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #176B4E 0%, #1E825F 60%, #2da876 100%);
            min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 1.5rem;
        }
        .reg-card {
            background: #fff; border-radius: 20px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.25);
            width: 100%; max-width: 460px; padding: 2.5rem;
        }
        .reg-brand { font-size: 1.6rem; font-weight: 800; color: #176B4E; text-align: center; margin-bottom: 0.4rem; }
        .reg-title { font-size: 1.25rem; font-weight: 700; color: #2D3748; text-align: center; margin-bottom: 0.25rem; }
        .reg-subtitle { color: #718096; font-size: 0.88rem; text-align: center; margin-bottom: 2rem; }
        .form-group { margin-bottom: 1.2rem; }
        .form-label { display: block; font-weight: 500; font-size: 0.85rem; color: #4A5568; margin-bottom: 0.45rem; }
        .form-input {
            width: 100%; padding: 0.75rem 1rem;
            border: 1.5px solid #E2E8F0; border-radius: 8px;
            font-size: 0.95rem; font-family: 'Inter', sans-serif;
            color: #2D3748; background: #F8FAFC; transition: all 0.2s;
        }
        .form-input:focus { outline: none; border-color: #176B4E; background: #fff; box-shadow: 0 0 0 3px rgba(23,107,78,0.1); }
        .btn-reg {
            width: 100%; padding: 0.85rem; background: #176B4E; color: white;
            border: none; border-radius: 8px; font-size: 1rem; font-weight: 600;
            cursor: pointer; font-family: 'Inter', sans-serif; transition: background 0.2s; margin-top: 0.5rem;
        }
        .btn-reg:hover { background: #1E825F; }
        .alert-error {
            background: #FED7D7; border-left: 4px solid #E53E3E;
            color: #742A2A; padding: 0.75rem 1rem; border-radius: 8px;
            font-size: 0.88rem; margin-bottom: 1.2rem; font-weight: 500;
        }
        .reg-footer { margin-top: 1.5rem; text-align: center; font-size: 0.88rem; color: #718096; }
        .reg-footer a { color: #176B4E; font-weight: 600; text-decoration: none; }
        .divider { border: none; border-top: 1px solid #E2E8F0; margin: 1.5rem 0; }
    </style>
</head>
<body>
<div class="reg-card">
    <div class="reg-brand">♻ ReciclaMas</div>
    <h1 class="reg-title">Crear nueva cuenta</h1>
    <p class="reg-subtitle">Únete a la comunidad y empieza a reciclar hoy</p>
    <% if (request.getAttribute("error") != null) { %>
        <div class="alert-error">⚠ <%= request.getAttribute("error") %></div>
    <% } %>
    <form action="ControladorUsuario" method="POST">
        <input type="hidden" name="accion" value="registro">
        <div class="form-group">
            <label class="form-label">Nombre Completo</label>
            <input class="form-input" type="text" name="nombre" required placeholder="Ej: Juan García López" maxlength="100">
        </div>
        <div class="form-group">
            <label class="form-label">Correo Electrónico</label>
            <input class="form-input" type="email" name="email" required placeholder="tu@email.com" maxlength="150">
        </div>
        <div class="form-group">
            <label class="form-label">Contraseña</label>
            <input class="form-input" type="password" name="password" required placeholder="Mínimo 6 caracteres" minlength="6">
        </div>
        <button type="submit" class="btn-reg">Crear Cuenta Gratis</button>
    </form>
    <hr class="divider">
    <div class="reg-footer">
        ¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión aquí</a>
    </div>
</div>
</body>
</html>