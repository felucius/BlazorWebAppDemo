namespace BlazorWebAppDemo.Models
{
    public class ExerciseProgram
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; } = string.Empty;
        public List<Exercise> Exercises { get; set; } = [];
    }
}
