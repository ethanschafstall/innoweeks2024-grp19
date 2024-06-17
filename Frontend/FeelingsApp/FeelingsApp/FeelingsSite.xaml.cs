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
                new Feeling { Name = "Peur", Color = Color.FromArgb("#7542fe")},
                new Feeling { Name = "Amour",  Color =  Color.FromArgb("#db91c5")},
                new Feeling { Name = "Colère",  Color =  Color.FromArgb("#ed201c")},
                new Feeling { Name = "Joie",  Color =  Color.FromArgb("#febe00")},
                new Feeling { Name = "Calme",  Color =  Color.FromArgb("#6BD219")},
                new Feeling { Name = "Tristesse",  Color =  Color.FromArgb("#0A97B6")}
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
            var response = await client.PostAsJsonAsync("https://feelings.blue.section-inf.ch/feelings", feelingRequest);

            if (response.IsSuccessStatusCode)
            {
                // Navegar a la siguiente página y pasar el sentimiento seleccionado
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