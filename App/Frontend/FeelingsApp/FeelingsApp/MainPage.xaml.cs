namespace FeelingsApp
{
    public partial class MainPage : ContentPage
    {
        int count = 0;

        public MainPage()
        {
            InitializeComponent();
            BindingContext = new FeelingsSite();
        }
        public MainPage(FeelingsSite.Feeling selectedFeeling)
        {
            InitializeComponent();
            BindingContext = new FeelingsSite();
            feeling.BackgroundColor = selectedFeeling.Color;
            myFeelingLabel.Text = selectedFeeling.Name;

        }

        //private void OnCounterClicked(object sender, EventArgs e)
        //{
        //    count++;

        //    if (count == 1)
        //        CounterBtn.Text = $"Clicked {count} time";
        //    else
        //        CounterBtn.Text = $"Clicked {count} times";

        //    SemanticScreenReader.Announce(CounterBtn.Text);
        //}
        private async void OnNavigateToFeelingsSite(object sender, EventArgs e)
        {
            await Navigation.PushAsync(new FeelingsSite()); 
        }
    }

}
