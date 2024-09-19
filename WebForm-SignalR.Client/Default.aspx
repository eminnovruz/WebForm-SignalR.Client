<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebForm_SignalR.Client._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main style="padding: 20px; background-color: #f5f5f5; font-family: Arial, sans-serif;">
        <section>
            <h2 style="color: #333;">Notifications</h2>
            <div id="notificationArea" style="border: 1px solid #ddd; padding: 10px; min-height: 50px; border-radius: 4px; background-color: #fff; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);">
            </div>
        </section>
    </main>

    <style>
        .notification {
            position: fixed;
            right: 20px;
            top: 20px;
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            opacity: 1;
            transition: opacity 0.5s ease;
            z-index: 1000;
        }

        .notification.fade-out {
            opacity: 0;
        }

        #notificationArea > div {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #e9ecef;
            border-left: 5px solid #007bff;
            border-radius: 4px;
        }
    </style>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/microsoft-signalr/5.0.9/signalr.min.js"></script>
    
    <script type="text/javascript">
        var connection = new signalR.HubConnectionBuilder().withUrl("https://localhost:7224/notificationHub").build();

        connection.start().then(function () {
            console.log("SignalR connected.");
        }).catch(function (err) {
            console.error("Connection error: ", err);
        });

        connection.on("ReceiveNotification", function (message) {
            var notificationArea = document.getElementById("notificationArea");
            var notificationDiv = document.createElement("div");
            notificationDiv.textContent = message;
            notificationArea.appendChild(notificationDiv);

            var popupNotification = document.createElement("div");
            popupNotification.className = "notification";
            popupNotification.textContent = message;
            document.body.appendChild(popupNotification);

            setTimeout(function () {
                popupNotification.classList.add("fade-out");
                setTimeout(function () {
                    popupNotification.remove();
                }, 500);
            }, 10000);
        });
    </script>
</asp:Content>
