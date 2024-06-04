using System.Collections.ObjectModel;

namespace FeelingsApp;

public partial class FeelingsSite : ContentPage
{
    public ObservableCollection<Feeling> Feelings { get; set; }

    public FeelingsSite()
	{
		InitializeComponent();
        Feelings = new ObservableCollection<Feeling>
            {
                new Feeling { Name = "Triste", Color = Colors.Green},
                new Feeling { Name = "Heureux",  Color =  Colors.Blue},

            };

        FeelingListView.ItemsSource = Feelings;
    }
    public class Feeling
    {
        public string Name { get; set; }
        public Color Color { get; set; }
    }

}