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
        BindingContext = new UserViewModel();

        //var feelingService = DependencyService.Get<IFeelingService>();
        //var feeling = feelingService.CurrentFeeling;

        //// Usar el Feeling recuperado
        //if (feeling != null)
        //{
        //    BindingContext = feeling;
        //    myUserFeeling.Text = feeling.FeeMood;
        //    myUserColor.BackgroundColor = GetColorForMood(feeling.FeeMood);

        //}

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
