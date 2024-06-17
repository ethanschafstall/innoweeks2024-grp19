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
//var response = await client.GetAsync("http://10.0.2.2:3000/epub/1");

public partial class LoginSite : ContentPage
{
    //private readonly HttpClient _httpClient;
    HttpClient client = new();

    public LoginSite()
	{
		InitializeComponent();
        BindingContext = new FeelingsSite();

        //_httpClient = new HttpClient();
    }
    private async void OnLoginClicked(object sender, EventArgs e)
	{
        string username = LoginUserName.Text;
        string password = LoginUserPsw.Text;
        try
        {
            var loginRequest = new LoginRequest
            {
                Username = username,
                Password = password,
            };

            var postResponse = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/login", loginRequest);
            if (postResponse.IsSuccessStatusCode)
            {
                var content = postResponse.Content;
                var contentString = await postResponse.Content.ReadAsStringAsync();

                var jsonResponse = JsonConvert.DeserializeObject<LoginResponse>(contentString);

                if (jsonResponse != null && !string.IsNullOrEmpty(jsonResponse.Token))
                {
                    await SecureStorage.SetAsync("auth_token", jsonResponse.Token);
                    await SecureStorage.SetAsync("username", username);

                    client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", jsonResponse.Token);
                    await DisplayAlert("Success", jsonResponse.Message, "OK");
                    // Navegar a la página de usuario
                    await Navigation.PushAsync(new UserSite());
                }
                else
                {
                    await DisplayAlert("Error", "Failed to deserialize login response or empty token", "OK");
                }

            }
            else
            {
                throw new Exception($"Bad status : {postResponse.StatusCode}, {postResponse.Headers},{postResponse.Content}");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert(ex.Message, ex.StackTrace, "ok");
            Debug.WriteLine(ex.Message );

        }        



    }

    private async void OnNewUserSite(object sender, EventArgs e)
    {
        // Lógica para navegar a la ruta "NewUserSite" u otras acciones según sea necesario
        await Navigation.PushAsync(new NewUserSite());
    }

    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
    public class SignInRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
    public class LoginResponse
    {
        public string Message { get; set; }
        public string Token { get; set; }
    }
}
