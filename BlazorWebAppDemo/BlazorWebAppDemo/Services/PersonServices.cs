using BlazorWebAppDemo.Models;

namespace BlazorWebAppDemo.Services
{
    public class PersonServices
    {
        public static List<Person> GetPersons()
        {
            return CreatePersonsList();
        }

        private static List<Person> CreatePersonsList()
        {
            return new List<Person>()
            {
                new() { Id = 1, Name = "Maxime", Age = 30 },
                new() { Id = 2, Name = "Alice", Age = 25 },
            };
        }
    }
}
