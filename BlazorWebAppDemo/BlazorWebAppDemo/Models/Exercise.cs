namespace BlazorWebAppDemo.Models
{
    public class Exercise
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public string Description { get; set; }
        public int DurationInMinutes { get; set; } = 0;
    }
}
