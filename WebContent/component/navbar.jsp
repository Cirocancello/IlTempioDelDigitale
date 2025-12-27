<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Utente" %>
<%
    HttpSession sessione = request.getSession(false);
    Utente u = (sessione != null) ? (Utente) sessione.getAttribute("utente") : null;
%>

<!-- Navbar Bootstrap con icone -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <!-- Brand con logo -->
        <a class="navbar-brand d-flex align-items-center" href="<%= request.getContextPath() %>/index">
            <img class="nav-logo me-2" 
                 src="<%= request.getContextPath() %>/assets/img/logo/logo.PNG" 
                 alt="Logo" 
                 style="height:40px;">
            Il Tempio del Digitale
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarNav" aria-controls="navbarNav" 
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <!-- Link sempre visibile -->
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/catalogo">
                        <i class="bi bi-bag-fill"></i> Catalogo
                    </a>
                </li>

                <% if (u == null) { %>
                    <!-- Utente non loggato -->
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/pagine/login.jsp">
                            <i class="bi bi-box-arrow-in-right"></i> Login
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/pagine/register.jsp">
                            <i class="bi bi-person-plus-fill"></i> Registrati
                        </a>
                    </li>
                <% } else { %>
                    <!-- Utente loggato -->
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/pagine/profile.jsp">
                            <i class="bi bi-person-circle"></i> Profilo
                        </a>
                    </li>
                    
                    <!-- Link Carrello -->
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/pagine/carrello.jsp">
                            <i class="bi bi-cart"></i> Carrello
                        </a>
                    </li>

                    <!-- Pulsante Logout: chiama la servlet /logout -->
                    <li class="nav-item">
                        <form method="post" action="<%= request.getContextPath() %>/pagine/logout.jsp" class="d-inline">
                            <button type="submit" class="nav-link btn btn-link text-decoration-none">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </button>
                        </form>
                    </li>

                    <% if (u.getRole() == 1) { %>
                        <!-- Dropdown Admin -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" 
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-gear-fill"></i> Gestione Admin
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="adminDropdown">
                                <li>
                                    <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/prodotti">
                                        <i class="bi bi-box-seam"></i> Gestione Prodotti
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="<%= request.getContextPath() %>/admin/categorie">
                                        <i class="bi bi-tags-fill"></i> Gestione Categorie
                                    </a>
                                </li>
                            </ul>
                        </li>
                    <% } %>
                <% } %>

                <!-- Bottone Dark Mode -->
                <li class="nav-item">
                    <button class="btn btn-sm btn-outline-light ms-3" type="button" onclick="toggleDarkMode()">
                        <i class="bi bi-moon"></i> Dark Mode
                    </button>
                </li>

            </ul>
        </div>
    </div>
</nav>
