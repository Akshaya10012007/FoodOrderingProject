<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="FoodOrdering.Checkout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Checkout - Food Ordering System</title>
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
            <h2 class="page-title">Checkout</h2>

            <!-- Order success aana idhu kaattum -->
            <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                <div class="form-box">
                    <h2>Order Placed!</h2>
                    <asp:Label ID="lblSuccess" runat="server" CssClass="message success"></asp:Label>
                    <p style="text-align:center;">
                        <a href="MyOrders.aspx" class="btn">My Orders </a>
                        <a href="Menu.aspx" class="btn btn-green">Order More</a>
                    </p>
                </div>
            </asp:Panel>

            <!-- Checkout form -->
            <asp:Panel ID="pnlCheckout" runat="server">

                <asp:Label ID="lblMessage" runat="server" CssClass="message error"></asp:Label>

                <div class="form-box" style="max-width:700px; margin-bottom:25px;">
                    <h2>Delivery Details</h2>

                    <div class="form-group">
                        <label>Customer Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Delivery Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <div class="form-group">
                        <label>Order Date</label>
                        <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                    </div>
                </div>

                <h3>Ordered Items</h3>
                <asp:Repeater ID="rptItems" runat="server">
                    <HeaderTemplate>
                        <table class="data-table">
                            <tr>
                                <th>Image</th>
                                <th>Food Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td><img src='<%# Eval("ImageUrl") %>' alt="No Image" /></td>
                                <td><%# Eval("FoodName") %></td>
                                <td>&#8377; <%# Eval("Price", "{0:N2}") %></td>
                                <td><%# Eval("Quantity") %></td>
                                <td>&#8377; <%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="total-box">
                    <asp:Label ID="lblTotal" runat="server"></asp:Label>
                </div>

                <div style="text-align:right;">
                    <a href="Cart.aspx" class="btn">Back to Cart</a>
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-green" OnClick="btnPlaceOrder_Click" />
                </div>
            </asp:Panel>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>
