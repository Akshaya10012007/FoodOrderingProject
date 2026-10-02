<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="FoodOrdering.Menu" %>
<%@ Register Src="~/NavBar.ascx" TagPrefix="uc" TagName="NavBar" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Menu - Food Ordering System</title>
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
            <h2 class="page-title">Our Food Menu</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message success"></asp:Label>

            <div class="food-grid">
                <asp:Repeater ID="rptFoods" runat="server" OnItemCommand="rptFoods_ItemCommand">
                    <ItemTemplate>
                        <div class="food-card">
                            <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("FoodName") %>' />
                            <h3><%# Eval("FoodName") %></h3>
                            <div class="category">ID: <%# Eval("FoodId") %> | <%# Eval("Category") %></div>
                            <div class="desc"><%# Eval("Description") %></div>
                            <div class="price">&#8377; <%# Eval("Price", "{0:N2}") %></div>
                            <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn"
                                CommandName="AddToCart" CommandArgument='<%# Eval("FoodId") %>' />
                        </div>
                        
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
    
</body>
</html>