using Microsoft.Maui.Controls;
using Microsoft.Maui.Graphics;
using Newtonsoft.Json;
using System.Collections.ObjectModel;

namespace FeelingsApp;

public partial class FriendsSite : ContentPage
{
   
    public ObservableCollection<Friend> Friends { get; set; }

    HttpClient client = new();

    public FriendsSite()
	{
		InitializeComponent();
        Friends = new ObservableCollection<Friend>();
        GetFriendsFeelings(); 
        LoadLocalFriends();

        FriendsListView.ItemsSource = Friends;



    }
    private async void LoadLocalFriends()
    {
        // Ejemplo de datos locales de amigos
        Friends.Add(new Friend { Name = "Alice", Status = "Calme", Color = Colors.Green , ImgStatus=GetImgForMood("Calme")           ,
            IconStatus = GetIconForMood("Calme")
        });
        Friends.Add(new Friend { Name = "Bob", Status = "Triste", Color = Colors.Blue, ImgStatus=GetImgForMood("Tristesse"),IconStatus = GetIconForMood("Tristesse")
        });
    }
    private async void OnAddFriendButtonClicked(object sender, EventArgs e)
    {
        // Navegar a la página FriendFormPage
        await Navigation.PushAsync(new FriendFormPage());
    }

    private async void GetFriendsFeelings()
    {

        try
        {
            var authToken = await SecureStorage.GetAsync("auth_token");

            if (string.IsNullOrEmpty(authToken))
            {
                // Manejar el caso donde no se proporciona un authToken
                return;
            }

            var request = new HttpRequestMessage(HttpMethod.Get, "https://feelings.blue.section-inf.ch/friends/feelings");
            request.Headers.Add("Cookie", $"authToken={authToken}");

            var response = await client.SendAsync(request);

            if (response.IsSuccessStatusCode)
            {
                var content = await response.Content.ReadAsStringAsync();
                var feelingsResponse = JsonConvert.DeserializeObject<FriendsResponse>(content);

                if (feelingsResponse != null && feelingsResponse.Feelings != null)
                {
                    foreach (var feeling in feelingsResponse.Feelings)
                    {
                        // Agregar sentimientos recuperados a la lista de amigos
                        Friends.Add(new Friend
                        {
                            Name = feeling.UseUsername,  // Asignar el nombre del usuario como se muestra en el ejemplo
                            Status = feeling.FeeMood,    // Asignar el estado de ánimo como se muestra en el ejemplo
                            Color = GetColorForMood(feeling.FeeMood),  // Obtener el color según el estado de ánimo
                            ImgStatus = GetImgForMood(feeling.FeeMood),
                            IconStatus = GetIconForMood(feeling.FeeMood)
                        }); ;
                    }
                }
            }
            else
            {
            }
        }
        catch (Exception ex)
        {
            // Manejar cualquier excepción ocurrida durante la solicitud
            Console.WriteLine($"Error: {ex.Message}");
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
    private String GetImgForMood(string mood)
    {
        //switch (mood)
        //{
        //    case "Peur":
        //        return "peur_img.png";
        //    case "Amour":
        //        return "amour_img.png";
        //    case "Colère":
        //        return "colere_img.png";
        //    case "Joie":
        //        return "joie_img.png";
        //    case "Calme":
        //        return "calme_img.png";
        //    case "Tristesse":
        //        return "tristesse_img.png";
        //    default:
        //        return "joie_img.png";
        //}

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
    public class FriendsResponse
    {
        public List<FriendFeeling> Feelings { get; set; }
    }
    public class FriendFeeling
    {
        public string FeeMood { get; set; }
        public string UseUsername { get; set; }
    }
    public class Friend
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public Color Color { get; set; }
        
        public string ImgStatus { get; set; }
        

        public string IconStatus { get; set; }
    }
    public class FeelingsResponse
    {
        public List<Feeling> Feelings { get; set; }
    }
    public class Feeling
    {
        public string feeMood { get; set; }
        public string useUsername { get; set; }
    }
}