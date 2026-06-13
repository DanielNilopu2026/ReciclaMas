package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import modelo.dto.Material;
import ConexionBD.ConexionBD;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MaterialDAO {

    private static final Logger LOG = LoggerFactory.getLogger(MaterialDAO.class);

    public List<Material> obtenerTodos() {
        List<Material> lista = new ArrayList<>();
        String sql = "SELECT * FROM materiales";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Material m = new Material();
                m.setId(rs.getInt("id"));
                m.setNombre(rs.getString("nombre"));
                m.setPuntosPorKg(rs.getDouble("puntos_por_kg"));
                lista.add(m);
            }
            LOG.info("Se obtuvieron {} materiales reciclables.", lista.size());
        } catch (SQLException e) {
            LOG.error("Error al obtener la lista de materiales: {}", e.getMessage(), e);
        }
        return lista;
    }

    public Material obtenerPorId(int id) {
        String sql = "SELECT * FROM materiales WHERE id = ?";
        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Material m = new Material();
                    m.setId(rs.getInt("id"));
                    m.setNombre(rs.getString("nombre"));
                    m.setPuntosPorKg(rs.getDouble("puntos_por_kg"));
                    return m;
                }
            }
            LOG.warn("No se encontro el material con id={}", id);
        } catch (SQLException e) {
            LOG.error("Error al obtener el material id={}: {}", id, e.getMessage(), e);
        }
        return null;
    }
}