
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyOrders.aspx.cs" Inherits="FoodOrdering.MyOrders" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>My Orders - Food Ordering System</title>
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
            <h2 class="page-title">My Orders</h2>

            <!-- Orders illa-na idhu kaattum -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <p style="text-align:center;">You have not placed any orders yet. <a href="Menu.aspx">Go to the menu</a>.</p>
            </asp:Panel>

            <asp:Panel ID="pnlOrders" runat="server">
                <asp:Repeater ID="rptOrders" runat="server">
                    <HeaderTemplate>
                        <table class="data-table">
                            <tr>
                                <th>Order ID</th>
                                <th>Order Date</th>
                                <th>Total Amount</th>
                                <th>Order Status</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td>#<%# Eval("OrderId") %></td>
                                <td><%# Eval("OrderDate", "{0:dd-MMM-yyyy hh:mm tt}") %></td>
                                <td>&#8377; <%# Eval("TotalAmount", "{0:N2}") %></td>
                                <td><b><%# Eval("Status") %></b></td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </asp:Panel>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>