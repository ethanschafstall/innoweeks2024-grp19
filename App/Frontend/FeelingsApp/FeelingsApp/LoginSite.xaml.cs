using System;
using System.Diagnostics;
using System.IO.Compression;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using System.Xml;
using Microsoft.Maui.Controls;
using static Android.Icu.Text.CaseMap;

namespace FeelingsApp;
//var response = await client.GetAsync("http://10.0.2.2:3000/epub/1");

public partial class LoginSite : ContentPage
{
    //private readonly HttpClient _httpClient;
    HttpClient client = new();

    public LoginSite()
	{
		InitializeComponent();
        //_httpClient = new HttpClient();
    }
    private async void OnLoginClicked(object sender, EventArgs e)
	{
        string username = LoginUserName.Text;
        string password = LoginUserPsw.Text;

        try
        {
            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, "http://10.0.2.2:443/test");
            HttpResponseMessage response = await client.SendAsync(request);

            if (response.IsSuccessStatusCode)
            {

                var content = response.Content;

                Debug.WriteLine(content);

            }
            else
            {
                throw new Exception($"Bad status : {response.StatusCode}, {response.Headers},{response.Content}");
            }
        }
        catch (Exception ex)
        {
            await DisplayAlert(ex.Message, ex.StackTrace, "ok");
            Debug.WriteLine(ex.Message + "ERROOOOOOR");

        }
        /*
        if (!string.IsNullOrEmpty( username) && !string.IsNullOrEmpty(password))
        {
            
            var loginRequest = new LoginRequest
            {
                Username = username,
                Password = password

               
            };
            Debug.Print(loginRequest.Username);

            try
            {
                var response = await _httpClient.PostAsJsonAsync("http://10.0.2.2:443/login", loginRequest);
                Debug.Print(response.Content.ToString());


                if (response.IsSuccessStatusCode)
                {
                    Debug.Print("okok");

                    var loginResponse = await response.Content.ReadFromJsonAsync<LoginResponse>();
                    Debug.Print("okok");


                    if (loginResponse != null && loginResponse.Message == "Estas conectado")
                    {
                        
                        await DisplayAlert("Éxito", loginResponse.Message, "OK");
                        // Navegar a la página UserSite
                        await Navigation.PushAsync(new UserSite());
                    }
                    else
                    {
                        await DisplayAlert("Error", "Respuesta inesperada del servidor", "OK");
                    }
                }
                else
                {
                    await DisplayAlert("Error", "No se pudo conectar al servidor", "OK");
                }
            }
            catch (Exception ex)
            {
                await DisplayAlert("Error", $"Ocurrió un error: {ex.Message}", "OK");
            }
        }
        else
        {
            await DisplayAlert("Error", "Usuario y contraseña deben ser números válidos", "OK");
        }
            */
    }
    private async void OnCreateAccountClicked(object sender, EventArgs e)
	{

	}

    public class LoginRequest
    {
        public string Username { get; set; }
        public string Password { get; set; }
    }
    public class LoginResponse
    {
        public string Message { get; set; }
    }
}