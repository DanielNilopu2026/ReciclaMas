<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.dto.Material, modelo.dto.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    List<Material> materiales = (List<Material>) request.getAttribute("materiales");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Reciclaje - ReciclaMas</title>
    <%@include file="estilos.jsp" %>
</head>
<body>
    <%@include file="sidebar.jsp" %>
    <main class="rm-main">
        <div class="rm-page-header">
            <h1 class="rm-page-title">♻ Registrar Reciclaje</h1>
            <p class="rm-page-subtitle">Ingresa los datos de tu aporte para acumular puntos automáticamente</p>
        </div>

        <div style="display:grid; grid-template-columns:1fr 1fr; gap:1.5rem; max-width:900px;">
            <div class="rm-card">
                <h2 style="font-size:1rem; font-weight:700; margin-bottom:1.5rem; color:#2D3748;">Nuevo Registro</h2>
                <% if (request.getAttribute("exito") != null) { %>
                    <div class="rm-alert rm-alert-success">✓ <%= request.getAttribute("exito") %></div>
                <% } %>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="rm-alert rm-alert-error">⚠ <%= request.getAttribute("error") %></div>
                <% } %>
                <form action="ControladorReciclaje" method="POST">
                    <input type="hidden" name="accion" value="registrar">
                    <div class="rm-form-group">
                        <label class="rm-label">Tipo de Material</label>
                        <select class="rm-select" name="material_id" required>
                            <option value="" disabled selected>— Selecciona un material —</option>
                            <% if (materiales != null && !materiales.isEmpty()) {
                                for (Material m : materiales) { %>
                                <option value="<%= m.getId() %>">
                                    <%= m.getNombre() %> — <%= (int)m.getPuntosPorKg() %> pts por kg
                                </option>
                            <% } } else { %>
                                <option disabled>Sin materiales en BD</option>
                            <% } %>
                        </select>
                    </div>
                    <div class="rm-form-group">
                        <label class="rm-label">Cantidad (kilogramos)</label>
                        <input type="number" step="0.01" min="0.1" max="9999"
                               class="rm-input" name="cantidad" placeholder="Ej: 2.50" required>
                    </div>
                    <button type="submit" class="rm-btn-primary">♻ Registrar y Sumar Puntos</button>
                </form>
            </div>

            <div class="rm-card">
                <h2 style="font-size:1rem; font-weight:700; margin-bottom:1.25rem; color:#2D3748;">📊 Puntos por Material</h2>
                <div class="rm-table-wrapper">
                    <table class="rm-table">
                        <thead><tr><th>Material</th><th>Pts/Kg</th></tr></thead>
                        <tbody>
                            <tr><td>🧴 Plástico</td><td><span class="rm-pts-badge">10 pts</span></td></tr>
                            <tr><td>📦 Cartón</td><td><span class="rm-pts-badge">5 pts</span></td></tr>
                            <tr><td>🍶 Vidrio</td><td><span class="rm-pts-badge">8 pts</span></td></tr>
                            <tr><td>🔩 Metal</td><td><span class="rm-pts-badge">15 pts</span></td></tr>
                        </tbody>
                    </table>
                </div>
                <div style="margin-top:1.25rem; padding:1rem; background:#EAF4F0; border-radius:8px;">
                    <p style="font-size:0.85rem; color:#176B4E; font-weight:600; margin-bottom:4px;">💡 Tus puntos actuales</p>
                    <p style="font-size:1.5rem; font-weight:700; color:#176B4E;"><%= user.getPuntosTotal() %> pts</p>
                </div>
            </div>
        </div>
    </main>
</body>
</html>