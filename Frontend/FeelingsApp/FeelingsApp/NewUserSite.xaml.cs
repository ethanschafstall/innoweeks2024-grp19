using MySqlX.XDevAPI;
using static FeelingsApp.LoginSite;
using System;
using System.Diagnostics;
using System.IO.Compression;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Threading.Tasks;
using System.Xml;
using Microsoft.Maui.Controls;
using Newtonsoft.Json;
using System.Net.Http.Headers;
using Microsoft.Maui.Controls;


namespace FeelingsApp;

public partial class NewUserSite : ContentPage
{
    HttpClient client = new();


    public NewUserSite()
	{
		InitializeComponent();

        var panGesture = new PanGestureRecognizer();
        panGesture.PanUpdated += OnPanUpdated;
        this.Content.GestureRecognizers.Add(panGesture);
    }


    private async void OnCreateAccountClicked(object sender, EventArgs e)
    {
        string username = CreateUserName.Text;
        string password = CreateUserPsw.Text;
        try
        {
            var signInRequest = new SignInRequest
            {
                Username = username,
                Password = password
            };

            var postResponse = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/register", signInRequest);
            if (postResponse.IsSuccessStatusCode)
            {

                var content = postResponse.Content;
                var contentS = await postResponse.Content.ReadAsStringAsync();
                await DisplayAlert("Response", contentS, "OK");
                await Navigation.PushAsync(new UserSite());


            }
            else
            {
                throw new Exception($"Bad status : {postResponse.StatusCode}, {postResponse.Headers},{postResponse.Content}");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert(ex.Message, ex.StackTrace, "ok");
            Debug.WriteLine(ex.Message);
            await Navigation.PushAsync(new LoginSite());

        }
    }
    public class SignInRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }

    private void OnPanUpdated(object sender, PanUpdatedEventArgs e)
    {
        switch (e.StatusType)
        {
            case GestureStatus.Running:
                // Detectar desplazamiento hacia la derecha
                if (e.TotalX > 100) // Puedes ajustar este valor según sea necesario
                {
                    Navigation.PopAsync();
                }
                break;
        }
    }


}
