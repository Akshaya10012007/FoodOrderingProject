<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="FoodOrdering.Cart" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Cart - Food Ordering System</title>
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
            <h2 class="page-title">Your Cart</h2>
            <asp:Label ID="lblMessage" runat="server" CssClass="message error"></asp:Label>

            <!-- Cart empty-a irundha idhu kaattum -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <p style="text-align:center;">Cart empty-a irukku. <a href="Menu.aspx">Go to Menu to Add Food</a>.</p>
            </asp:Panel>

            <!-- Cart-la food irundha idhu kaattum -->
            <asp:Panel ID="pnlCart" runat="server">
                <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                    <HeaderTemplate>
                        <table class="data-table">
                            <tr>
                                <th>Image</th>
                                <th>Food Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Action</th>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td><img src='<%# Eval("ImageUrl") %>' alt="No Image" /></td>
                                <td><%# Eval("FoodName") %></td>
                                <td>&#8377; <%# Eval("Price", "{0:N2}") %></td>
                                <td>
                                    <asp:TextBox ID="txtQty" runat="server" Text='<%# Eval("Quantity") %>' CssClass="qty-box" TextMode="Number"></asp:TextBox>
                                </td>
                                <td>&#8377; <%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></td>
                                <td>
                                    <asp:Button ID="btnUpdate" runat="server" Text="Update Quantity" CssClass="btn btn-green"
                                        CommandName="UpdateQty" CommandArgument='<%# Eval("FoodId") %>' />
                                    <asp:Button ID="btnRemove" runat="server" Text="Remove" CssClass="btn btn-red"
                                        CommandName="RemoveItem" CommandArgument='<%# Eval("FoodId") %>' />
                                </td>
                            </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="total-box">
                    <asp:Label ID="lblGrandTotal" runat="server"></asp:Label>
                </div>

                <div style="text-align:right;">
                    <a href="Menu.aspx" class="btn">Continue Shopping</a>
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-green" OnClick="btnPlaceOrder_Click" />
                </div>
            </asp:Panel>
        </div>

        <div class="footer">&copy; 2026 Food Ordering System</div>

    </form>
</body>
</html>