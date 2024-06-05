using System;
using System.Diagnostics;
using System.IO.Compression;
using System.Net;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using System.Xml;
using Microsoft.Maui.Controls;
using Org.Apache.Http.Client;
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
            var loginRequest = new LoginRequest
            {
                Username = username,
                Password = password
            };

            var postResponse = await client.PostAsJsonAsync("http://10.0.2.2:443/login", loginRequest);
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
            Debug.WriteLine(ex.Message );

        }        
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

            var postResponse = await client.PostAsJsonAsync("http://10.0.2.2:443/register", signInRequest);
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
            Debug.WriteLine(ex.Message );

        }
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
    }
}
//CODE TO TRY
//            HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, "http://10.0.2.2:443/test");
//          Debug.WriteLine(request);

//        HttpResponseMessage response = await client.SendAsync(request);

//var response = await client.GetAsync("http://10.0.2.2:443/test"); //WORKS
