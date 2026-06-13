package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Usuario;
import ConexionBD.ConexionBD;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UsuarioDAO {

    private static final Logger LOG = LoggerFactory.getLogger(UsuarioDAO.class);

    public Usuario login(String email, String password) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password); // En un proyecto real, usa BCrypt aqui
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setPuntosTotal(rs.getInt("puntos_total"));
                    u.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                    LOG.info("Inicio de sesion exitoso para el usuario: {}", email);
                    return u;
                }
            }
            LOG.warn("Intento de login fallido para el correo: {}", email);
        } catch (SQLException e) {
            LOG.error("Error al validar credenciales del usuario {}: {}", email, e.getMessage(), e);
        }
        return null;
    }

    public boolean emailExiste(String email) {
        String sql = "SELECT id FROM usuarios WHERE email = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            LOG.error("Error al verificar existencia del correo {}: {}", email, e.getMessage(), e);
            return false;
        }
    }

    public boolean registrar(Usuario u) {
        String sql = "INSERT INTO usuarios (nombre, email, password) VALUES (?, ?, ?)";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                LOG.info("Nuevo usuario registrado: {}", u.getEmail());
            } else {
                LOG.warn("No se pudo registrar al usuario: {}", u.getEmail());
            }
            return ok;
        } catch (SQLException e) {
            LOG.error("Error al registrar usuario {}: {}", u.getEmail(), e.getMessage(), e);
            return false;
        }
    }

    public boolean actualizarPuntos(int usuarioId, int puntosNuevos) {
        String sql = "UPDATE usuarios SET puntos_total = puntos_total + ? WHERE id = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, puntosNuevos);
            ps.setInt(2, usuarioId);
            boolean ok = ps.executeUpdate() > 0;
            LOG.info("Puntos restaurados/actualizados para usuario={}: +{} pts (ok={})", usuarioId, puntosNuevos, ok);
            return ok;
        } catch (SQLException e) {
            LOG.error("Error al actualizar puntos del usuario={}: {}", usuarioId, e.getMessage(), e);
            return false;
        }
    }

    public boolean descontarPuntos(int usuarioId, int puntosARestar) {
        String sql = "UPDATE usuarios SET puntos_total = puntos_total - ? WHERE id = ? AND puntos_total >= ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, puntosARestar);
            ps.setInt(2, usuarioId);
            ps.setInt(3, puntosARestar);
            boolean ok = ps.executeUpdate() > 0;
            if (!ok) {
                LOG.warn("Intento de descuento de puntos rechazado (saldo insuficiente). usuario={}, puntos={}", usuarioId, puntosARestar);
            }
            return ok;
        } catch (SQLException e) {
            LOG.error("Error al descontar puntos del usuario={}: {}", usuarioId, e.getMessage(), e);
            return false;
        }
    }

    public Usuario obtenerPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setPuntosTotal(rs.getInt("puntos_total"));
                    u.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                    return u;
                }
            }
            LOG.warn("No se encontro el usuario con id={}", id);
        } catch (SQLException e) {
            LOG.error("Error al obtener usuario id={}: {}", id, e.getMessage(), e);
        }
        return null;
    }

    public List<Usuario> obtenerRanking() {
        List<Usuario> ranking = new ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY puntos_total DESC LIMIT 10";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setPuntosTotal(rs.getInt("puntos_total"));
                ranking.add(u);
            }
            LOG.info("Ranking generado con {} usuarios.", ranking.size());
        } catch (SQLException e) {
            LOG.error("Error al generar el ranking de usuarios: {}", e.getMessage(), e);
        }
        return ranking;
    }
}