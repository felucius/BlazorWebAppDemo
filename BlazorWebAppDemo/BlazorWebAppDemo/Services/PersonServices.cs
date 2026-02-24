using BlazorWebAppDemo.Models;

namespace BlazorWebAppDemo.Services
{
    public class PersonServices
    {
        public List<Person> GetPersons()
        {
            return CreatePersonsList();
        }

        private List<Person> CreatePersonsList()
        {
            return new List<Person>()
            {
                new() { Id = 1, Name = "Maxime", Age = 30 },
                new() { Id = 2, Name = "Alice", Age = 25 },
            };
        }
    }
}
