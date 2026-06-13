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
}