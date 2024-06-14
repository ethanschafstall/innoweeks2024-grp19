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


namespace FeelingsApp;

public partial class NewUserSite : ContentPage
{
    HttpClient client = new();


    public NewUserSite()
	{
		InitializeComponent();
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

}
