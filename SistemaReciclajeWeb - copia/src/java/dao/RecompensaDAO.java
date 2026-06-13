package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Recompensa;
import ConexionBD.ConexionBD;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class RecompensaDAO {

    private static final Logger LOG = LoggerFactory.getLogger(RecompensaDAO.class);

    public List<Recompensa> obtenerTodas() {
        List<Recompensa> lista = new ArrayList<>();
        String sql = "SELECT * FROM recompensas WHERE stock > 0";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Recompensa r = new Recompensa();
                r.setId(rs.getInt("id"));
                r.setNombre(rs.getString("nombre"));
                r.setDescripcion(rs.getString("descripcion"));
                r.setPuntosRequeridos(rs.getInt("puntos_requeridos"));
                r.setStock(rs.getInt("stock"));
                lista.add(r);
            }
            LOG.info("Se obtuvieron {} recompensas con stock disponible.", lista.size());
        } catch (SQLException e) {
            LOG.error("Error al obtener el catalogo de recompensas: {}", e.getMessage(), e);
        }
        return lista;
    }

    public Recompensa obtenerPorId(int id) {
        String sql = "SELECT * FROM recompensas WHERE id = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Recompensa r = new Recompensa();
                    r.setId(rs.getInt("id"));
                    r.setNombre(rs.getString("nombre"));
                    r.setDescripcion(rs.getString("descripcion"));
                    r.setPuntosRequeridos(rs.getInt("puntos_requeridos"));
                    r.setStock(rs.getInt("stock"));
                    return r;
                }
            }
            LOG.warn("No se encontro la recompensa con id={}", id);
        } catch (SQLException e) {
            LOG.error("Error al obtener la recompensa id={}: {}", id, e.getMessage(), e);
        }
        return null;
    }

    public boolean canjear(int usuarioId, int recompensaId) {
        String sqlInsert = "INSERT INTO canjes (usuario_id, recompensa_id) VALUES (?, ?)";
        String sqlStock  = "UPDATE recompensas SET stock = stock - 1 WHERE id = ? AND stock > 0";
        try (Connection con = ConexionBD.getConexion()) {
            con.setAutoCommit(false); // Transaccion
            try (PreparedStatement ps1 = con.prepareStatement(sqlInsert);
                 PreparedStatement ps2 = con.prepareStatement(sqlStock)) {

                ps1.setInt(1, usuarioId);
                ps1.setInt(2, recompensaId);
                ps1.executeUpdate();

                ps2.setInt(1, recompensaId);
                int filas = ps2.executeUpdate();

                if (filas == 0) {
                    con.rollback(); // Falla si no hay stock
                    LOG.warn("Canje rechazado: sin stock. usuario={}, recompensa={}", usuarioId, recompensaId);
                    return false;
                }

                con.commit();
                LOG.info("Canje exitoso: usuario={}, recompensa={}", usuarioId, recompensaId);
                return true;
            } catch (SQLException e) {
                con.rollback();
                LOG.error("Error en transaccion de canje (usuario={}, recompensa={}): {}",
                        usuarioId, recompensaId, e.getMessage(), e);
                return false;
            }
        } catch (SQLException e) {
            LOG.error("Error de conexion durante el canje (usuario={}, recompensa={}): {}",
                    usuarioId, recompensaId, e.getMessage(), e);
            return false;
        }
    }
}