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
    private void OnConfirmClicked(object sender, EventArgs e)
    {
        var selectedFeeling = FeelingListView.SelectedItem as Feeling;
        if (selectedFeeling != null)
        {
            // Navegar a la siguiente página y pasar el sentimiento seleccionado
            Navigation.PushAsync(new MainPage(selectedFeeling));
        }
        else
        {
            // Manejar el caso en que no se haya seleccionado ningún sentimiento
            // Mostrar un mensaje de error, etc.
        }
    }
    public class Feeling
    {
        public string Name { get; set; }
        public Color Color { get; set; }
    }

}