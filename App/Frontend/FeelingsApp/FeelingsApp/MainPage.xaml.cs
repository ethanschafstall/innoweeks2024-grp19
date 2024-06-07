using Android.Media;
using Microsoft.Maui.Graphics.Text;
using Newtonsoft.Json;
using System.Diagnostics;

namespace FeelingsApp
{
    public partial class MainPage : ContentPage
    {
        int count = 0;
        HttpClient client = new();
        public Feeling FeelingResponse { get; set; }


        public MainPage()
        {
            InitializeComponent();
            //GetColors();
            BindingContext = new FeelingsSite();
            
        }
        public MainPage(FeelingsSite.Feeling selectedFeeling)
        {
            InitializeComponent();
            BindingContext = new FeelingsSite();
            feeling.BackgroundColor = selectedFeeling.Color;
            myFeelingLabel.Text = selectedFeeling.Name;

        }

        //private void OnCounterClicked(object sender, EventArgs e)
        //{
        //    count++;

        //    if (count == 1)
        //        CounterBtn.Text = $"Clicked {count} time";
        //    else
        //        CounterBtn.Text = $"Clicked {count} times";

        //    SemanticScreenReader.Announce(CounterBtn.Text);
        //}
        private async void OnNavigateToFeelingsSite(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new FeelingsSite()); 
        }

        private async void GetColors(object sender, EventArgs e)
        {
            var username = await SecureStorage.GetAsync("username");
            var authToken = await SecureStorage.GetAsync("auth_token");

            if (!string.IsNullOrEmpty(username))
            {
                //User connect
                var request = new HttpRequestMessage(HttpMethod.Get, $"http://10.0.2.2:443/user/{username}");
                request.Headers.Add("Cookie", $"authToken = {authToken}");
                //myFeelingLabel.Text = "waitingUser";

                try
                {                    
                    var responseUser = await client.SendAsync(request); 
                    myFeelingLabel.Text = "waitingData";

                    if (responseUser.IsSuccessStatusCode)
                    {
                        var contentString = await responseUser.Content.ReadAsStringAsync();
                        var userResponse = JsonConvert.DeserializeObject<UserResponse>(contentString);


                        if (userResponse != null && userResponse.DecodedToken != null)
                        {
                            int userId = userResponse.DecodedToken.Id;

                            var requestFeeling = new HttpRequestMessage(HttpMethod.Get, "http://10.0.2.2:443/feeling/3/last");
                            requestFeeling.Headers.Add("Cookie", $"authToken={authToken}");

                            var responseFeeling = await client.SendAsync(requestFeeling);

                            if (responseFeeling.IsSuccessStatusCode)
                            {
                                var contentStringFeeling = await responseFeeling.Content.ReadAsStringAsync();
                                var feelingResponse = JsonConvert.DeserializeObject<FeelingResponse>(contentStringFeeling);

                                if (feelingResponse != null && feelingResponse.Feeling != null)
                                {
                                    myFeelingLabel.Text = feelingResponse.Feeling.FeeMood;

                                    FeelingResponse = feelingResponse.Feeling;
                                    feeling.BackgroundColor = GetColorForMood(feelingResponse.Feeling.FeeMood);

                                    //var feelingService = DependencyService.Get<IFeelingService>();
                                    //feelingService.CurrentFeeling = feelingResponse.Feeling;

                                    await DisplayAlert("Last Feeling", $"Mood: {feelingResponse.Feeling.FkUser}, CreatedAt: {feelingResponse.Feeling.FeeCreatedAt}", "OK");
                                }
                            }


                            //await DisplayAlert("User ID", $"The user ID is {userId}", "OK");
                        }

                        //await DisplayAlert("Response", contentString, "OK");
                    }
                    else
                    {
                        throw new Exception($"Bad status: {responseUser.StatusCode}");

                    }


                }
                catch (Exception ex)
                {
                    await DisplayAlert(ex.Message, ex.StackTrace, "ok");
                    myFeelingLabel.Text = "NotwaitingData";

                }
            }
            else
            {
                //User not connect
                FeelingResponse.FeeMood = "Not data";
                myFeelingLabel.Text = "Not Data";
            }
            
        }

        private Color GetColorForMood(string mood)
        {
            switch (mood)
            {
                case "Joie":
                    return Colors.Yellow;
                case "Colère":
                    return Colors.Red;
                default:
                    return Colors.Gray; 
            }
        }

    }


    public class DecodedToken
    {
        public string Username { get; set; }
        public int Id { get; set; }
        public string Role { get; set; }
        public long Iat { get; set; }
        public long Exp { get; set; }
    }

    public class UserResponse
    {
        public DecodedToken DecodedToken { get; set; }
    }
    public class Feeling
    {
        public string FeeMood { get; set; }
        public DateTime FeeCreatedAt { get; set; }
        public int FkUser { get; set; }
    }
    public class FeelingResponse
    {
        public Feeling Feeling { get; set; }
    }
}
