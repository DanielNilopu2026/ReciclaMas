<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.dto.Reciclaje, modelo.dto.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    List<Reciclaje> lista = (List<Reciclaje>) request.getAttribute("historial");
    int totalPts = 0; double totalKg = 0;
    if (lista != null) { for (Reciclaje r : lista) { totalPts += r.getPuntosObtenidos(); totalKg += r.getCantidadKg(); } }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mi Historial - ReciclaMas</title>
    <%@include file="estilos.jsp" %>
</head>
<body>
    <%@include file="sidebar.jsp" %>
    <main class="rm-main">
        <div class="rm-page-header">
            <h1 class="rm-page-title">📋 Mi Historial de Reciclaje</h1>
            <p class="rm-page-subtitle">Todos tus aportes ecológicos registrados en el sistema</p>
        </div>

        <div class="rm-stats-grid" style="margin-bottom:1.75rem;">
            <div class="rm-stat-card">
                <div class="rm-stat-icon">📋</div>
                <div>
                    <div class="rm-stat-value"><%= lista != null ? lista.size() : 0 %></div>
                    <div class="rm-stat-label">Total Registros</div>
                </div>
            </div>
            <div class="rm-stat-card">
                <div class="rm-stat-icon naranja">⚖️</div>
                <div>
                    <div class="rm-stat-value"><%= String.format("%.1f", totalKg) %> kg</div>
                    <div class="rm-stat-label">Total Reciclado</div>
                </div>
            </div>
            <div class="rm-stat-card">
                <div class="rm-stat-icon">⭐</div>
                <div>
                    <div class="rm-stat-value"><%= totalPts %></div>
                    <div class="rm-stat-label">Puntos Generados</div>
                </div>
            </div>
        </div>

        <div class="rm-card">
            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:1.25rem; flex-wrap:wrap; gap:1rem;">
                <h2 style="font-size:1rem; font-weight:700; color:#2D3748;">Detalle de Registros</h2>
                <a href="ControladorReciclaje?accion=formulario" class="rm-btn-secondary">+ Nuevo Registro</a>
            </div>
            <% if (lista != null && !lista.isEmpty()) { %>
            <div class="rm-table-wrapper">
                <table class="rm-table">
                    <thead>
                        <tr><th>#</th><th>Fecha y Hora</th><th>Material</th><th>Cantidad</th><th>Puntos Ganados</th></tr>
                    </thead>
                    <tbody>
                        <% int num = 1;
                           for (Reciclaje r : lista) {
                               String icon = "♻";
                               String mat = r.getMaterialNombre() != null ? r.getMaterialNombre().toLowerCase() : "";
                               if (mat.contains("pl")) icon = "🧴";
                               else if (mat.contains("cart")) icon = "📦";
                               else if (mat.contains("vid")) icon = "🍶";
                               else if (mat.contains("met")) icon = "🔩"; %>
                        <tr>
                            <td style="color:#718096; font-size:0.85rem;"><%= num++ %></td>
                            <td style="color:#718096; font-size:0.88rem;"><%= r.getFecha() %></td>
                            <td><span style="margin-right:6px;"><%= icon %></span><%= r.getMaterialNombre() %></td>
                            <td><strong><%= r.getCantidadKg() %> kg</strong></td>
                            <td><span class="rm-pts-badge">+<%= r.getPuntosObtenidos() %> pts</span></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } else { %>
            <div class="rm-empty">
                <div class="rm-empty-icon">📋</div>
                <h3>Aún no tienes registros</h3>
                <p>¡Empieza a reciclar hoy!</p>
                <a href="ControladorReciclaje?accion=formulario" class="rm-btn-secondary">♻ Registrar mi primer reciclaje</a>
            </div>
            <% } %>
        </div>
    </main>
</body>
</html>