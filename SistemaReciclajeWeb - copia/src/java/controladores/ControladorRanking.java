package controladores;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import modelo.dto.Usuario;

@WebServlet("/ControladorRanking")
public class ControladorRanking extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        UsuarioDAO dao = new UsuarioDAO();
        List<Usuario> ranking = dao.obtenerRanking();
        // CORRECCIÓN: el atributo se llama "ranking" para que ranking.jsp lo lea bien
        request.setAttribute("ranking", ranking);
        request.getRequestDispatcher("ranking.jsp").forward(request, response);
    }
}