<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="modelo.dto.Usuario" %>
<%
    Usuario sideUser = (Usuario) session.getAttribute("usuario");
    String paginaActual = request.getServletPath();
%>
<aside class="rm-sidebar">
    <div class="rm-brand">
        <span class="rm-brand-icon">♻</span>
        <span>ReciclaMas</span>
    </div>

    <% if (sideUser != null) { %>
    <div class="rm-user-card">
        <div class="rm-user-avatar"><%= sideUser.getNombre().substring(0,1).toUpperCase() %></div>
        <div class="rm-user-info">
            <span class="rm-user-name"><%= sideUser.getNombre() %></span>
            <span class="rm-user-pts"><%= sideUser.getPuntosTotal() %> pts</span>
        </div>
    </div>
    <% } %>

    <nav class="rm-nav">
        <a href="dashboard.jsp"
           class="rm-nav-link <%= paginaActual.contains("dashboard") ? "active" : "" %>">
            <span class="rm-nav-icon">🏠</span> Dashboard
        </a>
        <a href="ControladorReciclaje?accion=formulario"
           class="rm-nav-link <%= paginaActual.contains("registrarReciclaje") ? "active" : "" %>">
            <span class="rm-nav-icon">♻</span> Registrar Reciclaje
        </a>
        <a href="ControladorRanking"
           class="rm-nav-link <%= paginaActual.contains("ranking") ? "active" : "" %>">
            <span class="rm-nav-icon">🏆</span> Ranking Vecinal
        </a>
        <a href="ControladorRecompensa"
           class="rm-nav-link <%= paginaActual.contains("catalogo") ? "active" : "" %>">
            <span class="rm-nav-icon">🎁</span> Recompensas
        </a>
        <a href="ControladorReciclaje?accion=historial"
           class="rm-nav-link <%= paginaActual.contains("historial") ? "active" : "" %>">
            <span class="rm-nav-icon">📋</span> Mi Historial
        </a>
    </nav>

    <div class="rm-sidebar-footer">
        <a href="ControladorUsuario?accion=logout" class="rm-logout-btn">
            <span>🚪</span> Cerrar Sesión
        </a>
    </div>
</aside>