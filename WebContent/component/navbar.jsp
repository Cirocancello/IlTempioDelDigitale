<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.Utente" %>
<%@ page import="java.util.*, model.Prodotto" %>

<%
    HttpSession sessione = request.getSession(false);
    Utente u = (sessione != null) ? (Utente) sessione.getAttribute("utente") : null;

    int totaleCarrello = 0;
    List<Prodotto> carrello = (sessione != null) ? (List<Prodotto>) sessione.getAttribute("carrello") : null;
    if (carrello != null) {
        for (Prodotto p : carrello) {
            totaleCarrello += p.getQuantita();
        }
    }
%>

<nav class="navbar navbar-expand-lg">
    <div class="container-fluid">

        <!-- Brand -->
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

                <!-- Catalogo -->
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/catalogo">
                        <i class="bi bi-bag-fill"></i> Catalogo
                    </a>
                </li>

                <% if (u == null) { %>

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

                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/profile">
                            <i class="bi bi-person-circle"></i> Profilo
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link position-relative" href="<%= request.getContextPath() %>/pagine/carrello.jsp">
                            <i class="bi bi-cart"></i> Carrello
                            <span id="cart-count"
                                  class="badge bg-danger rounded-pill position-absolute top-0 start-100 translate-middle">
                                <%= totaleCarrello %>
                            </span>
                        </a>
                    </li>

                    <li class="nav-item">
                        <form method="post" action="<%= request.getContextPath() %>/pagine/logout.jsp" class="d-inline">
                            <button type="submit" class="nav-link btn btn-link text-decoration-none">
                                <i class="bi bi-box-arrow-right"></i> Logout
                            </button>
                        </form>
                    </li>

                    <% if (u.getRole() == 1) { %>
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

            </ul>
        </div>
    </div>
</nav>
