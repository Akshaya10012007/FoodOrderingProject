
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FoodOrdering.Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Food Ordering System - Home</title>
    <link href="CSS/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Navigation Bar -->
        <div class="navbar">
            <a class="logo" href="Default.aspx">Food Ordering System</a>
            <div class="menu">
                <a href="Default.aspx">Home</a>
                <a href="Menu.aspx">Menu</a>
                <a href="Cart.aspx">Cart</a>
                <a href="MyOrders.aspx">My Orders</a>
                <a href="Login.aspx">Login</a>
                <a href="Register.aspx">Register</a>
            </div>
        </div>

        <!-- Page Content -->
        <div class="container">
            <div class="hero">
                <h1>Food Ordering System</h1>
                <p>Tasty food, fast delivery. Order your favourite food now!</p>
                <asp:Label ID="lblWelcome" runat="server" CssClass="message success"></asp:Label>
                <br />
                <a href="Menu.aspx" class="btn">View Menu</a>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            &copy; 2026 Food Ordering System
        </div>

    </form>
</body>
</html>