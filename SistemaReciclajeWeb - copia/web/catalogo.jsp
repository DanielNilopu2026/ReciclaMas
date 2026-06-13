<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, modelo.dto.Recompensa, modelo.dto.Usuario" %>
<%
    Usuario user = (Usuario) session.getAttribute("usuario");
    if (user == null) { response.sendRedirect("login.jsp"); return; }
    List<Recompensa> recompensas = (List<Recompensa>) request.getAttribute("recompensas");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Catálogo de Recompensas - ReciclaMas</title>
    <%@include file="estilos.jsp" %>
</head>
<body>
    <%@include file="sidebar.jsp" %>
    <main class="rm-main">
        <div class="rm-page-header">
            <h1 class="rm-page-title">🎁 Catálogo de Recompensas</h1>
            <p class="rm-page-subtitle">Canjea tus puntos por premios ecológicos y sostenibles</p>
        </div>

        <% if (request.getAttribute("exito") != null) { %>
            <div class="rm-alert rm-alert-success">✓ <%= request.getAttribute("exito") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <div class="rm-alert rm-alert-error">⚠ <%= request.getAttribute("error") %></div>
        <% } %>

        <div class="rm-card" style="margin-bottom:1.75rem; display:flex; align-items:center; justify-content:space-between; flex-wrap:wrap; gap:1rem;">
            <div>
                <p style="font-size:0.85rem; color:#718096; margin-bottom:4px;">Tus puntos disponibles</p>
                <p style="font-size:2rem; font-weight:800; color:#176B4E;"><%= user.getPuntosTotal() %> pts</p>
            </div>
            <a href="ControladorReciclaje?accion=formulario" class="rm-btn-secondary">♻ Ganar más puntos</a>
        </div>

        <% if (recompensas != null && !recompensas.isEmpty()) { %>
        <div class="rm-rewards-grid">
            <% String[] iconos = {"🌱","🛍️","🌳","♻","🌿","💧","🌻","🎋"};
               int idx = 0;
               for (Recompensa r : recompensas) {
                   boolean puedeCanjear = user.getPuntosTotal() >= r.getPuntosRequeridos();
                   String icono = iconos[idx % iconos.length]; idx++; %>
            <div class="rm-reward-card">
                <div class="rm-reward-icon"><%= icono %></div>
                <div class="rm-reward-name"><%= r.getNombre() %></div>
                <div class="rm-reward-desc"><%= r.getDescripcion() %></div>
                <div class="rm-reward-pts"><%= r.getPuntosRequeridos() %> pts</div>
                <div class="rm-reward-stock">Stock: <%= r.getStock() %> unid.</div>
                <%-- CORRECCIÓN: formulario POST que realmente envía el canje --%>
                <form action="ControladorRecompensa" method="POST" style="margin-top:auto;">
                    <input type="hidden" name="recompensaId" value="<%= r.getId() %>">
                    <button type="submit" class="rm-btn-canje"
                            <%= !puedeCanjear ? "disabled" : "" %>>
                        <%= puedeCanjear ? "🎁 Canjear Ahora" : "🔒 Puntos Insuficientes" %>
                    </button>
                </form>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="rm-card">
            <div class="rm-empty">
                <div class="rm-empty-icon">🎁</div>
                <h3>No hay recompensas disponibles</h3>
                <p>Por el momento no hay recompensas con stock. Vuelve pronto.</p>
            </div>
        </div>
        <% } %>
    </main>
</body>
</html>