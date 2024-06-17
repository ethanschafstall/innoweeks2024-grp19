using Microsoft.Maui.Controls;
namespace FeelingsApp
{
    public partial class AppShell : Shell
    {
        public bool IsUserConnect { get; set; }
        public bool IsNotConnect { get; set; }

        public AppShell()
        {
            InitializeComponent();

            IsUserConnect = !string.IsNullOrEmpty(SecureStorage.GetAsync("username").Result);
            IsNotConnect = string.IsNullOrEmpty(SecureStorage.GetAsync("username").Result);

            BindingContext = this;
        }
        

    }
}
