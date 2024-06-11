using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using FeelingsApp.ViewModel;
using Microsoft.Maui.Controls;

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

	}
    private async void GetDataUser()
    {
        //string username = await SecureStorage.GetAsync("username");
    }

    private async void OnLogoutClicked(object sender, EventArgs e)
    {
        SecureStorage.Remove("auth_token");
        SecureStorage.Remove("username");

        await Navigation.PushAsync(new LoginSite());
    }
    /*
     *Content = new StackLayout
           {
               Children = {
                   new Label { Text = $"{username}" },
               }
           };

       }*/

}