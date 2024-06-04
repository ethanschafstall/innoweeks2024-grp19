using Microsoft.Maui.Controls;
using Microsoft.Maui.Graphics;
using System.Collections.ObjectModel;

namespace FeelingsApp;

public partial class FriendsSite : ContentPage
{
    public ObservableCollection<Friend> Friends { get; set; }

    public FriendsSite()
	{
		InitializeComponent();

        Friends = new ObservableCollection<Friend>
            {
                new Friend { Name = "Alice", Status = "Timide", Color = Colors.Green},
                new Friend { Name = "Bob", Status = "Triste", Color =  Colors.Blue},

            };

        FriendsListView.ItemsSource = Friends;
    }
    public class Friend
    {
        public string Name { get; set; }
        public string Status { get; set; }
        public Color Color { get; set; }
    }
}