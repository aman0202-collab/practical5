
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AcademicLeave.aspx.cs" Inherits="AcademicLeaveSystem.AcademicLeave" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Academic Calendar and Leave Management</title>
    <style>
        body {
            font-family: Arial;
            background: #eef2f7;
            margin: 0;
            padding: 25px;
        }
        .container {
            max-width: 850px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }
        h2 { color: #174ea6; }
        .field { margin: 14px 0; }
        input, select, textarea {
            padding: 8px;
            box-sizing: border-box;
            max-width: 100%;
        }
        .error { color: red; }
        .btn {
            background: #174ea6;
            color: white;
            padding: 10px 18px;
            border: none;
        }
        table { margin-top: 15px; }
    </style>
</head>
<body>
<form id="form1" runat="server">
<div class="container">

    <h2>Academic Calendar</h2>

    <asp:GridView ID="gvCalendar" runat="server"
        AutoGenerateColumns="False"
        Width="100%" CellPadding="8"
        HeaderStyle-BackColor="#174ea6"
        HeaderStyle-ForeColor="White">
        <Columns>
            <asp:BoundField DataField="Date" HeaderText="Date" />
            <asp:BoundField DataField="Event" HeaderText="Event" />
            <asp:BoundField DataField="Description"
                HeaderText="Description" />
        </Columns>
    </asp:GridView>

    <hr />

    <h2>Leave Application</h2>

    <div class="field">
        Student Name<br />
        <asp:TextBox ID="txtName" runat="server" />
        <asp:RequiredFieldValidator ID="vName" runat="server"
            ControlToValidate="txtName"
            ErrorMessage="Enter student name."
            CssClass="error" Display="Dynamic" />
    </div>

    <div class="field">
        Student ID<br />
        <asp:TextBox ID="txtStudentId" runat="server" />
        <asp:RequiredFieldValidator ID="vStudentId" runat="server"
            ControlToValidate="txtStudentId"
            ErrorMessage="Enter student ID."
            CssClass="error" Display="Dynamic" />
    </div>

    <div class="field">
        Leave Type<br />
        <asp:DropDownList ID="ddlLeaveType" runat="server">
            <asp:ListItem Text="-- Select Leave Type --" Value="" />
            <asp:ListItem Text="Medical Leave" Value="Medical" />
            <asp:ListItem Text="Personal Leave" Value="Personal" />
            <asp:ListItem Text="Emergency Leave" Value="Emergency" />
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="vLeaveType" runat="server"
            ControlToValidate="ddlLeaveType"
            InitialValue=""
            ErrorMessage="Select leave type."
            CssClass="error" Display="Dynamic" />
    </div>

    <div class="field">
        From Date<br />
        <asp:TextBox ID="txtFrom" runat="server" TextMode="Date" />
        <asp:RequiredFieldValidator ID="vFrom" runat="server"
            ControlToValidate="txtFrom"
            ErrorMessage="Select start date."
            CssClass="error" Display="Dynamic" />
    </div>

    <div class="field">
        To Date<br />
        <asp:TextBox ID="txtTo" runat="server" TextMode="Date" />
        <asp:RequiredFieldValidator ID="vTo" runat="server"
            ControlToValidate="txtTo"
            ErrorMessage="Select end date."
            CssClass="error" Display="Dynamic" />
    </div>

    <div class="field">
        Reason for Leave<br />
        <asp:TextBox ID="txtReason" runat="server"
            TextMode="MultiLine" Rows="3" />
        <asp:RequiredFieldValidator ID="vReason" runat="server"
            ControlToValidate="txtReason"
            ErrorMessage="Enter leave reason."
            CssClass="error" Display="Dynamic" />
    </div>

    <asp:ValidationSummary ID="vsLeave" runat="server"
        CssClass="error" />

    <asp:Button ID="btnApply" runat="server"
        Text="Apply for Leave" CssClass="btn"
        OnClick="btnApply_Click" />

    <br /><br />
    <asp:Label ID="lblMessage" runat="server" />

    <h2>Leave Applications</h2>

    <asp:GridView ID="gvLeaves" runat="server"
        AutoGenerateColumns="True"
        Width="100%" CellPadding="8"
        EmptyDataText="No leave applications yet." />

</div>
</form>
</body>
</html>
