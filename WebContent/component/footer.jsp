<footer class="bg-dark text-light py-4 mt-5">
    <div class="container">
        <div class="row">

            <!-- Customer Care -->
            <div class="col-md-3 mb-3">
                <h6 class="text-uppercase fw-bold">Customer Care</h6>
                <ul class="list-unstyled">
                    <li><a class="footer-link paragraph bold" href="<%= request.getContextPath() %>/pagine/faqs.jsp">FAQs</a></li>
                    <li><a class="footer-link paragraph bold" href="<%= request.getContextPath() %>/pagine/returns.jsp">Returns</a></li>
                    <li><a class="footer-link paragraph bold" href="<%= request.getContextPath() %>/pagine/privacy.jsp">Privacy Policy</a></li>
                </ul>
            </div>

            <!-- Logo + Motto -->
            <div class="col-md-6 text-center mb-3">
                <img src="<%= getServletContext().getContextPath() + "/assets/img/logo/logo.PNG" %>" 
                     alt="Logo" style="height:50px;" class="mb-2">
                <h5 class="fw-bold">Il Tempio Del Digitale</h5>
                <p class="small">Il digitale che semplifica la tua vita.</p>
                <p class="small mb-0">&copy; 2025 Il Tempio Del Digitale - All rights reserved</p>
            </div>

            <!-- Social -->
            <div class="col-md-3 text-center mb-3">
                <h6 class="text-uppercase fw-bold">Follow Us</h6>
                <a href="https://twitter.com" target="_blank" class="text-light me-2">
                    <i class="bi bi-twitter fs-4"></i>
                </a>
                <a href="https://www.instagram.com" target="_blank" class="text-light me-2">
                    <i class="bi bi-instagram fs-4"></i>
                </a>
                <a href="https://www.facebook.com" target="_blank" class="text-light me-2">
                    <i class="bi bi-facebook fs-4"></i>
                </a>
                <a href="https://www.linkedin.com" target="_blank" class="text-light">
                    <i class="bi bi-linkedin fs-4"></i>
                </a>
            </div>

        </div>
    </div>
</footer>
