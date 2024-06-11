using System.Collections.ObjectModel;
using Android.Media;
using Microsoft.Maui.Graphics.Text;
using Newtonsoft.Json;
using System.Diagnostics;
namespace FeelingsApp;
using System.Net.Http.Json;
using System.Net.Http.Headers;

public partial class FeelingsSite : ContentPage
{
    public ObservableCollection<Feeling> Feelings { get; set; }
    HttpClient client = new();

    public FeelingsSite()
	{
		InitializeComponent();
        Feelings = new ObservableCollection<Feeling>
            {
                new Feeling { Name = "Joie", Color = Colors.Yellow},
                new Feeling { Name = "Col�re",  Color =  Colors.Red},
                new Feeling { Name = "Peur",  Color =  Colors.Violet},
                new Feeling { Name = "Tristesse",  Color =  Colors.Blue},
                new Feeling { Name = "Surpsie",  Color =  Colors.DarkBlue},
                new Feeling { Name = "D�go�t",  Color =  Colors.Gray},
                new Feeling { Name = "Honte",  Color =  Colors.DarkMagenta},                
                new Feeling { Name = "Confiance",  Color =  Colors.Green},
            };

        FeelingListView.ItemsSource = Feelings;
    }
    private async void OnConfirmClicked(object sender, EventArgs e)
    {
        var selectedFeeling = FeelingListView.SelectedItem as Feeling;
        if (selectedFeeling != null)
        {

            await SecureStorage.SetAsync("FeeMood", selectedFeeling.Name);
            await SecureStorage.SetAsync("BackgroundColor", selectedFeeling.Color.ToString());

            // Recuperar el authToken del SecureStorage
            var authToken = await SecureStorage.GetAsync("auth_token");
            if (string.IsNullOrEmpty(authToken))
            {
                await DisplayAlert("Error", "User is not authenticated.", "OK");
                return;
            }

            // Crear el objeto feelingRequest
            var feelingRequest = new
            {
                mood = selectedFeeling.Name
            };

            // Enviar la solicitud POST
            client.DefaultRequestHeaders.Add("Cookie", $"authToken={authToken}");
            var response = await client.PostAsJsonAsync("http://10.0.2.2:443/feeling", feelingRequest);

            if (response.IsSuccessStatusCode)
            {
                // Navegar a la siguiente p�gina y pasar el sentimiento seleccionado
                await Navigation.PushAsync(new MainPage(selectedFeeling));
            }
            else
            {
                await DisplayAlert("Error", "Failed to confirm feeling.", "OK");
            }
        }
        else
        {
     
        }
    }

    public class Feeling
    {
        public string Name { get; set; }
        public Color Color { get; set; }
    }

}