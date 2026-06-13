package controladores;

import dao.RecompensaDAO;
import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import modelo.dto.Recompensa;
import modelo.dto.Usuario;

@WebServlet("/ControladorRecompensa")
public class ControladorRecompensa extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp"); return;
        }
        cargarCatalogo(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp"); return;
        }
        request.setCharacterEncoding("UTF-8");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        try {
            int recompensaId        = Integer.parseInt(request.getParameter("recompensaId"));
            RecompensaDAO rDAO      = new RecompensaDAO();
            UsuarioDAO uDAO         = new UsuarioDAO();
            Recompensa recompensa   = rDAO.obtenerPorId(recompensaId);

            if (recompensa == null) {
                request.setAttribute("error", "La recompensa no existe o ya no está disponible.");
            } else if (usuario.getPuntosTotal() < recompensa.getPuntosRequeridos()) {
                request.setAttribute("error",
                    "No tienes suficientes puntos. Necesitas " + recompensa.getPuntosRequeridos()
                    + " pts y tienes " + usuario.getPuntosTotal() + " pts.");
            } else {
                if (uDAO.descontarPuntos(usuario.getId(), recompensa.getPuntosRequeridos())) {
                    if (rDAO.canjear(usuario.getId(), recompensaId)) {
                        Usuario actualizado = uDAO.obtenerPorId(usuario.getId());
                        session.setAttribute("usuario", actualizado);
                        request.setAttribute("exito",
                            "¡Canje exitoso! Obtuviste: " + recompensa.getNombre()
                            + ". Te descontamos " + recompensa.getPuntosRequeridos() + " pts.");
                    } else {
                        uDAO.actualizarPuntos(usuario.getId(), recompensa.getPuntosRequeridos());
                        request.setAttribute("error", "Stock agotado. Tus puntos fueron restaurados.");
                    }
                } else {
                    request.setAttribute("error", "Error al procesar el canje. Intenta de nuevo.");
                }
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Solicitud inválida.");
        }
        cargarCatalogo(request, response);
    }

    private void cargarCatalogo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RecompensaDAO dao = new RecompensaDAO();
        request.setAttribute("recompensas", dao.obtenerTodas());
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}