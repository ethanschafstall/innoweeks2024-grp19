using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.CompilerServices;
using FeelingsApp.ViewModel;
using Microsoft.Maui.Controls;
using System.ComponentModel;
using System.Net.Http.Json;


namespace FeelingsApp
{

    public partial class FriendFormPage : ContentPage
    {
        //private readonly HttpClient client;
        HttpClient client = new();

        public FriendFormPage()
        {
            InitializeComponent();
          //  client = new HttpClient();

        }
        private async void OnAddFriendButtonClicked(object sender, EventArgs e)
        {
            // Recuperar el username y el authToken del SecureStorage
            var userUsername = UsernameEntry.Text;
            var groName = GroupNameEntry.Text;
            var authToken = await SecureStorage.GetAsync("auth_token");

            if (string.IsNullOrEmpty(authToken))
            {
                await DisplayAlert("Error", "User is not authenticated.", "OK");
                return;
            }

            // Verificar que ambos campos est�n llenos
            if (string.IsNullOrEmpty(userUsername) || string.IsNullOrEmpty(groName))
            {
                await DisplayAlert("Error", "Both fields are required.", "OK");
                return;
            }

            // Crear el objeto requestBody
            var requestBody = new
            {
                groName = groName,
                userUsername = userUsername
            };

            // Enviar la solicitud POST para agregar el amigo
            client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");
            var response = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/friend", requestBody);

            if (response.IsSuccessStatusCode)
            {
                await DisplayAlert("Success", "Friend added successfully.", "OK");
            }
            else if (response.StatusCode == System.Net.HttpStatusCode.Conflict)
            {
                // En caso de conflicto, intentar agregar al amigo al grupo
                var responseForGroup = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/friend", requestBody);

                if (responseForGroup.IsSuccessStatusCode)
                {
                    await DisplayAlert("Success", "Friend added to the group successfully.", "OK");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to add friend to the group.", "OK");
                }
            }
            else
            {
                await DisplayAlert("Error", "Failed to add friend.", "OK");
            }
        }

        private async void OnCreateAccountClicked(object sender, EventArgs e)
        {
            string groupName = GroupNameCreateEntry.Text;
            var authToken = await SecureStorage.GetAsync("auth_token");
            if (string.IsNullOrEmpty(authToken))
            {
                await DisplayAlert("Error", "User is not authenticated.", "OK");
                return;
            }
            try
            {
                var createGroupRequest = new CreateGroupRequest
                {
                    GroupName = groupName
                };
                client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");
                var response = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/friendsGroup", createGroupRequest);
                if (response.IsSuccessStatusCode)
                {
                    // Navegar a la siguiente p�gina y pasar el sentimiento seleccionado
                    await Navigation.PushAsync(new FriendsSite());
                }
                else
                {
                    await DisplayAlert("Error", "Failed to confirm feeling.", "OK");
                }

            }
            catch (Exception ex)
            {
                await DisplayAlert(ex.Message, ex.StackTrace, "ok");
            }
        }
        public class AddFriendRequest
        {
            public string Username { get; set; }
            public string GroupName { get; set; }
        }
        public class CreateGroupRequest
        {
            public string GroupName { get; set; }
        }
    }
}