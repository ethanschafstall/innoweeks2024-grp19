using Android.Media;
using Microsoft.Maui.Graphics.Text;
using Newtonsoft.Json;
using System.Diagnostics;
using static FeelingsApp.FriendsSite;

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
            //feeling.BackgroundColor = selectedFeeling.Color;
            feelingButton.Text = selectedFeeling.Name;
            //feelingButton.BackgroundColor = GetColorForMood(feelingButton.Text);
            HomeImage.Source = GetHomeImgForMood(feelingButton.Text);
            FeelBcImg.Source = GetFeelBcForMood(feelingButton.Text);

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
                var request = new HttpRequestMessage(HttpMethod.Get, $"https://feelings.blue.section-inf.ch/user/{username}");
                request.Headers.Add("Cookie", $"authToken = {authToken}");
                //myFeelingLabel.Text = "waitingUser";

                try
                {                    
                    var responseUser = await client.SendAsync(request); 

                    if (responseUser.IsSuccessStatusCode)
                    {
                        var contentString = await responseUser.Content.ReadAsStringAsync();
                        var userResponse = JsonConvert.DeserializeObject<UserResponse>(contentString);


                        if (userResponse != null && userResponse.DecodedToken != null)
                        {
                            int userId = userResponse.DecodedToken.Id;

                            var requestFeeling = new HttpRequestMessage(HttpMethod.Get, $"https://feelings.blue.section-inf.ch/feelings/{userId}/last");
                            requestFeeling.Headers.Add("Cookie", $"authToken={authToken}");

                            var responseFeeling = await client.SendAsync(requestFeeling);

                            if (responseFeeling.IsSuccessStatusCode)
                            {
                                var contentStringFeeling = await responseFeeling.Content.ReadAsStringAsync();
                                var feelingResponse = JsonConvert.DeserializeObject<FeelingResponse>(contentStringFeeling);

                                if (feelingResponse != null && feelingResponse.Feeling != null)
                                {
                                    //myFeelingLabel.Text = feelingResponse.Feeling.FeeMood;

                                    FeelingResponse = feelingResponse.Feeling;
                                    feelingButton.Text = FeelingResponse.FeeMood;
                                    //feelingButton.BackgroundColor = GetColorForMood(feelingResponse.Feeling.FeeMood);
                                    //feeling.BackgroundColor = GetColorForMood(feelingResponse.Feeling.FeeMood);
                                    var feelingColor = GetColorForMood(feelingResponse.Feeling.FeeMood);
                                    HomeImage.Source = GetHomeImgForMood(feelingResponse.Feeling.FeeMood);

                                    await SecureStorage.SetAsync("FeeMood", feelingResponse.Feeling.FeeMood);
                                    await SecureStorage.SetAsync("BackgroundColorFeeling", feelingColor.ToString());

                                    await DisplayAlert("Last Feeling", $"Mood: {feelingResponse.Feeling.FkUser}, CreatedAt: {feelingResponse.Feeling.FeeCreatedAt}", "OK");
                                }
                            }
                        }
                    }
                    else
                    {
                        throw new Exception($"Bad status: {responseUser.StatusCode}");
                    }
                }
                catch (Exception ex)
                {
                    await DisplayAlert(ex.Message, ex.StackTrace, "ok");
                }
            }
            else
            {

            }
            
        }

        private Color GetColorForMood(string mood)
        {
            switch (mood)
            {
                case "Peur":
                    return Color.FromArgb("#7542fe");
                case "Amour":
                    return Color.FromArgb("#db91c5");
                case "Colère":
                    return Color.FromArgb("#ed201c");
                case "Joie":
                    return Color.FromArgb("#febe00");
                case "Calme":
                    return Color.FromArgb("#6BD219");
                case "Tristesse":
                    return Color.FromArgb("#0A97B6");
                default:
                    return Colors.DarkGray;
            }
        }
        private String GetIconForMood(string mood)
        {
            switch (mood)
            {
                case "Peur":
                    return "peur_logo.png";
                case "Amour":
                    return "amour_logo.png";
                case "Colère":
                    return "colere_logo.png";
                case "Joie":
                    return "joie_logo.png";
                case "Calme":
                    return "calme_logo.png";
                case "Tristesse":
                    return "tristesse_logo.png";
                default:
                    return "joie_logo.png";
            }
        }
        private String GetHomeImgForMood(string mood)
        {
            switch (mood)
            {
                case "Peur":
                    return "peur_home.png";
                case "Amour":
                    return "amour_home.png";
                case "Colère":
                    return "colere_home.png";
                case "Joie":
                    return "joie_home.png";
                case "Calme":
                    return "calme_home.png";
                case "Tristesse":
                    return "tristesse_home.png";
                default:
                    return "feelings_home_img.png";
            }
        }
        
            private String GetFeelBcForMood(string mood)
        {
            switch (mood)
            {
                case "Peur":
                    return "peur_background.png";
                case "Amour":
                    return "amour_background.png";
                case "Colère":
                    return "colere_background.png";
                case "Joie":
                    return "joie_background.png";
                case "Calme":
                    return "calme_background.png";
                case "Tristesse":
                    return "tristesse_background.png";
                default:
                    return "joie_background.png";
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
