package controladores;

import dao.MaterialDAO;
import dao.ReciclajeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.dto.Material;
import modelo.dto.Reciclaje;
import modelo.dto.Usuario;

@WebServlet(name = "ControladorReciclaje", urlPatterns = {"/ControladorReciclaje"})
public class ControladorReciclaje extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { procesarPeticion(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { procesarPeticion(request, response); }

    private void procesarPeticion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp"); return;
        }
        String accion = request.getParameter("accion");
        if (accion == null) accion = "formulario";
        switch (accion) {
            case "formulario" -> mostrarFormulario(request, response);
            case "registrar"  -> registrarReciclaje(request, response, session);
            case "historial"  -> mostrarHistorial(request, response, session);
            default           -> response.sendRedirect("dashboard.jsp");
        }
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MaterialDAO matDAO = new MaterialDAO();
        request.setAttribute("materiales", matDAO.obtenerTodos());
        request.getRequestDispatcher("registrarReciclaje.jsp").forward(request, response);
    }

    private void registrarReciclaje(HttpServletRequest request, HttpServletResponse response,
                                    HttpSession session) throws ServletException, IOException {
        Usuario user = (Usuario) session.getAttribute("usuario");
        try {
            int materialId  = Integer.parseInt(request.getParameter("material_id"));
            double cantidad = Double.parseDouble(request.getParameter("cantidad"));
            if (cantidad <= 0) {
                request.setAttribute("error", "La cantidad debe ser mayor a 0.");
                mostrarFormulario(request, response); return;
            }
            // Obtener puntos desde la BD (no hardcodeado)
            MaterialDAO matDAO = new MaterialDAO();
            Material material  = matDAO.obtenerPorId(materialId);
            if (material == null) {
                request.setAttribute("error", "Material no encontrado.");
                mostrarFormulario(request, response); return;
            }
            int puntosGanados = (int)(cantidad * material.getPuntosPorKg());
            Reciclaje rec = new Reciclaje();
            rec.setUsuarioId(user.getId());
            rec.setMaterialId(materialId);
            rec.setCantidadKg(cantidad);
            rec.setPuntosObtenidos(puntosGanados);
            ReciclajeDAO recDAO = new ReciclajeDAO();
            if (recDAO.registrar(rec)) {
                user.setPuntosTotal(user.getPuntosTotal() + puntosGanados);
                session.setAttribute("usuario", user);
                request.setAttribute("exito",
                    "¡Genial! Registraste " + cantidad + " kg de " + material.getNombre()
                    + " y sumaste " + puntosGanados + " puntos. Total: " + user.getPuntosTotal() + " pts.");
            } else {
                request.setAttribute("error", "Error al registrar en la base de datos. Intente de nuevo.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos. Completa el formulario correctamente.");
        }
        mostrarFormulario(request, response);
    }

    private void mostrarHistorial(HttpServletRequest request, HttpServletResponse response,
                                   HttpSession session) throws ServletException, IOException {
        Usuario user = (Usuario) session.getAttribute("usuario");
        ReciclajeDAO recDAO = new ReciclajeDAO();
        request.setAttribute("historial", recDAO.obtenerHistorial(user.getId()));
        request.getRequestDispatcher("historial.jsp").forward(request, response);
    }
}