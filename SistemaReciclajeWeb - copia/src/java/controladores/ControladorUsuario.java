package controladores;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;
import modelo.dto.Usuario;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet("/ControladorUsuario")
public class ControladorUsuario extends HttpServlet {

    private static final Logger LOG = LoggerFactory.getLogger(ControladorUsuario.class);
    private static final int PASSWORD_MIN_LENGTH = 6;
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$");
    private static final String LETRAS_VALIDAS = "AaÁáBbCcDdEeÉéFfGgHhIiÍíJjKkLlMmNnÑñOoÓóPpQqRrSsTtUuÚúÜüVvWwXxYyZz";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        if ("login".equals(accion)) {
            procesarLogin(request, response);
        } else if ("registro".equals(accion)) {
            procesarRegistro(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if ("logout".equals(accion)) {
            procesarLogout(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    private void procesarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email    = StringUtils.trim(request.getParameter("email"));
        String password = request.getParameter("password");

        if (StringUtils.isBlank(email) || StringUtils.isBlank(password)) {
            request.setAttribute("error", "Debes ingresar tu correo y contraseña.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao  = new UsuarioDAO();
        Usuario usuario = dao.login(email, password);
        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", usuario);
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Email o contraseña incorrectos. Intente de nuevo.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void procesarRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nombre   = StringUtils.trim(request.getParameter("nombre"));
        String email    = StringUtils.trim(request.getParameter("email"));
        String password = request.getParameter("password");

        if (StringUtils.isBlank(nombre) || StringUtils.isBlank(email) || StringUtils.isBlank(password)) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("error", "El formato del correo electrónico no es válido.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        if (password.length() < PASSWORD_MIN_LENGTH) {
            request.setAttribute("error",
                    "La contraseña debe tener mínimo " + PASSWORD_MIN_LENGTH + " caracteres.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        String nombreSinEspacios = StringUtils.deleteWhitespace(nombre);
        if (!StringUtils.containsOnly(nombreSinEspacios, LETRAS_VALIDAS.toCharArray())) {
            request.setAttribute("error", "El nombre solo debe contener letras y espacios.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        if (dao.emailExiste(email)) {
            request.setAttribute("error", "El correo ya está registrado. Usa otro o inicia sesión.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
            return;
        }

        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setEmail(StringUtils.lowerCase(email));
        u.setPassword(password);

        if (dao.registrar(u)) {
            request.setAttribute("exito", "¡Registro exitoso! Ahora puedes iniciar sesión.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            LOG.error("Fallo al registrar el usuario con correo: {}", email);
            request.setAttribute("error", "Error al registrar. Por favor intenta de nuevo.");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }
    }

    private void procesarLogout(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object usuario = session.getAttribute("usuario");
            if (usuario instanceof Usuario u) {
                LOG.info("Cierre de sesion del usuario: {}", u.getEmail());
            }
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
}