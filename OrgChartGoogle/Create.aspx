<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="OrgChartGoogle.Create" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script type="text/javascript">
    </script>
    <link href="GoogleOrgChart.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            height: 30px;
        }

        .auto-style2 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="navigation">
            <asp:ImageButton ID="BackButton" runat="server" Style="position: absolute; left: 20px; top: 26%;" ImageUrl="~/images/01_arrow_left-128.png" Width="40px"  CausesValidation="False" OnClientClick="JavaScript:window.history.back(1); return false;" />
            <asp:ImageButton ID="LogoButton" runat="server" Style="position: relative;" ImageUrl="~/images/csulogo.png" Width="290px" PostBackUrl="~/OrgChart.aspx" CausesValidation="False" />
        </div>
        <div style="padding-top: 6%; width: 100%; text-align: center;">
            <div style="display: inline-block; background-color: rgba(1, 1, 1, 0.8); color: rgba(1, 1, 1, 0.8);">
                <div style="padding-top: 30px; width: 250px; float: left;">
                    <asp:Image ID="employeeImage" runat="server" ImageUrl="~/images/profile.png" Height="200px" Width="200px" />
                    <br />
                    <br />
                    <asp:Label ID="successLabel" runat="server" ForeColor="#33CC33"></asp:Label>
                </div>
                <div style="padding-top: 30px; padding-bottom: 30px; width: 400px; float: right;">
                    <table style="width: 100%; text-align: left;">
                        <tr>
                            <td>
                                <asp:Label ID="parentIdLabel" runat="server" Text="Supervisor:" ForeColor="White"></asp:Label>
                            </td>
                            <td>
                                <cc1:ComboBox ID="ComboBox1" runat="server" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource1" DataTextField="fullName" DataValueField="nodeId" DropDownStyle="DropDownList" MaxLength="0" Style="display: inline;" AppendDataBoundItems="True" Width="185px">
                                    <asp:ListItem Selected="True">&lt;--Select Supervisor--&gt;</asp:ListItem>
                                </cc1:ComboBox>
                                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:OrgChartGoogleContext %>" SelectCommand="SELECT nodeId, {  fn CONCAT(firstName + ' ', lastName) } AS fullName FROM Employees ORDER BY fullName"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="nodeIdLabel" runat="server" Text="Employee ID:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style1">
                                <asp:TextBox ID="nodeIdTextBox" runat="server" onkeydown="return(event.keyCode!=13);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="nodeIdTextBox" ErrorMessage="Employee ID field is required" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="nodeIdTextBox" ErrorMessage="Employee ID already exists" ForeColor="Red">*</asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style1">
                                <asp:Label ID="firstNameLabel" runat="server" Text="First Name:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style1">
                                <asp:TextBox ID="firstNameTextBox" runat="server" onkeydown="return(event.keyCode!=13);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="First Name field is required" ControlToValidate="firstNameTextBox" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="lastNameLabel" runat="server" Text="Last Name:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="lastNameTextBox" runat="server" onkeydown="return(event.keyCode!=13);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Last Name field is required" ControlToValidate="lastNameTextBox" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="departmentLabel" runat="server" Text="Department:" ForeColor="White"></asp:Label>
                            </td>
                            <td>
                                <cc1:ComboBox ID="ComboBox2" runat="server" AppendDataBoundItems="True" AutoCompleteMode="SuggestAppend" DataSourceID="SqlDataSource2" DataTextField="departmentName" DataValueField="departmentId" DropDownStyle="DropDownList" MaxLength="0" Style="display: inline;" Width="185px">
                                    <asp:ListItem Selected="True">&lt;--Select Department--&gt;</asp:ListItem>
                                </cc1:ComboBox>
                                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:OrgChartGoogleContext %>" SelectCommand="SELECT * FROM [Department] ORDER BY [departmentName]"></asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="jobTitleLabel" runat="server" Text="Job Title:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="jobTitleTextBox" runat="server" Width="200px" onkeydown="return(event.keyCode!=13);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="emailLabel" runat="server" Text="Email:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="emailTextBox" runat="server" Width="200px" onkeydown="return(event.keyCode!=13);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="phoneLabel" runat="server" Text="Phone:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="phoneTextBox" runat="server" onkeydown="return(event.keyCode!=13);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label ID="pictureLabel" runat="server" Text="Picture:" ForeColor="White"></asp:Label>
                            </td>
                            <td class="auto-style2">
                                <asp:TextBox ID="pictureTextBox" runat="server" Width="200px" onkeydown="return(event.keyCode!=13);"></asp:TextBox>
                                <asp:Button ID="browseButton" runat="server" Text="Browse" />
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">&nbsp;</td>
                            <td class="auto-style2">
                                <asp:Button ID="CreateButton" runat="server" Text="Create" OnClick="CreateButton_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ForeColor="Red" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <asp:ScriptManager ID="ScriptManager2" runat="server" ScriptMode="Release">
        </asp:ScriptManager>
    </form>
</body>
</html>
