using Microsoft.Maui.Controls;
using Microsoft.Maui.Graphics;
using System.Collections.ObjectModel;

namespace FeelingsApp;

public partial class FriendsSite : ContentPage
{
    public ObservableCollection<Friend> Friends { get; set; }
    public ObservableCollection<string> GroupsList { get; set; } = new ObservableCollection<string>();

    public FriendsSite()
	{
		InitializeComponent();

        Friends = new ObservableCollection<Friend>
            {
                new Friend { Name = "Alice", Status = "Timide", Color = Colors.Green},
                new Friend { Name = "Bob", Status = "Triste", Color =  Colors.Blue},

            };

        FriendsListView.ItemsSource = Friends;
        BindingContext = this;


    }

    private async void OnAddFriendButtonClicked(object sender, EventArgs e)
    {
        // Navegar a la página FriendFormPage
        await Navigation.PushAsync(new FriendFormPage());
    }

    public class Friend
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public Color Color { get; set; }

    }
    private void LoadGroups()
    {
        // Simulación de carga de grupos desde una fuente de datos
        GroupsList.Add("Tous");
        GroupsList.Add("Amis");
        GroupsList.Add("Family");
        GroupsList.Add("Travail");
    }
}