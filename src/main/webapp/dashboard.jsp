<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dashboard - ShopMate</title>
    <link rel="stylesheet" href="style.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .card:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .sidebar a:hover {
            text-decoration: underline;
            color: #ffc107;
        }

        .card {
            cursor: pointer;
        }

        .sidebar {
            transition: width 0.3s;
        }

        .sidebar.collapsed {
            width: 80px;
        }

        .sidebar.collapsed ul li span {
            display: none;
        }

        .sidebar h2 {
            font-size: 1.5rem;
        }

        .toggle-btn {
            background: none;
            border: none;
            color: white;
            font-size: 1.2rem;
        }

        .toggle-btn:hover {
            color: #ffc107;
        }
    </style>
</head>
<body>
    <div class="d-flex">
        <!-- Sidebar -->
        <div id="sidebar" class="sidebar bg-dark text-white p-4" style="min-height: 100vh; width: 250px;">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold m-0">ShopMate</h2>
                <button class="toggle-btn" onclick="toggleSidebar()">☰</button>
            </div>
            <ul class="list-unstyled">
                <li class="mb-3">
                    <a href="recommendations" class="text-white text-decoration-none">
                        <span>Recommended</span>
                    </a>
                </li>
                <li class="mb-3">
                    <a href="cart.jsp" class="text-white text-decoration-none">
                        <span>Cart</span>
                    </a>
                </li>
                <li>
                    <a href="logout" class="text-white text-decoration-none">
                        <span>Logout</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main-content w-100">
            <header class="d-flex justify-content-between align-items-center p-3 bg-light">
                <h3 class="fw-bold m-0">ShopMate</h3>
            </header>

            <section class="hero text-center py-5 bg-light">
                <h1 class="fw-bold">Biggest Deals of the Season!</h1>
                <p>Grab your favorite gadgets at the best prices.</p>
            </section>

            <section class="categories p-5">
                <h2 class="mb-4">Choose a Category</h2>
                <div class="row">
                    <!-- Category: Laptops -->
                    <div class="col-md-3">
                        <div class="card" onclick="location.href='category?category=laptops'">
                            <img src="assets/laptop.jpg" class="card-img-top" alt="Laptops">
                            <div class="card-body text-center">
                                <p class="card-text">Laptops</p>
                            </div>
                        </div>
                    </div>

                    <!-- Category: Mobiles -->
                    <div class="col-md-3">
                        <div class="card" onclick="location.href='category?category=mobiles'">
                            <img src="assets/mobile.jpg" class="card-img-top" alt="Mobile Phones">
                            <div class="card-body text-center">
                                <p class="card-text">Mobile Phones</p>
                            </div>
                        </div>
                    </div>

                    <!-- Category: Accessories -->
                    <div class="col-md-3">
                        <div class="card" onclick="location.href='category?category=accessories'">
                            <img src="assets/accessories.jpg" class="card-img-top" alt="Accessories">
                            <div class="card-body text-center">
                                <p class="card-text">Accessories</p>
                            </div>
                        </div>
                    </div>

                    <!-- Category: Home Decor -->
                    <div class="col-md-3">
                        <div class="card" onclick="location.href='category?category=home decor'">
                            <img src="assets/home-decor.jpg" class="card-img-top" alt="Home Decor">
                            <div class="card-body text-center">
                                <p class="card-text">Home Decor</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <footer class="bg-dark text-white text-center py-3">
                &copy; 2025 ShopMate. All rights reserved.
            </footer>
        </div>
    </div>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById("sidebar");
            sidebar.classList.toggle("collapsed");
        }
    </script>
</body>
</html>
