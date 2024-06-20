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
            LoadGroupsAsync();


        }

        private async Task LoadGroupsAsync()
        {
            var authToken = await SecureStorage.GetAsync("auth_token");
            if (string.IsNullOrEmpty(authToken))
            {
                await DisplayAlert("Error", "User is not authenticated.", "OK");
                return;
            }

            try
            {
                client.DefaultRequestHeaders.Clear(); // Limpiar las cabeceras antes de la solicitud

                client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");
                var response = await client.GetAsync("https://feelings.blue.section-inf.ch/groups");

                if (response.IsSuccessStatusCode)
                {
                    var content = await response.Content.ReadAsStringAsync();
                    var groupsResponse = JsonConvert.DeserializeObject<GroupsResponse>(content);

                    GroupPicker.ItemsSource = groupsResponse.Groups;
                    GroupPicker.ItemDisplayBinding = new Binding("GroName");
                }
                else
                {
                    await DisplayAlert("Error", "Failed to load groups.", "OK");
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert(ex.Message, ex.StackTrace, "OK");
            }
        }
    


        private async void OnAddFriendButtonClicked(object sender, EventArgs e)
        {
            // Recuperar el username y el authToken del SecureStorage
            var userUsername = UsernameEntry.Text;
            var selectedGroup = GroupPicker.SelectedItem as Group;
            var authToken = await SecureStorage.GetAsync("auth_token");

            if (string.IsNullOrEmpty(authToken))
            {
                await DisplayAlert("Error", "User is not authenticated.", "OK");
                return;
            }

            // Verificar que ambos campos estén llenos
            if (string.IsNullOrEmpty(userUsername) || selectedGroup == null)
            {
                await DisplayAlert("Error", "Both fields are required.", "OK");
                return;
            }


            var addFriendRequest = new AddFriendRequest
            {
                UseUsername = userUsername,
                GroId = selectedGroup.GroupId
            };
            // Enviar la solicitud POST para agregar el amigo
            client.DefaultRequestHeaders.Clear(); // Limpiar las cabeceras antes de la solicitud

            client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");
            var response = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/friends", addFriendRequest);

            if (response.IsSuccessStatusCode)
            {
                await DisplayAlert("Success", "Friend added successfully.", "OK");
            }
            else if (response.StatusCode == System.Net.HttpStatusCode.Conflict)
            {
                // En caso de conflicto, intentar agregar al amigo al grupo
                //var responseForGroup = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/friends", requestBody);

                
                    await DisplayAlert("Error", "Failed to add friend to the group.", "OK");
                
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
                   groName = groupName
                };
                client.DefaultRequestHeaders.Clear(); // Limpiar las cabeceras antes de la solicitud

                client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");

                var response = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/groups", createGroupRequest);

                if (response.IsSuccessStatusCode)
                {
                    // Navegar a la siguiente página y pasar el sentimiento seleccionado
                    await Navigation.PushAsync(new FriendsSite());
                }
                else
                {
                    await DisplayAlert("Error", $"Failed to confirm group. {createGroupRequest.groName}", "OK");
                }

            }
            catch (Exception ex)
            {
                await DisplayAlert(ex.Message, ex.StackTrace, "ok");
            }
        }
        public class AddFriendRequest
        {
            public string UseUsername { get; set; }
            public int GroId { get; set; }
        }
        public class CreateGroupRequest
        {
            public string groName { get; set; }
        }

        public class GroupsResponse
        {
            public List<Group> Groups { get; set; }
        }

        public class Group
        {
            public int GroupId { get; set; }
            public string GroName { get; set; }
            public int FkUser { get; set; }
        }
    }
}