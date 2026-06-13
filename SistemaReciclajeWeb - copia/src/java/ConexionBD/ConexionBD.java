package ConexionBD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ConexionBD {

    private static final Logger LOG = LoggerFactory.getLogger(ConexionBD.class);

    private static final String URL = "jdbc:mysql://localhost:3306/sistema_reciclaje?serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "";

    public static Connection getConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(URL, USER, PASS);
            LOG.debug("Conexion a la base de datos sistema_reciclaje establecida correctamente.");
            return con;
        } catch (ClassNotFoundException e) {
            LOG.error("No se encontro el driver JDBC de MySQL: {}", e.getMessage());
            throw new SQLException("Error de Driver: " + e.getMessage());
        } catch (SQLException e) {
            LOG.error("No se pudo conectar a la base de datos sistema_reciclaje: {}", e.getMessage());
            throw e;
        }
    }
}