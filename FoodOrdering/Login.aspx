<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FoodOrdering.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - Food Ordering System</title>
    <link href="CSS/style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

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

        <div class="container">
            <div class="form-box">
                <h2>Login</h2>

                <div class="form-group">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />
                <asp:Label ID="lblMessage" runat="server" CssClass="message error"></asp:Label>

                <p style="text-align:center;">Don't have an account? <a href="Register.aspx">Register</a></p>
            </div>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>
