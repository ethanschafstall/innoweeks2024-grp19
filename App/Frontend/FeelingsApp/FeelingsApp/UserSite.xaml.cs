using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using FeelingsApp.ViewModel;
using Microsoft.Maui.Controls;
using Newtonsoft.Json;

namespace FeelingsApp;

public partial class UserSite : ContentPage
{
    HttpClient client = new();
    //public Feeling FeelingResponseT { get; set; }
    public Feeling FeelingResponseUserInfo { get; set; }

    public UserSite()
	{
		InitializeComponent();
        BindingContext = this;

        _ = RetrieveAndSetFeelingAsync();


    }

    private async Task RetrieveAndSetFeelingAsync()
    {
        try
        {
            var feeMood = await SecureStorage.GetAsync("FeeMood");
            var backgroundColorString = await SecureStorage.GetAsync("BackgroundColorFeeling");
           var userNameString= await SecureStorage.GetAsync("username");
            userName.Text = $"{userNameString} est";

            if (!string.IsNullOrEmpty(feeMood))
            {
                myUserFeeling.Text = feeMood;
            }

            if (!string.IsNullOrEmpty(backgroundColorString))
            {
                if (Color.TryParse(backgroundColorString, out Color backgroundColor))
                {
                    //myUserColor.Background = backgroundColor;
                }
            }
            //myUserColor.BackgroundColor = GetColorForMood(feeMood);
        }
        catch (Exception ex)
        {
            await DisplayAlert("Error", $"Error retrieving data: {ex.Message}", "OK");
        }
    }


    private async void OnLogoutClicked(object sender, EventArgs e)
    {
        SecureStorage.Remove("auth_token");
        SecureStorage.Remove("username");

        await Navigation.PushAsync(new LoginSite());
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
