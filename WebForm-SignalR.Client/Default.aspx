<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm_SignalR.Client._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            <h1 id="aspnetTitle">ASP.NET</h1>
            <p class="lead">ASP.NET is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
            <p><a href="http://www.asp.net" class="btn btn-primary btn-md">Learn more &raquo;</a></p>
        </section>

        <!-- Notification display area -->
        <section>
            <h2>Notifications</h2>
            <div id="notificationArea" style="border: 1px solid #ddd; padding: 10px; min-height: 50px;">
                <!-- Notifications will appear here -->
            </div>
        </section>
    </main>

    <!-- Include SignalR script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/microsoft-signalr/5.0.9/signalr.min.js"></script>
    
    <!-- Add SignalR connection and event handling script -->
    <script type="text/javascript">
        var connection = new signalR.HubConnectionBuilder().withUrl("https://localhost:7224/notificationHub").build();

        console.log(connection)

        connection.start().then(function () {
            console.log("SignalR connected.");
        }).catch(function (err) {
            console.error("Connection error: ", err);
        });

        // Handler for receiving notifications
        connection.on("ReceiveNotification", function (message) {
            console.log(message)
            var notificationArea = document.getElementById("notificationArea");
            var newNotification = document.createElement("div");
            newNotification.innerHTML = message;
            notificationArea.appendChild(newNotification);
        });
    </script>
</asp:Content>
